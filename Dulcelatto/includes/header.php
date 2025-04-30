<?php
// Simulamos un contador de carrito para el diseño (se integrará con PHP después)
$cart_count = 0;
?>

<header>
    <!-- Primera fila: Logo, búsqueda, Sign In, My Orders, Carrito -->
    <div class="header-top">
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
            <a href="#" class="sign-in">
                <img src="../assets/img/sign_in.jpg" alt="Sign In">
                <span>Ingresar</span>
            </a>
            <a href="#" class="my-orders">
                <img src="../assets/img/my_orders.jpg" alt="My Orders">
                <span>Mis pedidos</span>
            </a>
            <a href="#" class="cart">
                <img src="../assets/img/cart.jpg" alt="Cart">
                <span>Carrito</span>
            </a>
        </div>
    </div>

    <!-- Segunda fila: Links a otras páginas -->
    <nav class="header-middle">
        <a href="#">Dia de la madre</a>
        <a href="#">Cumpleaños</a>
        <a href="#">Agradecimiento</a>
        <a href="#">Elije el tuyo</a>
        <a href="#">Delivery inmediato</a>
        <a href="#">A tan solo S/.10</a>
        <a href="#">Regalos en descuento</a>
    </nav>

    <!-- Tercera fila: Categorías con submenús desplegables -->
    <nav class="header-bottom">
        <div class="dropdown">
            <a href="#" class="dropbtn">Festivos y ocasiones</a>
            <div class="dropdown-content">
                <div class="dropdown-inner">
                    <div class="dropdown-column">
                        <h4>Regalos festivos</h4>
                        <a href="#">Regalos por el dia de las madres</a>
                        <a href="#">Regalos de verano</a>
                        <a href="#">Graduacion</a>
                        <a href="#">Regalo para maestros</a>
                        <a href="#">Semana de las enfermeras</a>
                        <a href="#">Paquetes de atencion universitaria</a>
                    </div>
                    <div class="dropdown-column">
                        <h4>Ocasiones diarias</h4>
                        <a href="#">Cumpleaños</a>
                        <a href="#">Agradecimiento</a>
                        <a href="#">Regalos carinosos</a>
                        <a href="#">Regalos de recuperacion</a>
                        <a href="#">Celebracion</a>
                        <a href="#">Regalos para animar</a>
                        <a href="#">Pensando en ti</a>
                        <a href="#">Regalos para bebes</a>
                        <a href="#">Regalos de boda</a>
                        <a href="#">Regalos de aniversario</a>
                        <a href="#">Estreno de casa</a>
                    </div>
                    <div class="dropdown-images">
                        <img src="../assets/img/Torta_madre.jpg" alt="Mother's Day Gifts">
                    </div>
                </div>
            </div>
        </div>
        <div class="dropdown">
            <a href="#" class="dropbtn">Comprar por regalo</a>
            <div class="dropdown-content">
                <div class="dropdown-inner">
                    <div class="dropdown-column">
                        <h4>Que hay de nuevo</h4>
                        <a href="#">Coleccion de barbie</a>
                        <a href="#">Coleccion de disney</a>
                        <a href="#">Cupckaes y pasteles</a>
                        <a href="#">Crema de helado</a>
                        <a href="#">Paletas</a>
                        <a href="#">Dulcelatto Colecion Premium</a>
                    </div>
                    <div class="dropdown-images">
                        <img src="../assets/img/cupcake.jpg" alt="Cupcakes">
                    </div>
                </div>
            </div>
        </div>
        <div class="dropdown">
            <a href="#" class="dropbtn">Comprar por sabor</a>
            <div class="dropdown-content">
                <div class="dropdown-inner">
                    <div class="dropdown-column">
                        <h4>Sabores</h4>
                        <a href="#">Chocolate</a>
                        <a href="#">Vainilla</a>
                        <a href="#">Frutales</a>
                        <a href="#">Caramelo</a>
                        <a href="#">Cafe</a>
                        <a href="#">Limon</a>
                    </div>
                    <div class="dropdown-images">
                        <img src="../assets/img/chocolate.jpg" alt="Chocolate">
                    </div>
                </div>
            </div>
        </div>
        <div class="dropdown">
            <a href="#" class="dropbtn">Comprar por precio</a>
            <div class="dropdown-content">
                <div class="dropdown-inner">
                    <div class="dropdown-column">
                        <h4>Rangos de precio</h4>
                        <a href="#">Menos de S/.10</a>
                        <a href="#">S/.10 - S/.20</a>
                        <a href="#">S/.20 - S/.30</a>
                        <a href="#">Mas de S/.30</a>
                    </div>
                    <div class="dropdown-images">
                        <img src="../assets/img/cheap_gift.jpg" alt="Under $10">
                    </div>
                </div>
            </div>
        </div>
        <div class="dropdown">
            <a href="#" class="dropbtn">Regalos corporativos</a>
            <div class="dropdown-content">
                <div class="dropdown-inner">
                    <div class="dropdown-column">
                        <h4>Opciones corporativas</h4>
                        <a href="#">Pedidos al por mayor</a>
                        <a href="#">Marca personalizada</a>
                        <a href="#">Tarjetas de regalo</a>
                    </div>
                    <div class="dropdown-images">
                        <img src="../assets/img/bulk_order.jpg" alt="Bulk Orders">
                    </div>
                </div>
            </div>
        </div>
        <div class="dropdown">
            <a href="#" class="dropbtn">Comunidad</a>
            <div class="dropdown-content">
                <div class="dropdown-inner">
                    <div class="dropdown-column">
                        <h4>Comunidad</h4>
                        <a href="#">Recetas</a>
                        <a href="#">Blog</a>
                        <a href="#">Eventos</a>
                        <a href="#">Testimonios</a>
                    </div>
                    <div class="dropdown-images">
                        <img src="../assets/img/events.jpg" alt="Events">
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>