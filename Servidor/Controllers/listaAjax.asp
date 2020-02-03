<!-- #include file = "../configs/config.asp" -->
<%
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
    intLimit = Request("RegistrosPorPagina")
    Npagina = Request("PaginaPesquisa")
    Execute(Request("fnTarget") & "()")
end if
dim intLimit
dim numeroAtual
dim Npagina
dim botao
dim btnAcao
dim inputAcao
dim Ndepaginas
dim bataoavancar

function BuscarTarefasPaginadas()
    Npagina = CInt(Npagina)
    intLimit = CInt(intLimit)
    set recordSet = Server.CreateObject("ADODB.recordset")
    call recordSet.Open("SELECT tarID FROM tarefa ORDER BY tarID asc;",cn,1,1)
    Ndepaginas = recordSet.recordcount \ 30 + 1
    intTotal = recordSet.recordcount
    recordSet.pageSize = intLimit
    recordSet.AbsolutePage = Npagina
     strIDs = "0"
    if not recordSet.eof then
        strIDs = recordSet.GetString(,intLimit,"",",","")
        strIDs = left(strIDs, len(strIDs) - 1) 
    end if
    recordSet.close()  
    call recordSet.Open("SELECT * FROM tarefa WHERE tarID in("& strIDs &") ORDER BY tarID ASC;",cn,1,1)
    recordSet.pageSize = intLimit
    response.Write "{"
    response.Write """TotalRegistros"":""" & intTotal & """"
    response.Write ",""RegistrosPorPagina"":""" & recordSet.RecordCount & """"
    response.Write ",""PaginaAtual"":""" & Npagina & """"
    response.Write ",""TotalPaginas"":""" & Ndepaginas & """"
    response.Write ",""Dados"":["
    Do While (not recordSet.EOF)
        response.Write  "{"
            response.Write      """tarID"": """ & recordSet("tarID") & """"
            response.Write      ",""Titulo"": """ & recordSet("tarTitulo") & """"
            response.Write      ",""Descricao"": """ & recordSet("tarDescricao") & """"
            response.Write      ",""DataAbertura"": """ & recordSet("tarData") & """"
            response.Write      ",""Status"": """ & recordSet("tarStatus") & """"
        response.Write  "}"
        if recordSet.AbsolutePosition < recordSet.RecordCount then
            response.Write ","
        end if   
        recordSet.MoveNext
    Loop
    response.Write "]"
    response.Write "}" 

    recordSet.close()
    end function
    %>
