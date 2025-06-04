<?php
// Asegurarse de que no haya espacios ni salidas antes de este punto
//Establece que la respuesta del servidor será en formato JSON
header('Content-Type: application/json');

// Incluir el archivo de conexión a la base de datos
include 'db_connect.php';

// Verificar si ya se devolvió un error de conexión
if (isset($conn->connect_error) && $conn->connect_error) {
    echo json_encode(['error' => 'Error de conexión: ' . $conn->connect_error]);
    exit();
}

try {
    // Consultar los productos agrupados por categoría
    $query = "
        SELECT c.nombr_catg AS categoria,p.id,p.nombre, p.descripcion, 
        p.precio AS price, p.imagen, '' AS rating, 'Disponible' AS availability 
        FROM productos p
        JOIN categorias c ON p.id_catg = c.id_catg
        ORDER BY c.nombr_catg, p.nombre";

    //Verifica que la consulta se haya preparado correctamente
    $stmt = $conn->prepare($query);
    if (!$stmt) {
        throw new Exception("Error al preparar la consulta: " . $conn->error);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    // Crear un arreglo para agrupar los productos por categoría
    $productosPorCategoria = [];
    while ($row = $result->fetch_assoc()) {
        $categoria = $row['categoria'];
        if (!isset($productosPorCategoria[$categoria])) {
            $productosPorCategoria[$categoria] = [];
        }
        $productosPorCategoria[$categoria][] = $row;
    }

    //Cierra la consulta
    $stmt->close();

    // // Devolver los productos agrupados como JSON
    echo json_encode($productosPorCategoria);
} catch (Exception $e) {
    // En caso de error, devolver un mensaje de error como JSON
    echo json_encode(['error' => 'Error al consultar los productos: ' . $e->getMessage()]);
}
?>