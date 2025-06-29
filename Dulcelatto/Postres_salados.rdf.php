<?php
header('Content-Type: application/rdf+xml');
include 'includes/db_connect.php';

try {
    // Buscar la categoría "Postres salados"
    $query = "SELECT id_catg, nombr_catg FROM categorias WHERE nombr_catg = 'Postres salados'";
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $result = $stmt->get_result();

    // Si no se encuentra la categoría, salir
    if ($result->num_rows === 0) {
        echo "<!-- No se encontró la categoría 'Postres salados' -->";
        exit;
    }

    $row = $result->fetch_assoc();
    $salados_id = $row['id_catg'];
    $salados_nombre = $row['nombr_catg'];
    $stmt->close();

    // Obtener los productos de esa categoría
    $query = "SELECT id, nombre, precio FROM productos WHERE id_catg = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $salados_id);
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
      <dl:contieneCategoria rdf:resource="https://yourdulcelatto.com/postres/categoria/<?php echo $salados_id; ?>"/>
   </rdf:Description>

   <!-- Categoría "Postres salados" -->
   <rdf:Description rdf:about="https://yourdulcelatto.com/postres/categoria/<?php echo $salados_id; ?>">
      <dl:nombre><?php echo htmlspecialchars($salados_nombre); ?></dl:nombre>
      <?php foreach ($products as $product): ?>
         <dl:contienePostre rdf:resource="https://yourdulcelatto.com/postres/<?php echo $product['id']; ?>"/>
      <?php endforeach; ?>
   </rdf:Description>

   <!-- Recursos de productos -->
   <?php foreach ($products as $product): ?>
      <rdf:Description rdf:about="https://yourdulcelatto.com/postres/<?php echo $product['id']; ?>">
         <dl:nombre><?php echo htmlspecialchars($product['nombre']); ?></dl:nombre>
         <dl:precio><?php echo htmlspecialchars($product['precio']); ?></dl:precio>
         <dl:categoria><?php echo htmlspecialchars($salados_nombre); ?></dl:categoria>
      </rdf:Description>
   <?php endforeach; ?>

</rdf:RDF>