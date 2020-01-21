<!-- #include file = "configs/config.asp" -->
<%
    'implementar sessao e valida��o
    if Session("usuario") <> "logado" then
        Response.Redirect("logon.asp")
    end if     
%>
<!DOCTYPE html>
<html class="font">
<head>
    <title>Lista usu�rio</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h1 class="u">Usu�rio</h1>
    <p><a href="http://localhost/treinamento/usuariocadastro.asp" class="novo">Novo Usu�rio</a></p>
    <table>
        <tr>
            <th>Nome</th>
            <th>Usu�rio</th>
            <th>Endere�o</th>
            <th>Cidade</th>
            <th>Cep</th>
            <th class="img">Editar</th>
        </tr>
        <%
        
        %>
        <form id="input" action="listausuario.asp" method="post">
            <input type="hidden" id="Npagina" name="Npagina" value="<%=Npagina %>">
            <td colspan="5" class="paginacao">
                <div>
                    <button type="submit" name="botao" <%=voltarDisabled%> value="<<"><<</button>
                    <input type="text" name="input" size="1" onkeyup="mudarpagina(event)">
                    <button type="submit" name="botao" <%=voltarDisableddenovo%> value=">>">>></button>
                    
                </div>                
            </td>
            <td colspan="1" class="paginacao2">
                <b>Mostrando <%=numeroAtual%> de <%=intTotal %> registros</b>
            </td>
        </form>
    </table>
    <script type="text/javascript" src="jscripts/jquery.js"></script>
    <script type="text/javascript" src="jscripts/listausuario.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</body>
</html>
