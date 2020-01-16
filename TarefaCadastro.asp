<% option explicit %>
<!-- #include file = "configs/config.asp" -->
<!-- #include file = "class/validartarefa.asp" -->
<!DOCTYPE html>
<html class="font">
<head>
    <title>Cadastro de Tarefa</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <h1 class="u">Tarefa</h1>
        <p><a href="http://localhost/treinamento/lista.asp">Voltar para a listagem de tarefas</a></p>
           <%

              dim tarTitulo, geradorID, tarDescricao, tarStatus, tarData, tarData2
              dim recordSet
              dim rs
              dim btnAcao
              dim tarID
              dim novaData
              dim Data, Data2, novavar

              tarID=request("tarID")

               if tarID <> "" then
                    set rs = cn.execute("select * from tarefa where tarID = "& tarID )     
                    if not rs.eof then
                        tarTitulo = rs("tarTitulo")
                        geradorID = rs("geradorID")
                        tarDescricao = rs("tarDescricao")
                        tarStatus = rs("tarStatus") 
                        tarData = FormatDateTime(rs("tarData"))
                        novaData = split(tarData," ")
                        Data = split(novaData(0),"/")
                        Data2 = Data(2) & "-" & Data(1) & "-" & Data(0)
                        novavar = Data2 & "T" & NovaData(1)
                    end if
                end if 
               %>
       <form action="TarefaCadastro.asp" method="post">
            <input type="hidden" id="tarID" name="tarID" value="<%=tarId %>">
            Título:
            <input type="text" id="tarTitulo" name="tarTitulo" class="titulo" <% if tarID = "" then %> value="" <% else %> value="<%=tarTitulo%>" <%end if %>><br>
            Gerador:<% 
                set recordSet = cn.execute("select * from usuario")
                response.Write("<select class='geradorID' id='geradorId' name='geradorID' value=''>")            
                response.Write("<option value=''>--Selecione um gerador--</option>")

                 Do While (not recordSet.EOF)
                if geradorID = recordSet("usuid") then
                        response.Write("<option value="& recordSet("usuid") & " selected>" & recordSet("usuario") & "</option>")
                    else
                        response.Write("<option value="& recordSet("usuid") & ">" & recordSet("usuario") & "</option>")
                    end if

                    recordSet.MoveNext()
                 Loop
                 response.Write("</select>")
            %> <br>
            Descrição:
            <textarea rows="10" cols="98" class="descricao" id="tarDescricao" name="tarDescricao"><%=tarDescricao%></textarea><br>
            Status:
            <select name="tarStatus" id="tarStatus" class="status">
                <option value="">--Selecione um Status--</option>
                <option value="0"<% if tarStatus = "0" then %> selected <% else %> placeholder="" <%end if %> >Não iniciado</option>
                <option value="1"<% if tarStatus = "1" then %> selected <% else %> placeholder="" <%end if %> >Em andamento</option>
                <option value="7"<% if tarStatus = "7" then %> selected <% else %> placeholder="" <%end if %> >Cancelada</option>
                <option value="9"<% if tarStatus = "9" then %> selected <% else %> placeholder="" <%end if %> >Concluída</option>
            </select><br>
            Data:
            <input type="datetime-local" name="tarData" id="tarData" class="data" min="1900-01-01T00:00:00" max="2100-12-31T23:59:59" <% if tarID = "" then %> value="" <% else %> value="<%=novavar%>" <%end if %>><br>

            <button onclick="cadastrarTarefa(event)" id="cadastrar" class="botao" value="Cadastrar"><b>Cadastrar</b></button>
            <button onclick="alterarTarefa(event)" id="alterar" class="botao" value="Alterar"><b>Alterar</b></button>
            <button onclick="deletarTarefa(event)" id="deletar" class="botao" value="Cancelar"><b>Cancelar</b></button>
            <button onclick="limparCampos()" class="botao"><b>Novo</b></button>
        </form>
        <script type="text/javascript" src="jscripts/tarefacadastro.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </body>
</html>
