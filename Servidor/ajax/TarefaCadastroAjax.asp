<!-- #include file = "../configs/config.asp" -->
<!-- #include file = "../class/validartarefa.asp" -->
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
        
function buscarUsuarios
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
end function

function converterData(tardata)
    novaData = split(tarData," ")
    Data = split(novaData(0),"/")
    Data2 = Data(2) & "-" & Data(1) & "-" & Data(0)
    converterData = Data2 & "T" & NovaData(1)
end function                        

function colocarDados    
    tarID = CInt(request("tarID")) 
    
    if tarID <> "" then        
        set rs = cn.execute("select * from tarefa where tarID = "& tarID )     
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
   
end function

function cadastrarTarefa()
    tarTitulo = cstr("" & Replace(request.form("tarTitulo"),"'","''"))
    geradorID = cstr("" & Replace(request.form("geradorID"),"'","''"))
    tarData = Cdate(cstr("" & Replace(request.form("tarData"),"T"," ")))
    tarStatus = cstr("" & Replace(request.form("tarStatus"),"'","''"))
    tarDescricao = cstr("" & Replace(request.form("tarDescricao"),"'","''"))

    if validaNome(tarTitulo,geradorID,tarData,tarStatus,tarDescricao) then
        cn.execute("insert into tarefa (tarTitulo,geradorID,tarData,tarStatus,tarDescricao) VALUES ('"& tarTitulo &"', '"& geradorID &"', '"& tarData &"', '"& tarStatus &"', '"& tarDescricao &"'); ")
        set rs = cn.execute("select TOP 1 tarID FROM tarefa ORDER BY tarID DESC")     
        if not rs.eof then
            tarID = cint(rs("tarID"))
        end if
    end if

    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write      ",""tarID"": " & tarID 
    response.Write  "}"

end function

function alterarTarefa()
    tarID = CInt(request("tarID"))
    tarTitulo = cstr("" & Replace(request.form("tarTitulo"),"'","''"))
    geradorID = cstr("" & Replace(request.form("geradorID"),"'","''"))
    tarData = Cdate(cstr("" & Replace(request.form("tarData"),"T"," ")))
    tarStatus = cstr("" & Replace(request.form("tarStatus"),"'","''"))
    tarDescricao = cstr("" & Replace(request.form("tarDescricao"),"'","''"))

    if validaNome(tarTitulo,geradorID,tarData,tarStatus,tarDescricao) then
        cn.execute("update tarefa SET tarTitulo = '"& tarTitulo &"', geradorID = '"& geradorID &"', tarData = '"& tarData &"', tarStatus = '"& tarStatus &"', tarDescricao = '"& tarDescricao &"' where tarID ="& tarID )
    end if
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
end function

function deletarTarefa()
    
    tarID = CInt(request("tarID"))
    cn.execute("delete from tarefa where tarID ="& tarID )  
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"

end function

%>