<!-- #include file = "../configs/config.asp" -->
<!-- #include file = "../class/validacao.asp" -->
<% 
if (Request("fnTarget") <> "") then
    Execute(Request("fnTarget") & "()")
end if

dim usuario, senha, nome, endereco, cidade, cep, estadoid, geradorID
dim recordSet
dim rs
dim records
dim usuid
dim usuNome
    stop
        usuid = CInt(request("usuid")) 
                if not isEmpty(request.form) then
                end if
                if usuid <> "" then        
                    set rs = cn.execute("select * from usuario where usuid = "& usuid )     
                    if not rs.eof then
                        usuario = rs("usuario")
                        senha = rs("senha")
                        nome = rs("nome")
                        endereco = rs("endereco")
                        cidade = rs("cidade")
                        cep = rs("cep")
                        estadoid = rs("estadoid")
                    end if
                end if
                set records = cn.execute("select * from tarefa where geradorID ="& usuid) 
                if records.eof then
                    geradorID = 0
                else
                    geradorID = records("geradorID")
                end if
function cadastrarUsuario()

    usuario = cstr("" & Replace(request.form("usuario"),"'","''"))
    senha = cstr("" & Replace(request.form("senha"),"'","''"))
    nome = cstr("" & Replace(request.form("nome"),"'","''"))
    endereco = cstr("" & Replace(request.form("endereco"),"'","''"))
    cidade = cstr("" & Replace(request.form("cidade"),"'","''"))
    cep = cstr("" & Replace(request.form("cep"),"'","''"))
    estadoid = cstr("" & Replace(request.form("estadoid"),"'","''"))

    if validaNome(usuario,senha,nome,endereco,cidade,cep,estadoid) then
        cn.execute("insert into usuario (usuario, senha, nome, endereco, cidade, cep, estadoid) VALUES ('"& usuario &"', '"& senha &"', '"& nome &"', '"& endereco &"', '"& cidade &"' ,'"& cep &"', '"& estadoid &"'); ")
        set rs = cn.execute("select TOP 1 usuid FROM usuario ORDER BY usuid DESC")     
        if not rs.eof then
            usuid = cint(rs("UsuID"))
        end if
    end if

    Response.ContentType = "application/json"

    response.Write  "{"
    response.Write      """sucesso"":""true"""
    response.Write      ",""UsuID"": " & usuid 
    response.Write  "}"

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
    response.Write "true"
end function

function deletarUsuario()

    usuid = CInt(request("usuid"))
    cn.execute("delete from usuario where usuid ="& usuid )  
    response.Write "true"

end function
%>