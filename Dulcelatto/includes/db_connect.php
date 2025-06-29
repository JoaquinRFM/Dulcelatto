<?php
$host = 'localhost';
$username = 'u535045561_root'; // Cambia esto si tu usuario de MySQL es diferente cambiar: lfarfan / cambiar: root
$password = '60794523LmFb+'; // Cambia esto si tu contraseña de MySQL es diferente cambiar: luciana60794523
$dbname = 'u535045561_dulcelatto';

// Conectar a la base de datos con MySQLi
$conn = new mysqli($host, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    // En lugar de 'die', devolvemos un JSON con el error
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Error de conexión: ' . $conn->connect_error]);
    exit();
}

// Establecer el conjunto de caracteres a UTF-8 (caracteres especiales como ñ, á, é)
$conn->set_charset("utf8");
?>