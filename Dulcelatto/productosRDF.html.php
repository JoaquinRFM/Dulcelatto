<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dulcelatto RDF</title>
    <style>
        body {
            background: white;
            color: black;
            font-family: monospace;
            padding: 20px;
        }
        pre {
            font-size: 15px;
        }
    </style>
</head>
<body>
    <h1>Dulcelatto RDF</h1>
    <?php
    $noHeaders = true;
    ob_start();
    include("producto.rdf.php");
    $rdf = ob_get_clean();
    ?>
    <pre><?php echo htmlspecialchars($rdf); ?></pre>
</body>
</html>
