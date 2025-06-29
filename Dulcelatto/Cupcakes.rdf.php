<?php
if (empty($noHeaders)) {
    header('Content-Type: application/rdf+xml');
}
include 'includes/db_connect.php';

try {
    // Buscar la categoría "Cupcakes"
    $query = "SELECT id_catg, nombr_catg FROM categorias WHERE nombr_catg = 'Cupcakes'";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        echo "<!-- No se encontró la categoría 'Cupcakes' -->";
        exit;
    }

    $row = $result->fetch_assoc();
    $cat_id = $row['id_catg'];
    $cat_name = $row['nombr_catg'];
    $stmt->close();

    // Obtener productos de esa categoría
    $query = "SELECT id, nombre, precio FROM productos WHERE id_catg = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $cat_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $products = [];
    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }
    $stmt->close();
} catch (Exception $e) {
    echo "<!-- Error: " . $e->getMessage() . " -->";
    exit;
}
?>

<rdf:RDF
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:dl="https://yourdulcelatto.com/postres#">

   <!-- Recurso principal de Postres -->
   <rdf:Description rdf:about="https://yourdulcelatto.com/postres">
      <dl:contieneCategoria rdf:resource="https://yourdulcelatto.com/postres/categoria/<?php echo $cat_id; ?>"/>
   </rdf:Description>

   <!-- Categoría "Cupcakes" -->
   <rdf:Description rdf:about="https://yourdulcelatto.com/postres/categoria/<?php echo $cat_id; ?>">
      <dl:nombre><?php echo htmlspecialchars($cat_name); ?></dl:nombre>
      <?php foreach ($products as $product): ?>
         <dl:contienePostre rdf:resource="https://yourdulcelatto.com/postres/<?php echo $product['id']; ?>"/>
      <?php endforeach; ?>
   </rdf:Description>

   <!-- Recursos de productos -->
   <?php foreach ($products as $product): ?>
      <rdf:Description rdf:about="https://yourdulcelatto.com/postres/<?php echo $product['id']; ?>">
         <dl:nombre><?php echo htmlspecialchars($product['nombre']); ?></dl:nombre>
         <dl:precio><?php echo htmlspecialchars($product['precio']); ?></dl:precio>
         <dl:categoria><?php echo htmlspecialchars($cat_name); ?></dl:categoria>
      </rdf:Description>
   <?php endforeach; ?>

</rdf:RDF>

