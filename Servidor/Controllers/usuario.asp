<!-- #include file = "../Models/Conexao.class.asp" -->
<!-- #include file = "../Models/Usuario.class.asp" -->
<%  
stop
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
    set objusuario = new cUsuario
    set rs = objusuario.BuscarUsuarioPorId(cn, usuId)
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
stop
    set objconexao = new Conexao
    set cn = objconexao.AbreConexao()
    set objUsuario = new cUsuario
    ObjUsuario.setUsuario(Request("usuario"))
    ObjUsuario.setSenha(Request("senha"))
    ObjUsuario.setNome(Request("nome"))
    ObjUsuario.setEndereco(Request("endereco"))
    ObjUsuario.setCidade(Request("cidade"))
    ObjUsuario.setCep(Request("cep"))
    ObjUsuario.setIdEstado(Request("estadoid"))
    if validaNome(usuario,senha,nome,endereco,cidade,cep,estadoid) then
        set rs = objusuario.InsercaoUsuario(cn, objUsuario)     
        if not rs.eof then
            usuid = cint(rs("UsuID"))
        end if
        rs.Close
    end if

    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write      ",""UsuID"": " & usuid 
    response.Write  "}"

    objconexao.Fecharconexao(cn)
end function

function alterarUsuario()
    usuid = CInt(request("usuid"))
    usuario = cstr("" & Replace(request.form("usuario"),"'","''"))
    senha = cstr("" & Replace(request.form("senha"),"'","''"))
    nome = cstr("" & Replace(request.form("nome"),"'","''"))
    endereco = cstr("" & Replace(request.form("endereco"),"'","''"))
    cidade = cstr("" & Replace(request.form("cidade"),"'","''"))
    cep = cstr("" & Replace(request.form("cep"),"'","''"))
    estadoid = cstr("" & Replace(request.form("estadoid"),"'","''"))

    if validaNome(usuario,senha,nome,endereco,cidade,cep,estadoid) then
        cn.execute("update usuario SET usuario = '"& usuario &"', senha = '"& senha &"', nome = '"& nome &"', endereco = '"& endereco &"', cidade = '"& cidade &"', cep = '"& cep &"', estadoid = '"& estadoid &"' where usuid ="& usuid )
    end if
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"
end function

function deletarUsuario()
    
    usuid = CInt(request("usuid"))
    cn.execute("delete from usuario where usuid ="& usuid )  
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"

end function

function limparCampos()
    
    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write  "}"

end function

function validaNome(usuario,senha,nome,endereco,cidade,cep,estadoid) 

      dim resultado: resultado = true    
     
        if usuario = "" then 
           resultado = false 
        end if
        if senha = "" then 
           resultado = false 
        end if
        if nome = "" then 
           resultado = false 
        end if
        if endereco = "" then 
           resultado = false 
        end if
        if cidade = "" then 
           resultado = false 
        end if
        if cep = "" then 
           resultado = false 
        end if
        if estadoid = "" then 
           resultado = false 
        end if

       validaNome = resultado
    end function 
%>