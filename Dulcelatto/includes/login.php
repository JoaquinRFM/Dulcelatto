<?php
session_start();
include 'db_connect.php';

if (!isset($_POST['correo']) || !isset($_POST['password'])) {
    header('Location: ../pages/usuarios.php?error=missing_data');
    exit;
}

$correo = $_POST['correo'];
$password = $_POST['password'];

// Agregamos es_admin al SELECT
$stmt = $conn->prepare("SELECT id_us, nombre_us, password, es_admin FROM usuario WHERE correo = ?");
$stmt->bind_param("s", $correo);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    header('Location: ../pages/usuarios.php?error=user_not_found');
    exit;
}

$user = $result->fetch_assoc();

if (password_verify($password, $user['password'])) {
    session_regenerate_id(true);
    $_SESSION['user_id'] = $user['id_us'];
    $_SESSION['nombre_us'] = $user['nombre_us'];
    $_SESSION['es_admin'] = $user['es_admin']; // Guardamos si es admin

    header('Location: ../pages/index.php');
} else {
    header('Location: ../pages/usuarios.php?error=incorrect_password');
}

$stmt->close();
$conn->close();
?>