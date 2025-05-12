<body onLoad="f_volver();">
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>

<?php
include 'db_connect.php';

$v1=$_POST['correo_usuario'];
$v2=$_POST['password'];

$query="SELECT * FROM usuario WHERE correo='$v1' AND password='$v2'";
$resultado=mysqli_query($conn,$query);
$rst=mysqli_fetch_array($resultado);	
$x1=$rst['correo'];
$x2=$rst['password'];

if($v1=='' || $v2=='')
{
    echo "<script>
        alert('LLena todos los datos');
        window.location.href = '../pages/usuarios.php';
    </script>";
}

//Verificar coincidencia de datos
if($v1==$x1 and $v2==$x2)
{
    echo "<script>
            window.location.href = '../pages/index.php';
        </script>";
}

else
{
    echo "<script>
        alert('¡Correo del usuario y/o contraseña incorrectos!');
        window.location.href = '../pages/usuarios.php';
    </script>";
}
?>


</body>