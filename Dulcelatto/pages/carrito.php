<?php
session_start();
include '../includes/db_connect.php';
include '../includes/header.php';
?>

<head>
    <link rel="stylesheet" href="../assets/css/carrito.css">
    <link rel="stylesheet" href="../assets/css/header.css">
    <link rel="stylesheet" href="../assets/css/footer.css">
</head>

<main>
    <h2>Tu Carrito de Compras</h2>
    <div class="carrito-container">
        <div id="carrito-grid" class="carrito-grid"></div>
        <div class="carrito-total">
            <h3>Total: S/ <span id="carrito-total-price">0.00</span></h3>
            <button class="btn-proceder">Proceder al Pago</button>
        </div>
    </div>
</main>

<?php include '../includes/footer.php'; ?>
<script src="../assets/js/scriptCart.js"></script>