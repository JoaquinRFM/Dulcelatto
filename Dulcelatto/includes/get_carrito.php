<?php
include '../includes/db_connect.php';
header('Content-Type: application/json');

if (!isset($_GET['user_id'])) {
    echo json_encode(['status' => 'error', 'message' => 'Falta user_id']);
    exit;
}

$user_id = $_GET['user_id'];

$sql = "SELECT c.id_carrito, c.cantidad, p.nombre, p.precio, p.descripcion
        FROM carrito c
        JOIN productos p ON c.id_producto = p.id
        WHERE c.id_usuario = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

$carrito = [];
while ($row = $result->fetch_assoc()) {
    $carrito[] = $row;
}

echo json_encode(['status' => 'success', 'carrito' => $carrito]);
$stmt->close();
$conn->close();
?>