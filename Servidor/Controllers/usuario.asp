<!-- #include file = "../Models/Conexao.class.asp" -->
<!-- #include file = "../Models/Usuario.class.asp" -->
<%  
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
    RegistrosPorPagina = CInt(Request("RegistrosPorPagina"))
    Npagina = CInt(Request("PaginaPesquisa"))
    Execute(Request("fnTarget") & "()")
end if
    
dim usuario, senha, nome, endereco, cidade, cep, estadoid, geradorID
dim recordSet
dim rs
dim records
dim usuid
dim intLimit
dim Npagina

function colocarDados    
    usuid = CInt(request("usuid"))
    if usuid <> "" then        
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objUsuario = new cUsuario
    set rs = objUsuario.BuscarUsuarioPorId(cn, usuId)
    set records = cn.execute("select * from tarefa where geradorID ="& usuid) 
        if records.eof then
            geradorID = 0
        else
            geradorID = records("geradorID")
        end if
        records.Close
        if not rs.eof then
            response.Write  "{"   
            response.Write      """usuario"": """ & rs("usuario") & """"
            response.Write      ",""senha"": """ & rs("senha") & """"
            response.Write      ",""nome"": """ & rs("nome") & """"
            response.Write      ",""endereco"": """ & rs("endereco") & """"
            response.Write      ",""cidade"": """ & rs("cidade") & """"
            response.Write      ",""cep"": """ & rs("cep") & """"
            response.Write      ",""estadoid"": " & rs("estadoid") & ""
            response.Write      ",""geradorID"": " & geradorID & ""
            response.Write  "}"
        end if
    end if
    rs.Close
    objconexao.Fecharconexao(cn)
end function

function cadastrarUsuario()
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objUsuario = new cUsuario
    ObjUsuario.setUsuario(replace(request("usuario"),"'","''"))
    ObjUsuario.setSenha(replace(request("senha"),"'","''"))
    ObjUsuario.setNome(replace(request("nome"),"'","''"))
    ObjUsuario.setEndereco(replace(request("endereco"),"'","''"))
    ObjUsuario.setCidade(replace(request("cidade"),"'","''"))
    ObjUsuario.setCep(replace(request("cep"),"'","''"))
    ObjUsuario.setIdEstado(request("estadoid"))
    usuid = objUsuario.InsercaoUsuario(cn, objUsuario)
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write      ",""UsuID"": " & usuid 
    response.Write  "}"
    objconexao.Fecharconexao(cn)
end function

function alterarUsuario()
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objUsuario = new cUsuario
    ObjUsuario.setId(CInt(request("usuid")))
    ObjUsuario.setUsuario(replace(request("usuario"),"'","''"))
    ObjUsuario.setSenha(replace(request("senha"),"'","''"))
    ObjUsuario.setNome(replace(request("nome"),"'","''"))
    ObjUsuario.setEndereco(replace(request("endereco"),"'","''"))
    ObjUsuario.setCidade(replace(request("cidade"),"'","''"))
    ObjUsuario.setCep(replace(request("cep"),"'","''"))
    ObjUsuario.setIdEstado(request("estadoid"))
    rs = ObjUsuario.UpdateUsuario(cn, ObjUsuario)  
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
    objconexao.Fecharconexao(cn)
end function

function deletarUsuario()
    usuid = CInt(request("usuid"))
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objUsuario = new cUsuario
    ObjUsuario.setId(CInt(request("usuid")))
    rs = ObjUsuario.ExcluirUsuario(cn, usuid)  
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
    objconexao.Fecharconexao(cn)
end function

function limparCampos()
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
end function 

function BuscarUsuariosPaginados()
    dim palavraParaPesquisa:palavraParaPesquisa = Request("palavraParaPesquisa")
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objUsuario = new cUsuario
    set recordSet = ObjUsuario.BuscarUsuarios(cn,palavraParaPesquisa)
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
                response.Write      """Nome"": """ & replace(recordSet("nome"),"'","''") & """"
                response.Write      ",""Usuario"": """ & replace(recordSet("usuario"),"'","''") & """"
                response.Write      ",""Endereco"": """ & replace(recordSet("endereco"),"'","''") & """"
                response.Write      ",""Cidade"": """ & replace(recordSet("cidade"),"'","''") & """"
                response.Write      ",""Cep"": """ & replace(recordSet("cep"),"'","''") & """"
                response.Write      ",""usuid"":""" & replace(recordSet("usuid"),"'","''") &""""
            response.Write  "}"
            registrosdaPagina = registrosdaPagina + 1
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
%>