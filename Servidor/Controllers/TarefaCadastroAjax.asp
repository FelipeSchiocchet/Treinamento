<!-- #include file = "../Models/Conexao.class.asp" -->
<!-- #include file = "../Models/Tarefa.class.asp" -->
<%  
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
    Execute(Request("fnTarget") & "()")
end if
    
dim tarTitulo, geradorID, tarDescricao, tarStatus, tarData, tarData2
dim recordSet
dim rs
dim btnAcao
dim tarID
dim novaData
dim Data, Data2
        
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
stop
    novaData = split(tarData," ")
    Data = split(novaData(0),"/")
    Data2 = Data(2) & "-" & Data(1) & "-" & Data(0)
    if (UBound(novaData)>0) then
    converterData = Data2 & "T" & novaData(1)
    else
    converterData = Data2 & "T00:00"
    end if 
end function                        

Function FormatarDataBanco(dataSemFormato)
    soHora = split(dataSemFormato,"T")
    d = split(soHora(0),"-")
    FormatarDataBanco = d(0) & "-" & d(2) & "-" & d(1) & " " & soHora(1)
  End Function

function colocarDados  

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
    rs.Close
    objconexao.Fecharconexao(cn)
end function

function cadastrarTarefa()
stop
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objTarefa = new cTarefa
    objTarefa.setTitulo(request("tartitulo"))
    objTarefa.setGeradorId(request("geradorID"))
    objTarefa.setDescricao(request("tarDescricao"))
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
    objTarefa.setTitulo(request("tartitulo"))
    objTarefa.setGeradorId(request("geradorID"))
    objTarefa.setDescricao(request("tarDescricao"))
    objTarefa.setStatus(request("tarstatus"))
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

end function

%>