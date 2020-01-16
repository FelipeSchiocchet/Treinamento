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
            <%  
                dim usuario, senha, nome, endereco, cidade, cep, estadoid, geradorID
                dim recordSet
                dim rs
                dim records
                dim usuid
                stop
                usuid = CInt(request("usuid")) 
            %>
        <form action="usuariocadastro.asp" method="post">
            <input type="hidden" id="usuid" name="usuid" value="<%=usuid %>">
            <input type="hidden" id="geradorID" name="geradorID" value="<%=geradorID %>">
            Usuário:
            <input type="text"  name="usuario" id="usuario" class="usuarioC" <% if usuid = "0" then %> value="" <% else %> value="<%=usuario%>" <%end if %> />
            Senha:
            <input type="password" name="senha" id="senha" class="senhaC" <% if usuid = "0" then %> value="" <% else %> value="<%=senha%>" <%end if %> /><br>
            Nome:
            <input type="text" name="nome" id="nome" class="nome" <% if usuid = "0" then %> value="" <% else %> value="<%=nome%>" <%end if %> /><br>
            Endereço:
            <input type="text" name="endereco" id="endereco" class="endereco" <% if usuid = "0" then %> value="" <% else %> value="<%=endereco%>" <%end if %> />
            Cidade:
            <input type="text" name="cidade" id="cidade" class="cidade" <% if usuid = "0" then %> value="" <% else %> value="<%=cidade%>" <%end if %> /><br>
            CEP:
            <input type="text" name="cep" id="cep" class="cep" <% if usuid = "0" then %> value="" <% else %> value="<%=cep%>" <%end if %> " onkeypress="mascara(this, '##.###-###')" maxlength="10">
            
             Estado:
             <% set recordSet = cn.execute("select * from estado")
                response.Write("<select class='estado' name='estadoid' id='estadoid' value=''>")            
                response.Write("<option value=''>--Selecione um estado--</option>")

                 Do While (not recordSet.EOF)
                    if estadoid = recordSet("estadoid") then
                        response.Write("<option value="& recordSet("estadoid") & " selected>" & recordSet("nome") & "</option>")
                    else
                        response.Write("<option value="& recordSet("estadoid") & ">" & recordSet("nome") & "</option>")
                    end if

                    recordSet.MoveNext()
                 Loop
                 response.Write("</select>")   
           
            %> 
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
