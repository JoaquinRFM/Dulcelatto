<?php
include '../includes/db_connect.php';
header('Content-Type: application/json');

// Debug: log POST data
file_put_contents('debug_add_to_carrito.txt', print_r($_POST, true), FILE_APPEND);

// 1. Validar datos recibidos
if (
    !isset($_POST['user_id']) ||
    !isset($_POST['producto_id']) ||
    !isset($_POST['cantidad'])
) {
    echo json_encode(['status' => 'error', 'message' => 'Faltan datos']);
    exit;
}

$user_id = intval($_POST['user_id']);
$producto_id = intval($_POST['producto_id']);
$cantidad = intval($_POST['cantidad']);

if ($user_id <= 0 || $producto_id <= 0 || $cantidad <= 0) {
    echo json_encode(['status' => 'error', 'message' => 'Datos inválidos']);
    exit;
}

// 2. Verificar si ya existe el producto en el carrito
$stmt = $conn->prepare("SELECT id_carrito, cantidad FROM carrito WHERE id_usuario = ? AND id_producto = ?");
$stmt->bind_param("ii", $user_id, $producto_id);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    // 3. Si existe, actualizar la cantidad
    $nueva_cantidad = $row['cantidad'] + $cantidad;
    $stmt2 = $conn->prepare("UPDATE carrito SET cantidad = ? WHERE id_carrito = ?");
    $stmt2->bind_param("ii", $nueva_cantidad, $row['id_carrito']);
    if ($stmt2->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Cantidad actualizada']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Error al actualizar: ' . $stmt2->error]);
    }
    $stmt2->close();
} else {
    // 4. Si no existe, insertar nuevo registro
    $stmt2 = $conn->prepare("INSERT INTO carrito (id_usuario, id_producto, cantidad) VALUES (?, ?, ?)");
    $stmt2->bind_param("iii", $user_id, $producto_id, $cantidad);
    if ($stmt2->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Producto agregado']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Error al insertar: ' . $stmt2->error]);
    }
    $stmt2->close();
}

$stmt->close();
$conn->close();
?>