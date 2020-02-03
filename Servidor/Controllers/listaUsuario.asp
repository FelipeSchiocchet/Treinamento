<!-- #include file = "../Models/Conexao.class.asp" -->
<!-- #include file = "../Models/Usuario.class.asp" -->
<%
Response.CodePage = 65001
Response.CharSet = "UTF-8"
'Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
    RegistrosPorPagina = CInt(Request("RegistrosPorPagina"))
    Npagina = CInt(Request("PaginaPesquisa"))
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

function BuscarUsuariosPaginados()
    dim palavraParaPesquisa:palavraParaPesquisa = Request("palavraParaPesquisa")
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objUsuario = new cUsuario
    set recordSet = ObjUsuario.BuscarUsuarios(cn,palavraParaPesquisa)
   
    if not recordSet.eof then
        recordSet.pageSize = RegistrosPorPagina
        Ndepaginas = recordSet.PageCount
        intTotal = recordSet.recordcount
        if Npagina <= 0 then
                Npagina = 1
        end if    
        If Npagina > Ndepaginas Then
            Npagina = Ndepaginas
        End if
        recordSet.AbsolutePage = Npagina
        fimPagina = registrosPorPagina * Npagina     
        response.Write "{"
        response.Write """TotalRegistros"":""" & intTotal & """"
        response.Write ",""RegistrosPorPagina"":""" & RegistrosPorPagina & """"
        response.Write ",""PaginaAtual"":""" & Npagina & """"
        response.Write ",""TotalPaginas"":""" & Ndepaginas & """"
        response.Write ",""Dados"":["
         Do While not recordSet.eof and (recordSet.AbsolutePosition <= fimPagina)
            response.Write  "{"
                response.Write      """Nome"": """ & recordSet("nome") & """"
                response.Write      ",""Usuario"": """ & recordSet("usuario") & """"
                response.Write      ",""Endereco"": """ & recordSet("endereco") & """"
                response.Write      ",""Cidade"": """ & recordSet("cidade") & """"
                response.Write      ",""Cep"": """ & recordSet("cep") & """"
                response.Write      ",""usuid"":""" & recordSet("usuid") &""""
            response.Write  "}"
            recordSet.MoveNext
            if (not recordSet.eof and recordSet.AbsolutePosition <= fimPagina) then
                response.Write ","
            end if   
        Loop
        response.Write "]"
        response.Write "}" 
    end if
    recordSet.close()
    
end function 

%>