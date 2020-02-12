<!-- #include file = "../Models/Conexao.class.asp" -->
<!-- #include file = "../Models/Tarefa.class.asp" -->
<%  
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
    RegistrosPorPagina = CInt(Request("RegistrosPorPagina"))
    Npagina = CInt(Request("PaginaPesquisa"))
    Execute(Request("fnTarget") & "()")
end if
    
dim tarTitulo, geradorID, tarDescricao, tarStatus, tarData
dim recordSet
dim rs
dim tarID
dim novaData
dim Data, Data2
dim intLimit
dim Npagina
dim Ndepaginas
        
function buscaUsuarios
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    sqlEst = "SELECT * FROM [treinamento].[dbo].[usuario]"
    Set recordSet=Server.CreateObject("ADODB.recordset")
    recordSet.Open sqlEst, cn,&H0001
    response.Write "{"
    response.Write """Usuarios"":["
    Do While (not recordSet.EOF)
        response.Write  "{"
        response.Write      """geradorID"": " & recordSet("usuid")
        response.Write      ",""nome"": """ & recordSet("nome") & """"
        response.Write  "}"
        if recordSet.AbsolutePosition < recordSet.RecordCount then
            response.Write ","
        end if   
        recordSet.MoveNext
    loop  
    response.Write "]"
    response.Write "}"
    recordSet.Close
    objconexao.Fecharconexao(cn)
end function

function converterData(tardata)
    novaData = split(tarData," ")
    Data = split(novaData(0),"/")
    Data2 = Data(2) & "-" & Data(1) & "-" & Data(0)
    if (UBound(novaData)>0) then
    converterData = Data2 & "T" & novaData(1)
    else
    converterData = Data2 & "T00:00"
    end if 
end function                        

function FormatarDataBanco(dataSemFormato)
    soHora = split(dataSemFormato,"T")
    d = split(soHora(0),"-")
    FormatarDataBanco = d(0) & "-" & d(2) & "-" & d(1) & " " & soHora(1)
end function

function colocarDados()
    tarID = CInt(request("tarID")) 
    if tarID <> "" then        
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objTarefa = new cTarefa
    set rs = objTarefa.BuscarTarefaPorId(cn, tarID)     
        if not rs.eof then
            response.Write  "{"   
            response.Write      """tarTitulo"": """ & rs("tarTitulo") & """"
            response.Write      ",""geradorID"": """ & rs("geradorID") & """"
            response.Write      ",""tarData"": """ & converterData(rs("tarData")) & """"
            response.Write      ",""tarStatus"": """ & rs("tarStatus") & """"
            response.Write      ",""tarDescricao"": """ & rs("tarDescricao") & """"
            response.Write  "}"

        end if
    end if
    objconexao.Fecharconexao(cn)
end function

function colocarData()
    dataAtual = converterData(now)

    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write      ",""dataAtual"": """ & dataAtual & """"
    response.Write  "}"

end function

function cadastrarTarefa()
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objTarefa = new cTarefa
    objTarefa.setTitulo(replace(request("tartitulo"),"'","''"))
    objTarefa.setGeradorId(replace(request("geradorID"),"'","''"))
    objTarefa.setDescricao(replace(request("tarDescricao"),"'","''"))
    objTarefa.setStatus(request("tarstatus"))
    objTarefa.setDataGeracao(FormatarDataBanco(request("tardata")))
    tarID = objTarefa.InsercaoTarefa(cn,ObjTarefa)     
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write      ",""tarID"": " & tarID 
    response.Write  "}"
    objconexao.Fecharconexao(cn)
end function

function alterarTarefa()
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objTarefa = new cTarefa
    objTarefa.setId(CInt(request("tarID")))
    objTarefa.setTitulo(replace(request("tartitulo"),"'","''"))
    objTarefa.setGeradorId(replace(request("geradorID"),"'","''"))
    objTarefa.setDescricao(replace(request("tarDescricao"),"'","''"))
    objTarefa.setStatus(replace(request("tarstatus"),"'","''"))
    objTarefa.setDataGeracao(FormatarDataBanco(request("tardata")))
    tarID = objTarefa.UpdateTarefa(cn,ObjTarefa)
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
    objconexao.Fecharconexao(cn)
end function

function deletarTarefa()
    tarID = CInt(request("tarID"))
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objTarefa = new cTarefa
    ObjTarefa.setId(CInt(request("tarID")))
    rs = ObjTarefa.ExcluirTarefa(cn,tarID)
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
    objconexao.Fecharconexao(cn)
end function

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
        if Npagina > Ndepaginas then
            Npagina = Ndepaginas
        end if
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