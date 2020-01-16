<% option explicit %>
<!-- #include file = "configs/config.asp" -->
<!-- #include file = "class/validacao.asp" -->
<!DOCTYPE html>
<html class="font">
<head>
    <title>Cadastro de Usuário</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <h1 class="u">Usuário</h1>
        <p><a href="http://localhost/treinamento/listausuario.asp">Voltar para a listagem</a></p>           
        <form action="usuariocadastro.asp" method="post">
            <input type="hidden" id="usuid" name="usuid">
            <input type="hidden" id="geradorID" name="geradorID">
            Usuário:
            <input type="text"  name="usuario" id="usuario" class="usuarioC">
            Senha:
            <input type="password" name="senha" id="senha" class="senhaC"><br>
            Nome:
            <input type="text" name="nome" id="nome" class="nome"><br>
            Endereço:
            <input type="text" name="endereco" id="endereco" class="endereco">
            Cidade:
            <input type="text" name="cidade" id="cidade" class="cidade"><br>
            CEP:
            <input type="text" name="cep" id="cep" class="cep" onkeypress="mascara(this, '##.###-###')" maxlength="10">
            
             Estado:
            <select class="estado" id="selEstados" name="selEstados"></select>
        <br>
            <button onclick="cadastrarUsuario(event)" class="botao" id="cadastrar" value="Cadastrar"><b>Cadastrar</b></button>
            <button onclick="alterarUsuario(event)" class="botao" id="alterar" value="Alterar"><b>Alterar</b></button>
            <button onclick="deletarUsuario(event)" class="botao" id="deletar" value="Deletar"><b>Deletar</b></button>
            <button onclick="limparCampos()" class="botao"><b>Novo</b></button>
        </form>
        <script type="text/javascript" src="jscripts/usuariocadastro.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </body>
</html>
