<?php session_start(); ?>
<header>    
    <style>
        .search-results {
            position: absolute;
            top: 60px;
            left: 50%;
            transform: translateX(-50%);
            background: #fff;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            max-width: 600px;
            width: 90%;
            max-height: 400px;
            overflow-y: auto;
            z-index: 1000;
            display: none;
        }
        .search-result-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }
        .search-result-item:hover {
            background: #f9f9f9;
        }
        .search-result-item img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 10px;
        }
        .search-result-item h4 {
            margin: 0;
            font-size: 1rem;
            color: #333;
        }
        .search-result-item p {
            margin: 5px 0 0;
            font-size: 0.9rem;
            color: #666;
        }
    </style>
    <!-- Primera fila: Logo, búsqueda, Sign In, My Orders, Carrito -->
    <div class="header-top">
        <button class="menu-btn">
            <img src="../assets/img/menu-icon.png" alt="Menú">
            <span>Menú</span>
        </button>
        <div class="logo">
            <a href="index.php">
                <img src="../assets/img/logo.jpeg" alt="Dulcelatto">
            </a>
        </div>
        <div class="search-bar">
            <input type="text" placeholder="Buscar producto">
            <button>Buscar</button>
        </div>
        <div class="user-actions">
            <a href="../pages/usuarios.php" class="sign-in">
                <img src="../assets/img/sign_in.jpg" alt="Sign In">
                <span>Ingresar</span>
            </a>
            <a href="#" class="my-orders">
                <img src="../assets/img/my_orders.jpg" alt="My Orders">
                <span>Mis pedidos</span>
            </a>
            <a href="../pages/carrito.php" class="cart">
                <img src="../assets/img/cart.jpg" alt="Cart">
                <span>Carrito (<span id="cart-count">0</span>)</span>
            </a>
        </div>
    </div>
    <div class="espacio"></div>
    <!-- Segunda fila: Links a otras páginas -->
    <nav class="header-middle">
        <a href="categoria.php?categoria=Pasteles y Tortas">Pasteles y Tortas</a>
        <a href="categoria.php?categoria=Helados">Helados</a>
        <a href="categoria.php?categoria=Galletas y Bizcochos">Galletas y Bizcochos</a>
        <a href="categoria.php?categoria=Cupcakes">Cupcakes</a>
        <a href="categoria.php?categoria=Postres salados">Postres salados</a>
        <a href="categoria.php?categoria=Postres dulces">Postres dulces</a>
        <a href="categoria.php?categoria=Postres de crema o frias">Postres de crema o frias</a>
    </nav>
    
    <div class="menu-overlay"></div>
    <div class="menu-lateral">
        <div class="menu-content">
            <div class="header-menu">
                <div>
                    <img src="../assets/img/logo.jpeg" alt="Dulcelatto" style="height: 28px; width: auto;">
                </div>
                <div class="spacer"></div>
                <div>
                    <a href="../pages/usuarios.php" class="sign-in">
                        <img src="../assets/img/sign_in.jpg" alt="Sign In">
                        <span>Ingresar</span>
                    </a>
                </div>
                <button class="xmenu-btn">
                    <img src="../assets/img/x_menu.png" alt="salir del menú">
                </button>
            </div>
            <div class="part1-menu">
                <a href="categoria.php?categoria=Pasteles y Tortas">
                    <img src="../assets/img/pasteles_y_tortas.png" alt="Pasteles y Tortas">
                    <h4>Pasteles y Tortas</h4>
                </a>
                <a href="categoria.php?categoria=Helados">
                    <img src="../assets/img/helados.jpg" alt="Helados">
                    <h4>Helados</h4>
                </a>
                <a href="categoria.php?categoria=Galletas y Bizcochos">
                    <img src="../assets/img/galletas.png" alt="Galletas">
                    <h4>Galletas y Bizcochos</h4>
                </a>
                <a href="categoria.php?categoria=Postres salados">
                    <img src="../assets/img/postres_salados.png" alt="Postres salados">
                    <h4>Postres salados</h4>
                </a>
                <a href="categoria.php?categoria=Postres dulces">
                    <img src="../assets/img/postres_dulces.png" alt="Postres dulces">
                    <h4>Postres dulces</h4>   
                </a>
                <a href="categoria.php?categoria=Postres de crema o frias">
                    <img src="../assets/img/postres_de_crema-o-frio.jpeg" alt="Postres de crema o frias">
                    <h4>Postres de crema o frias</h4>   
                </a>
            </div>
       </div>
   </div>
   <script src="../assets/js/scripHeader.js"></script>
   <script src="../assets/js/search.js"></script>
</header>
<div class="user-actions">
    <?php if (isset($_SESSION['user_id'])): ?>
        <a href="#">Bienvenido, <?php echo htmlspecialchars($_SESSION['nombre_us']); ?></a>
        <a href="../includes/logout.php">Cerrar sesión</a>
    <?php else: ?>
        <a href="../pages/usuarios.php">Iniciar sesión</a>
        <a href="../pages/usuarios.php">Registrarse</a>
    <?php endif; ?>
</div>
<script>
    // Actualizar contador del carrito
    fetch('../includes/get_cart_count.php')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.querySelector('#cart-count').textContent = data.count;
            }
        })
        .catch(error => console.error('Error al actualizar contador:', error));
</script>