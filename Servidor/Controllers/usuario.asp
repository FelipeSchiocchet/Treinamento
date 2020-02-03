<!-- #include file = "../Models/Conexao.class.asp" -->
<!-- #include file = "../Models/Usuario.class.asp" -->
<%  
Response.CodePage = 65001
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
    Execute(Request("fnTarget") & "()")
end if
    
dim usuario, senha, nome, endereco, cidade, cep, estadoid, geradorID
dim recordSet
dim rs
dim records
dim usuid
dim usuNome

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
    ObjUsuario.setUsuario(request("usuario"))
    ObjUsuario.setSenha(request("senha"))
    ObjUsuario.setNome(request("nome"))
    ObjUsuario.setEndereco(request("endereco"))
    ObjUsuario.setCidade(request("cidade"))
    ObjUsuario.setCep(request("cep"))
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
    ObjUsuario.setUsuario(request("usuario"))
    ObjUsuario.setSenha(request("senha"))
    ObjUsuario.setNome(request("nome"))
    ObjUsuario.setEndereco(request("endereco"))
    ObjUsuario.setCidade(request("cidade"))
    ObjUsuario.setCep(request("cep"))
    ObjUsuario.setIdEstado(request("estadoid"))
    rs = ObjUsuario.UpdateUsuario(cn, ObjUsuario)  
    
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
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

end function

function limparCampos()
    
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"

end function 
%>