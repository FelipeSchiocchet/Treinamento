<% option explicit %>
<!-- #include file = "../configs/config.asp" -->
<!-- #include file = "../class/validacao.asp" -->
<!DOCTYPE html>
<html class="font">
<head>
    <title>Cadastro de Usuário</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script type="text/javascript" src="jscripts/usuariocadastro.js"></script>
    </head>
    <body>
        <h1 class="u">Usuário</h1>
        <p><a href="http://localhost/treinamento/Cliente/listausuario.asp">Voltar para a listagem</a></p>           
        <form method="post">
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
            <select class="estadoid" id="estadoid" name="estadoid"></select>
        <br>
            <button class="botao" id="cadastrar" value="Cadastrar"><b>Cadastrar</b></button>
            <button class="botao" id="alterar" value="Alterar"><b>Alterar</b></button>
            <button class="botao" id="deletar" value="Deletar"><b>Deletar</b></button>
            <input type="reset" class="botaoresete" value="Novo" id="novo">
        </form>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </body>
</html>
