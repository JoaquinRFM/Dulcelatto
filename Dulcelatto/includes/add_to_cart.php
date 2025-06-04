<?php
session_start();
include 'db_connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Debes iniciar sesión para añadir productos al carrito']);
    exit;
}

if (!isset($_POST['id_producto']) || !isset($_POST['cantidad'])) {
    echo json_encode(['success' => false, 'message' => 'Datos incompletos']);
    exit;
}

$id_usuario = $_SESSION['user_id'];
$id_producto = intval($_POST['id_producto']);
$cantidad = intval($_POST['cantidad']);

try {
    // Verificar si el producto ya está en el carrito
    $stmt = $conn->prepare("SELECT id_carrito, cantidad FROM carrito WHERE id_usuario = ? AND id_producto = ?");
    $stmt->bind_param("ii", $id_usuario, $id_producto);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Actualizar cantidad si el producto ya está en el carrito
        $row = $result->fetch_assoc();
        $nueva_cantidad = $row['cantidad'] + $cantidad;
        $stmt = $conn->prepare("UPDATE carrito SET cantidad = ?, fecha_agregado = CURRENT_TIMESTAMP WHERE id_carrito = ?");
        $stmt->bind_param("ii", $nueva_cantidad, $row['id_carrito']);
    } else {
        // Insertar nuevo producto en el carrito
        $stmt = $conn->prepare("INSERT INTO carrito (id_usuario, id_producto, cantidad) VALUES (?, ?, ?)");
        $stmt->bind_param("iii", $id_usuario, $id_producto, $cantidad);
    }

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Producto añadido al carrito']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al añadir el producto']);
    }

    $stmt->close();
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Error: ' . $e->getMessage()]);
}

$conn->close();
?>