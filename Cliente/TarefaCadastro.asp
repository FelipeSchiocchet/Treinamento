<!DOCTYPE html>
<html class="font">
<head>
    <title>Cadastro de Tarefa</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <meta charset="utf-8">
    </head>
    <body>
        <h1 class="u">Tarefa</h1>
        <p><a href="http://localhost/treinamento/Cliente/lista.asp">Voltar para a listagem de tarefas</a></p>
       <form method="post">
            Título:
            <input type="text" id="tarTitulo" name="tarTitulo" class="titulo"><br>
            Gerador:
            <select class="geradorID" id="geradorID" name="geradorID" value=''></select><br>
            Descrição:
            <textarea rows="10" cols="98" class="descricao" id="tarDescricao" name="tarDescricao"></textarea><br>
            Status:
            <select name="tarStatus" id="tarStatus" class="status">
                <option value="">--Selecione um Status--</option>
                <option value="0">Não iniciado</option>
                <option value="1">Em andamento</option>
                <option value="7">Cancelada</option>
                <option value="9">Concluída</option>
            </select><br>
            Data:
            <input type="datetime-local" name="tarData" id="tarData" class="data" min="1900-01-01T00:00:00" max="2100-12-31T23:59:59"><br>

           <button class="botao" id="cadastrar" value="Cadastrar"><b>Cadastrar</b></button>
            <button class="botao" id="alterar" value="Alterar"><b>Alterar</b></button>
            <button class="botao" id="deletar" value="Deletar"><b>Deletar</b></button>
            <button class="botao" id="novo" value="Novo" onclick="window.location.href = 'http://localhost/treinamento/Cliente/tarefacadastro.asp'"><b>Novo</b></button>
        </form>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script type="text/javascript" src="jscripts/tarefacadastro.js"></script>
    </body>
</html>
