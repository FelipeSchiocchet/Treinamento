<!-- #include file = "../Models/Conexao.class.asp" -->
<!-- #include file = "../Models/Tarefa.class.asp" -->
<%
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
    RegistrosPorPagina = Request("RegistrosPorPagina")
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
    dim palavraParaPesquisa:palavraParaPesquisa = Request("palavraParaPesquisa")
    dim colunaOrdenacao : colunaOrdenacao = "tarID"
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objTarefa = new cTarefa
    set recordSet = objTarefa.BuscarTarefas(cn, palavraParaPesquisa, colunaOrdenacao)
    
    if not recordSet.eof then
        intTotal = recordSet.recordcount
        recordSet.pageSize = RegistrosPorPagina
        Ndepaginas = recordSet.PageCount
        if Npagina <= 0 then
                Npagina = 1
        end if    
        If Npagina > Ndepaginas Then
            Npagina = Ndepaginas
        End if
        recordSet.AbsolutePage = Npagina
        fimPagina = registrosPorPagina * Npagina 
        registrosdaPagina = 0    
        response.Write "{"       
        response.Write """Dados"":["
         Do While not recordSet.eof and (recordSet.AbsolutePosition <= fimPagina)
        response.Write  "{"
            response.Write      """tarID"": """ & recordSet("tarID") & """"
            response.Write      ",""Titulo"": """ & recordSet("tarTitulo") & """"
            response.Write      ",""Descricao"": """ & recordSet("tarDescricao") & """"
            response.Write      ",""DataAbertura"": """ & recordSet("tarData") & """"
            response.Write      ",""Status"": """ & recordSet("tarStatus") & """"
        response.Write  "}"
        registrosdaPagina=registrosdaPagina+1
            recordSet.MoveNext
            if (not recordSet.eof and recordSet.AbsolutePosition <= fimPagina) then
                response.Write ","
            end if   
        Loop
        response.Write "]"
        response.Write ",""TotalRegistros"":""" & intTotal & """"
        response.Write ",""RegistrosPorPagina"":""" & registrosdaPagina & """"
        response.Write ",""PaginaAtual"":""" & Npagina & """"
        response.Write ",""TotalPaginas"":""" & Ndepaginas & """"
        response.Write "}" 
    end if
    recordSet.close()
    end function

function salvarStatuseTitulo()
    status = request("status")
    titulo = request("titulo")
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objTarefa = new cTarefa
    ObjTarefa.setId(CInt(request("id"))) 
    ObjTarefa.setStatus(request("status"))
    objTarefa.setTitulo(request("titulo"))
    if status <> "" then 
        recordSet = objTarefa.AlterarStatus(cn,ObjTarefa)
    end if
    if titulo <> "" then 
        recordSet = objTarefa.AlterarTitulo(cn,ObjTarefa)
    end if
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
    objconexao.Fecharconexao(cn)
    
end function
%>      