<!-- #include file = "../configs/config.asp" -->
<!-- #include file = "../class/validartarefa.asp" -->
<% 
Response.CodePage = 65001
Response.CharSet = "UTF-8"
if (Request("fnTarget") <> "") then
    Execute(Request("fnTarget") & "()")
end if
    
    dim tarTitulo, geradorID, tarDescricao, tarStatus, tarData, tarData2
    dim recordSet
    dim rs
    dim btnAcao
    dim tarID
    dim novaData
    dim Data, Data2, novavar

    function cadastrarTarefa() 

    tarTitulo = cstr("" & Replace(request.form("tarTitulo"),"'","''"))
    geradorID = cstr("" & Replace(request.form("geradorID"),"'","''"))
    tarDescricao = cstr("" & Replace(request.form("tarDescricao"),"'","''"))
    tarStatus = cstr("" & Replace(request.form("tarStatus"),"'","''"))
    tarData2 = Replace(Request.Form("tarData"),"T"," ")
    stop
    tarData = Cdate(tarData2)                      
            if validaNome(tarTitulo,geradorID,tarDescricao,tarStatus,tarData) then
                cn.execute("insert into tarefa (tarTitulo,geradorID,tarStatus,tarDescricao,tarData) VALUES ('"& tarTitulo &"', '"& geradorID &"', '"& tarStatus &"', '"& tarDescricao &"', '"& tarData &"'); ")                          
                set rs = cn.execute("select TOP 1 tarID FROM tarefa ORDER BY tarID DESC")                                  
                if not rs.eof then                            
                    tarID = rs("tarID")                          
                end if                 
            end if

    Response.ContentType = "application/json"

    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write      ",""tarID"": " & tarID 
    response.Write  "}"

    end function

    function alterarTarefa()

    tarID=request("tarID")
    tarTitulo = cstr("" & Replace(request.form("tarTitulo"),"'","''"))
    geradorID = cstr("" & Replace(request.form("geradorID"),"'","''"))
    tarDescricao = cstr("" & Replace(request.form("tarDescricao"),"'","''"))
    tarStatus = cstr("" & Replace(request.form("tarStatus"),"'","''"))
    tarData2 = Replace(Request.Form("tarData"),"T"," ")
    tarData = Cdate(tarData2)

    if validaNome(tarTitulo,geradorID,tarDescricao,tarStatus,tarData) then
        cn.execute("update tarefa SET tarTitulo = '"& tarTitulo &"', geradorID = '"& geradorID &"', tarStatus = '"& tarStatus &"', tarDescricao = '"& tarDescricao &"', tarData = '"& tarData &"' where tarID ="& tarID )
    end if
    response.Write "true"
    end function

    function deletarTarefa()

    tarID=request("tarID")
    cn.execute("delete from tarefa where tarID ="& tarID )  
    response.Write "true"

    end function
%>