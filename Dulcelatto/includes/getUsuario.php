<body onLoad="f_volver();">
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>

<?php
include 'db_connect.php';

$v1=$_POST['nombre_usuario'];
$v2=$_POST['fech_nacmto'];
$v3=$_POST['correo_usuario'];
$v4=$_POST['password'];

//Verifica campos vacios
if($v1=='' || $v2=='' || $v3=='' || $v4=='')
{
    echo "<script>
        alert('LLena todos los datos');
        window.location.href = '../pages/usuarios.php';
    </script>";
}

//Verifica correo repetido
$query="SELECT * FROM usuario WHERE correo='$v3'";
$resultado=mysqli_query($conn,$query);
$rst=mysqli_fetch_array($resultado);	

if($rst)
{
    echo "<script>
        alert('Correo ya registrado');
        window.location.href = '../pages/usuarios.php';
    </script>";
}

//Inserta el usuario en la base de datos
else
{
    $query="INSERT INTO usuario(nombre_us,fech_nacmnto,correo,password) VALUES ('$v1','$v2','$v3','$v4')";
    $resultado=mysqli_query($conn,$query);
    echo "<script>
        window.location.href = '../pages/index.php';
    </script>";
}


?>
</body>