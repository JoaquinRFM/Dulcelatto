<?php
include '../includes/db_connect.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nombre = $_POST['nombre'];
    $descripcion = $_POST['descripcion'];
    $precio = $_POST['precio'];
    $id_catg = $_POST['id_catg'];
    $imagen = $_FILES['imagen']['name'];

    // Consultar nombre de la categoría
    $sql_catg = "SELECT nombr_catg FROM categorias WHERE id_catg = ?";
    $stmt_catg = $conn->prepare($sql_catg);
    $stmt_catg->bind_param("i", $id_catg);
    $stmt_catg->execute();
    $result_catg = $stmt_catg->get_result();

    if ($result_catg->num_rows > 0) {
        $row = $result_catg->fetch_assoc();
        $nombre_categoria = strtolower(str_replace(' ', '_', $row['nombr_catg']));

        $ruta_carpeta = "../assets/img/" . $nombre_categoria;
        if (!file_exists($ruta_carpeta)) {
            mkdir($ruta_carpeta, 0777, true);
        }

        $ruta_bd = $ruta_carpeta . "/" . $imagen;
        $ruta_guardar = $ruta_carpeta . "/" . basename($imagen);

        if (move_uploaded_file($_FILES['imagen']['tmp_name'], $ruta_guardar)) {
            $sql = "INSERT INTO productos (nombre, descripcion, precio, imagen, id_catg)
                    VALUES (?, ?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ssdsi", $nombre, $descripcion, $precio, $ruta_bd, $id_catg);
            $stmt->execute();
            header("Location: ../pages/index.php?success=1");
            exit();
        } else {
            header("Location: ../pages/index.php?error=1");
            exit();
        }
    } else {
        header("Location: ../pages/index.php?error=categoria_no_encontrada");
        exit();
    }
}
?>