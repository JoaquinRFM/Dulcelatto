<?php
include '../includes/db_connect.php';
header('Content-Type: application/json');

if (!isset($_POST['id_carrito'])) {
    echo json_encode(['status' => 'error', 'message' => 'Falta id_carrito']);
    exit;
}

$id_carrito = intval($_POST['id_carrito']);
$stmt = $conn->prepare("DELETE FROM carrito WHERE id_carrito = ?");
$stmt->bind_param("i", $id_carrito);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'message' => 'Producto eliminado del carrito']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'No se pudo eliminar']);
}
$stmt->close();
$conn->close();