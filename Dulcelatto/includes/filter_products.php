<?php
session_start();
include 'db_connect.php';

header('Content-Type: application/json');

try {
    $categoria = isset($_GET['categoria']) ? mysqli_real_escape_string($conn, $_GET['categoria']) : '';
    $min_price = isset($_GET['min_price']) ? floatval($_GET['min_price']) : 0;
    $max_price = isset($_GET['max_price']) ? floatval($_GET['max_price']) : 999999;
    $sort = isset($_GET['sort']) ? mysqli_real_escape_string($conn, $_GET['sort']) : 'nombre ASC';

    $query = "SELECT p.id, p.nombre, p.descripcion, p.precio, p.imagen, c.nombr_catg
              FROM productos p
              JOIN categorias c ON p.id_catg = c.id_catg
              WHERE p.precio BETWEEN ? AND ?";
    $params = [$min_price, $max_price];
    $types = "dd";

    if ($categoria) {
        $query .= " AND c.nombr_catg = ?";
        $params[] = $categoria;
        $types .= "s";
    }

    $query .= " ORDER BY ";
    if ($sort === 'precio_asc') {
        $query .= "p.precio ASC";
    } elseif ($sort === 'precio_desc') {
        $query .= "p.precio DESC";
    } else {
        $query .= "p.nombre ASC";
    }

    $stmt = $conn->prepare($query);
    $stmt->bind_param($types, ...$params);
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