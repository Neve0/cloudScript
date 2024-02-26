<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="styles.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>App</title>
</head>
<body>
    <div class='container'>
        <div class='container2'>
            <div class='text'>
                <p> O endereço IP deste servidor é: </p>
                <h2> <?php echo $_SERVER["SERVER_NAME"]; ?> </h2>
                <p> Porta: <?php  echo $_SERVER["SERVER_PORT"]; ?> </p> 
                <p> Protocolo: <?php echo $_SERVER["SERVER_PROTOCOL"]; ?> </ṕ>
                <p> Servidor: <?php echo $_SERVER["SERVER_SOFTWARE"]; ?> </p>
            </div>
        </div>
    </div>
</body>
</html>