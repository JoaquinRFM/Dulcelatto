<?php
header('Content-Type: application/rdf+xml');
include 'includes/db_connect.php';

// Fetch all categories
try {
    $query = "SELECT id_catg, nombr_catg FROM categorias";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $result = $stmt->get_result();
    $categories = [];
    while ($row = $result->fetch_assoc()) {
        $categories[$row['id_catg']] = $row['nombr_catg'];
    }
    $stmt->close();
} catch (Exception $e) {
    echo "<!-- Error fetching categories: " . $e->getMessage() . " -->";
    exit;
}

// Fetch all products, grouped by category
$products_by_category = [];
foreach (array_keys($categories) as $cat_id) {
    try {
        $query = "SELECT id, nombre, precio FROM productos WHERE id_catg = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $cat_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $products = [];
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
        $products_by_category[$cat_id] = $products;
        $stmt->close();
    } catch (Exception $e) {
        echo "<!-- Error fetching products for category $cat_id: " . $e->getMessage() . " -->";
        exit;
    }
}
?>

<rdf:RDF
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:dl="https://yourdulcelatto.com/postres#">

   <!-- Top-level Postres resource -->
   <rdf:Description rdf:about="https://yourdulcelatto.com/postres">
      <?php foreach ($categories as $cat_id => $cat_name): ?>
         <dl:contieneCategoria rdf:resource="https://yourdulcelatto.com/postres/categoria/<?php echo $cat_id; ?>"/>
      <?php endforeach; ?>
   </rdf:Description>

   <!-- Category resources -->
   <?php foreach ($categories as $cat_id => $cat_name): ?>
      <rdf:Description rdf:about="https://yourdulcelatto.com/postres/categoria/<?php echo $cat_id; ?>">
         <dl:nombre><?php echo htmlspecialchars($cat_name); ?></dl:nombre>
         <?php foreach ($products_by_category[$cat_id] as $product): ?>
            <dl:contienePostre rdf:resource="https://yourdulcelatto.com/postres/<?php echo $product['id']; ?>"/>
         <?php endforeach; ?>
      </rdf:Description>
   <?php endforeach; ?>

   <!-- Product resources -->
   <?php foreach ($products_by_category as $cat_id => $products): ?>
      <?php foreach ($products as $product): ?>
         <rdf:Description rdf:about="https://yourdulcelatto.com/postres/<?php echo $product['id']; ?>">
            <dl:nombre><?php echo htmlspecialchars($product['nombre']); ?></dl:nombre>
            <dl:precio><?php echo htmlspecialchars($product['precio']); ?></dl:precio>
            <dl:categoria><?php echo htmlspecialchars($categories[$cat_id]); ?></dl:categoria>
         </rdf:Description>
      <?php endforeach; ?>
   <?php endforeach; ?>

</rdf:RDF>