<!-- #include file = "configs/config.asp" -->
<%
    'implementar sessao e validação
    if Session("usuario") <> "logado" then
        Response.Redirect("logon.asp")
    end if     
%>
<!DOCTYPE html>
<html class="font">
<head>   
    <title>Lista Tarefas</title> 
    <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>
    <body>
        <h1 class="u">Tarefas</h1>
        <p><a href="http://localhost/treinamento/TarefaCadastro.asp">Nova tarefa</a></p>
        <table>
            <tr>
                <th>N°</th>
                <th>Título</th>
                <th>Descrição</th>
                <th>Data Abertura</th>
                <th class="img">Status</th>
            </tr>
         <% dim intLimit
            dim numeroAtual
            dim Npagina
            dim botao
            dim btnAcao
            dim inputAcao
            dim Ndepaginas, Ndepaginas2
            'stop
            inputAcao = request.form("input")
            if inputAcao = "" then 
                btnAcao = request.form("botao")
            else
                btnAcao = 0
            end if
            if inputAcao = "" then 
                if btnAcao = ">>" then
                    btnAcao = 1
                end if 
                if btnAcao = "<<" then
                    btnAcao = -1
                end if
               inputAcao = 0 
            end if
            Npagina = request.form("Npagina")
           
            Npagina = CInt(Npagina)
            inputAcao = CInt(inputAcao)
            
               
            intLimit = "30"
            set recordSet = Server.CreateObject("ADODB.recordset")
            call recordSet.Open("SELECT tarID FROM tarefa ORDER BY tarID asc;",cn,1,1)
            Ndepaginas =  Round(recordSet.recordcount / 30 + 1)
            Ndepaginas2 = recordSet.recordcount / 30 + 1
            if Ndepaginas >= Ndepaginas2 then
            Ndepaginas = Ndepaginas - 1 
            end if
            
            if btnAcao = "-1" then
                    Npagina = Npagina + btnAcao     
            end if
            if btnAcao = "1" then
                Npagina = Npagina + btnAcao   
            end if
            if not inputAcao = 0 then
                if not inputAcao = "" and inputAcao <= Ndepaginas then               
                    Npagina = inputAcao
                else 
                    Npagina = Ndepaginas
                end if
            end if
            if Npagina <= 0 then
                Npagina = 1
            end if
            if Npagina = 1 then
                voltarDisabled = "disabled"
            end if
            intTotal = recordSet.recordcount
            recordSet.pageSize = intLimit 
            if recordSet.PageCount > 0 then
                if intPagina = 0 then
                    intPagina = 1
                end if
                recordSet.AbsolutePage = Npagina

            end if
            strIDs = "0"
            if not recordSet.eof then
              
                strIDs = recordSet.GetString(,intLimit,"",",","")
                strIDs = left(strIDs, len(strIDs) - 1) 
            end if
            recordSet.close()
            call recordSet.Open("SELECT * FROM tarefa WHERE tarID in("& strIDs &") ORDER BY tarID ASC;",cn,1,1)

            recordSet.pageSize = intLimit

            numeroAtual = intLimit * (Npagina - 1) + recordSet.recordcount
 
            Do While (not recordSet.EOF)
                response.Write( _
                    "<tr>" & _
                    "<td onclick='location.href = ""TarefaCadastro.asp?tarID="& recordSet("tarID") &"""'>" & recordSet("tarID") & "</td>" &_
                    "<td ondblclick='edicaoTarefa(this,"& recordSet("tarID")&")' id='ESC'>" & recordSet("tarTitulo") & "</td>"&_
                    "<td onclick='location.href = ""TarefaCadastro.asp?tarID="& recordSet("tarID") &"""'>" & recordSet("tarDescricao") & "</td>"&_
                    "<td onclick='location.href = ""TarefaCadastro.asp?tarID="& recordSet("tarID") &"""'>" & recordSet("tarData") & "</td>"&_
                    "<td class='img'> <img ondblclick='mudarImagem(this,"& recordSet("tarID") &")' src='imagens/" & recordSet("tarStatus") &".gif' >"& _
                    "</td>"  &_
                "</tr>")
             recordSet.MoveNext
             Loop
             recordSet.close()
            if numeroAtual = intTotal then
                voltarDisableddenovo = "disabled"
            end if
            %>
        <form id="input" action="lista.asp" method="post">
            <input type="hidden" id="Npagina" name="Npagina" value="<%=Npagina %>">
            <td colspan="4" class="paginacao">
                <div>
                    <button type="submit" name="botao" <%=voltarDisabled%> value="<<"><<</button>
                    <input type="text" name="input" size="1" onkeyup="myFunction(event)">
                    <button type="submit" name="botao" <%=voltarDisableddenovo%> value=">>">>></button>
                </div>                
            </td>
            <td colspan="1" class="paginacao2">
                <b>Mostrando <%=numeroAtual%> de <%=intTotal %> registros</b>
            </td>
        </form>
    </table>
         <script type="text/javascript" src="jscripts/tarefalista.js"></script>
         <script type="text/javascript" src="jscripts/jquery.js"></script>
</body>
</html>