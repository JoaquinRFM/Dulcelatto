<?php
$host = 'localhost';    //Variables de conexion
$username = 'root';
$password = '';
$dbname = 'dulcelatto';

// Conectar a la base de datos con MySQLi
$conn = new mysqli($host, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    header('Content-Type: application/json');
    //Devolvemos el mensaje de error en formato JSON
    echo json_encode(['error' => 'Error de conexión: ' . $conn->connect_error]);
    exit();
}

// Establecer el conjunto de caracteres a UTF-8
$conn->set_charset("utf8");
?>