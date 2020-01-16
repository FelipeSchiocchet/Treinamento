<!-- #include file = "../configs/config.asp" -->
<%
if (Request("fnTarget") <> "") then
    Execute(Request("fnTarget") & "()")
end if

function validarLogon()

    dim usuario
    dim senha
    dim recordSet
    dim retorno : retorno = "false"

    usuario = replace(Request.Form("usuario"),"'","''")
    senha = replace(Request.Form("senha"),"'","''")

    set recordSet = cn.execute("select * from usuario where usuario = '" & usuario & "' and senha = '" & senha & "'")
   
    if (not recordSet.eof) then
        Session("usuario") = "logado"
        retorno = "true"
    end if  
    
    Response.ContentType = "application/json"
    response.Write  "{"
    response.Write      """retorno"": " & retorno 
    response.Write  "}"

end function
%>