<!-- #include file = "./Models/Conexao.class.asp" -->
<!-- #include file = "./Models/Estado.class.asp" -->
<% 
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
    Execute(Request("fnTarget") & "()")
end if

function buscarEstados
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objestado = new Estado
    set recordSet = objestado.BuscarEstados(cn)

    response.Write "{"
    response.Write """Estados"":["

    Do While (not recordSet.EOF)
        response.Write  "{"
        response.Write      """estadoid"": " & recordSet("estadoid")
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
%>