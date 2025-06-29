<?php
session_start();
include 'db_connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Debes iniciar sesión']);
    exit;
}

try {
    $id_usuario = $_SESSION['user_id'];
    $query = "
        SELECT c.id_carrito, c.id_producto, c.cantidad, p.nombre, p.precio, p.imagen
        FROM carrito c
        JOIN productos p ON c.id_producto = p.id
        WHERE c.id_usuario = ?
        ORDER BY c.fecha_agregado DESC";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $id_usuario);
    $stmt->execute();
    $result = $stmt->get_result();

    $carrito = [];
    $total = 0;
    while ($row = $result->fetch_assoc()) {
        $subtotal = $row['cantidad'] * $row['precio'];
        $row['subtotal'] = number_format($subtotal, 2, '.', '');
        $total += $subtotal;
        $carrito[] = $row;
    }

    echo json_encode([
        'success' => true,
        'carrito' => $carrito,
        'total' => number_format($total, 2, '.', '')
    ]);

    $stmt->close();
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

$conn->close();
?>