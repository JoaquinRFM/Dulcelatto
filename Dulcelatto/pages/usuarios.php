<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Dulcelatto</title>
    <link rel="stylesheet" href="../assets/css/styleLoginPage.css">
</head>
<body>
    <div class="login-wrapper">
        <div class="sign-in-container">
			<div class="form">
				<form action="../includes/login.php" method="POST">
                	<h2>Iniciar Sesión</h2>
                	<p>Use su correo y contraseña</p>
                	<div class="container-input"><input type="email" name="correo" placeholder="Correo" required></div>
                	<div class="container-input"><input type="password" name="password" placeholder="Contraseña" required></div>
                	<button type="submit">Iniciar Sesión</button>
                	<p>¿No tiene cuenta? <a href="#" class="ok-account">Registrarse</a></p>
            	</form>
			</div>
        </div>
        <div class="sign-up-container" style="display: none;">
			<div class="form">
            	<form action="../includes/getUsuario.php" method="POST">
            	    <h2>Regístrese</h2>
            	    <p>Use su correo electrónico para registrarse</p>
            	    <div class="container-input"><input type="text" name="nombre" placeholder="Nombre" required></div>
            	    <div class="container-input"><input type="date" name="fech_nacmnto" placeholder="Fecha de Nacimiento" required></div>
            	    <div class="container-input"><input type="email" name="correo" placeholder="Correo" required></div>
            	    <div class="container-input"><input type="password" name="password" placeholder="Contraseña" required></div>
            	    <button type="submit">Registrarse</button>
            	    <p>¿Ya tiene cuenta? <a href="#" class="no-account">Inicie Sesión</a></p>
            	</form>
			</div>
        </div>
    </div>
    <script src="../assets/js/scripLogt.js"></script>
</body>
</html>