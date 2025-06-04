<?php
session_start();
include 'db_connect.php';

header('Content-Type: application/json');

if (!isset($_GET['query'])) {
    echo json_encode(['success' => false, 'message' => 'Consulta de búsqueda no proporcionada']);
    exit;
}

try {
    $query = '%' . mysqli_real_escape_string($conn, $_GET['query']) . '%';
    $stmt = $conn->prepare("
        SELECT p.id, p.nombre, p.descripcion, p.precio, p.imagen, c.nombr_catg
        FROM productos p
        JOIN categorias c ON p.id_catg = c.id_catg
        WHERE p.nombre LIKE ? OR c.nombr_catg LIKE ?
        LIMIT 20
    ");
    $stmt->bind_param("ss", $query, $query);
    $stmt->execute();
    $result = $stmt->get_result();

    $productos = [];
    while ($row = $result->fetch_assoc()) {
        $productos[] = [
            'id' => $row['id'],
            'nombre' => $row['nombre'],
            'descripcion' => $row['descripcion'],
            'price' => number_format($row['precio'], 2, '.', ''),
            'imagen' => $row['imagen'],
            'categoria' => $row['nombr_catg']
        ];
    }

    echo json_encode(['success' => true, 'productos' => $productos]);
    $stmt->close();
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

$conn->close();
?>