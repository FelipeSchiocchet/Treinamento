<!-- #include file = "configs/config.asp" -->
<%  

    tarID = request("id")
    tarStatus = request("status")
    tarTitulo = request("titulo")
    sql = "update tarefa SET "
    if tarStatus <> "" then 
    sql = sql & "tarStatus ="& tarStatus
    end if
    if tarTitulo <> "" then 
        sql = sql & "tarTitulo ='"& tarTitulo&"'"
    end if
     
    sql = sql & " where tarID ="& tarID 

    Set recordSet = cn.execute(sql)
    
    %>