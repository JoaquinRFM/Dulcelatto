<?php
session_start();
include 'db_connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Debes iniciar sesión']);
    exit;
}

if (!isset($_POST['action']) || !isset($_POST['id_carrito'])) {
    echo json_encode(['success' => false, 'message' => 'Datos incompletos']);
    exit;
}

$id_usuario = $_SESSION['user_id'];
$id_carrito = intval($_POST['id_carrito']);
$action = $_POST['action'];

try {
    if ($action === 'update' && isset($_POST['cantidad'])) {
        $cantidad = intval($_POST['cantidad']);
        if ($cantidad <= 0) {
            // Eliminar si la cantidad es 0
            $stmt = $conn->prepare("DELETE FROM carrito WHERE id_carrito = ? AND id_usuario = ?");
            $stmt->bind_param("ii", $id_carrito, $id_usuario);
        } else {
            // Actualizar cantidad
            $stmt = $conn->prepare("UPDATE carrito SET cantidad = ?, fecha_agregado = CURRENT_TIMESTAMP WHERE id_carrito = ? AND id_usuario = ?");
            $stmt->bind_param("iii", $cantidad, $id_carrito, $id_usuario);
        }
    } elseif ($action === 'delete') {
        // Eliminar producto del carrito
        $stmt = $conn->prepare("DELETE FROM carrito WHERE id_carrito = ? AND id_usuario = ?");
        $stmt->bind_param("ii", $id_carrito, $id_usuario);
    } else {
        echo json_encode(['success' => false, 'message' => 'Acción no válida']);
        exit;
    }

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Carrito actualizado']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al actualizar el carrito']);
    }

    $stmt->close();
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

$conn->close();
?>