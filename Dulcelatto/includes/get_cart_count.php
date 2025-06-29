<?php
session_start();
include 'db_connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => true, 'count' => 0]);
    exit;
}

try {
    $id_usuario = $_SESSION['user_id'];
    $stmt = $conn->prepare("SELECT SUM(cantidad) as total_items FROM carrito WHERE id_usuario = ?");
    $stmt->bind_param("i", $id_usuario);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();

    $count = $row['total_items'] ? intval($row['total_items']) : 0;
    echo json_encode(['success' => true, 'count' => $count]);

    $stmt->close();
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

$conn->close();
?>