<?php
include '../includes/db_connect.php';
session_start();

header('Content-Type: application/json');

if (
    !isset($_POST['email']) ||
    !isset($_POST['password'])
) {
    echo json_encode(['status' => 'error', 'message' => 'Faltan datos']);
    exit;
}

$email = $_POST['email'];
$password = $_POST['password'];

$stmt = $conn->prepare("SELECT id_us, nombre_us, password FROM usuario WHERE correo = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['password'])) {
        // Guardar datos mínimos en sesión
        $_SESSION['user_id'] = $user['id_us'];
        $_SESSION['user_name'] = $user['nombre_us'];
        echo json_encode(['status' => 'success', 'user_id' => $user['id_us'], 'user_name' => $user['nombre_us']]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Contraseña incorrecta']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Usuario no encontrado']);
}
$stmt->close();
$conn->close();
?>