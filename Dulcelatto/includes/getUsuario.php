<?php
include 'db_connect.php';

if (!isset($_POST['nombre']) || !isset($_POST['fech_nacmnto']) || !isset($_POST['correo']) || !isset($_POST['password'])) {
    header('Location: ../pages/usuarios.php?error=missing_data');
    exit;
}

$nombre = $_POST['nombre'];
$fech_nacmnto = $_POST['fech_nacmnto'];
$correo = $_POST['correo'];
$password = $_POST['password'];

$stmt = $conn->prepare("SELECT id_us FROM usuario WHERE correo = ?");
$stmt->bind_param("s", $correo);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    header('Location: ../pages/usuarios.php?error=email_exists');
    exit;
}

$hashed_password = password_hash($password, PASSWORD_DEFAULT);

$stmt = $conn->prepare("INSERT INTO usuario (nombre_us, fech_nacmnto, correo, password) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $nombre, $fech_nacmnto, $correo, $hashed_password);

if ($stmt->execute()) {
    header('Location: ../pages/usuarios.php?registered=true');
} else {
    header('Location: ../pages/usuarios.php?error=registration_failed');
}

$stmt->close();
$conn->close();
?>