<?php
// Asegurarse de que no haya espacios ni salidas antes de este punto
header('Content-Type: application/json');

// Incluir el archivo de conexión a la base de datos
include 'db_connect.php';

// Verificar si ya se devolvió un error de conexión
if (isset($conn->connect_error) && $conn->connect_error) {
    echo json_encode(['error' => 'Error de conexión: ' . $conn->connect_error]);
    exit();
}

try {
    // Consultar los productos desde la base de datos
    // Renombramos 'precio' a 'price' y añadimos 'rating' y 'availability'
    $query = "SELECT id, nombre, descripcion, precio AS price, imagen,  '' AS rating, 'Disponible' AS availability  FROM productos";
  
    
    
    $stmt = $conn->prepare($query);
    if (!$stmt) {
        throw new Exception("Error al preparar la consulta: " . $conn->error);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    $productos = [];
    while ($row = $result->fetch_assoc()) {
        $productos[] = $row;
    }

    $stmt->close();

    // Devolver los productos como JSON
    echo json_encode($productos);
} catch (Exception $e) {
    // En caso de error, devolver un mensaje de error como JSON
    echo json_encode(['error' => 'Error al consultar los productos: ' . $e->getMessage()]);
}
?>