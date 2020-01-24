<!DOCTYPE html>
<html class="font">
<head>
    <title>Logon</title>
    <meta name="viewport" charset="utf-8" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <img src="imagens/chave.jpg" alt="Trulli" class="center">
    <br>
    <form action="logon.asp" method="post" class="form">
        <label>Usuário:</label>
        <input type="text" name="usuario" id="usuario" class="usuario">
        <br>
        <label>Senha:</label>
        <input type="password" id="senha" name="senha" class="senha"><br>
        <div class="alerta" id="divAlerta"></div>
        <button class="botao" id="botaologin"><b>Entrar</b></button>
    </form>
    <script type="text/javascript" src="jscripts/logon.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</body>
</html>