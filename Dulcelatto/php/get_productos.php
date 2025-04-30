<?php
$host = 'localhost';
$username = 'root'; // Cambia esto si tu usuario de MySQL es diferente
$password = ''; // Cambia esto si tu contraseña de MySQL es diferente
$dbname = 'dulcelatto';

// Conectar a la base de datos con MySQLi
$conn = new mysqli($host, $username, $password, $dbname);

// Verificar la conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Establecer el conjunto de caracteres a UTF-8
$conn->set_charset("utf8");
?>