<?php
include '../includes/db_connect.php';

header('Content-Type: application/json');

if (
    !isset($_POST['username']) ||
    !isset($_POST['birth']) ||
    !isset($_POST['email']) ||
    !isset($_POST['password'])
) {
    echo json_encode(['status' => 'error', 'message' => 'Faltan datos']);
    exit;
}

$username = $_POST['username'];
$birth = $_POST['birth'];
$email = $_POST['email'];
$password = $_POST['password'];

// Verifica si el correo ya existe
$stmt = $conn->prepare("SELECT id_us FROM usuario WHERE correo = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    echo json_encode(['status' => 'error', 'message' => 'Correo ya registrado']);
    exit;
}

$hashed_password = password_hash($password, PASSWORD_DEFAULT);

$stmt = $conn->prepare("INSERT INTO usuario (nombre_us, fech_nacmnto, correo, password) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $username, $birth, $email, $hashed_password);

if ($stmt->execute()) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Error al registrar']);
}
$stmt->close();
$conn->close();
?>