<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Iniciar Sesion</title>
	<link rel="stylesheet" href = "../assets/css/styleLoginPage.css">
</head>
<body>
	<div class ="container">
		<div class ="form sign-in-container" >
			<form method="post" class ="sing-in" action="../includes/setUsuario.php">
				<img src="../assets/img/logo.jpeg">
				<h1> Iniciar Sesión </h1>
				<span> Use su correo y contraseña </span>
				<div class = "container-input">
					<input type="text" name="correo_usuario" placeholder="Correo Electrónico">
				</div>
				<div class = "container-input">
					<input type="password" name="password" placeholder="Contraseña">
				</div>
				<input type="submit" value="INICIAR SESION" class="boton" />
				<a class = "ok-account"> ¿No tiene cuenta? Registrate</a>
			</form>
		</div>
		<div class ="form sign-up-container" >
			<form method="post" class ="sing-up" action="../includes/getUsuario.php">
				<img src="../assets/img/logo.jpeg">
				<h1> Regístrate </h1>
				<span> Use su correo electrónico para registrarse </span>
				<div class = "container-input">
					<input type="text" name="nombre_usuario" placeholder="Nombre de Usuario">
				</div>
				<div class = "container-input">
					<input type="date" name="fech_nacmto" placeholder="Fecha de nacimiento">
				</div>
				<div class = "container-input">
					<input type="text" name="correo_usuario" placeholder="Email">
				</div>
				<div class = "container-input">
					<input type="password" name="password" placeholder="Contraseña">
				</div>
				<input type="submit" value="REGISTRARSE" class="boton" />
				<a class = "no-account"> ¿Ya tiene cuenta? Inicie Sesion</a>
			</form>
		</div>
	</div>
	<script src="../assets/js/scripLogt.js"></script>
</body>
</html>