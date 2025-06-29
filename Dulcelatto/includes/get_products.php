<?php
include 'db_connect.php';

$sql = "SELECT id, nombre, descripcion, precio FROM productos";
$result = $conn->query($sql);

$productos = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $productos[] = $row;
    }
}

header('Content-Type: application/json');
echo json_encode($productos);
$conn->close();
?>