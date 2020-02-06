<!-- #include file = "../Models/Conexao.class.asp" -->
<!-- #include file = "../Models/Usuario.class.asp" -->
<%

if (Request("fnTarget") <> "") then
    Execute(Request("fnTarget") & "()")
end if
 
function validarLogon()
    dim usuario
    dim senha
    dim rs
    dim retorno : retorno = "false"

    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objUsuario = new cUsuario
    ObjUsuario.setUsuario(replace(Request("usuario"),"'","''"))
    ObjUsuario.setSenha(replace(Request("senha"),"'","''"))
    set rs = objUsuario.BuscarUsuarioPorNomeSenha(cn, ObjUsuario)
   
    if (not rs.eof) then
        Session("usuario") = "logado"
        retorno = "true"
    end if  
    
    Response.ContentType = "application/json"
    response.Write  "{"
    response.Write      """retorno"": " & retorno 
    response.Write  "}"
    
    rs.Close
    objconexao.Fecharconexao(cn)
end function
%>