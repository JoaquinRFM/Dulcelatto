<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categoria - Dulce Latte</title>
    <link rel="stylesheet" href="../assets/css/styles.css">
    <link rel="stylesheet" href="../assets/css/productos.css">
    <link rel="stylesheet" href="../assets/css/header.css">
    <link rel="stylesheet" href="../assets/css/footer.css">
    <link rel="website icon" type="png" href="../assets/img/logo.png">
</head>
<body>
    <?php include '../includes/header.php'; ?>
    <main>
        <?php
        // Obtener la categoría seleccionada de la URL
        $categoriaSeleccionada = isset($_GET['categoria']) ? $_GET['categoria'] : '';
        ?>
        <h1><?php echo $categoriaSeleccionada ? 'Categoría: ' . htmlspecialchars($categoriaSeleccionada) : 'Todas las Categorías'; ?></h1>
        <section class="categoria-grid" data-categoria="<?php echo htmlspecialchars($categoriaSeleccionada); ?>">
            <!-- Los productos se cargarán dinámicamente con JS -->
        </section>
    </main>
    <?php include '../includes/footer.php'; ?>
    <script src="../assets/js/scriptCatg.js"></script>
</body>
</html>
