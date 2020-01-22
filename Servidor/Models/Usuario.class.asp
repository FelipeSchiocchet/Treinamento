<%

Class cUsuario

    '

    ' Propriedades da classe

    '

    Private Id

    Private Usuario

    Private Senha

    Private Nome

    Private Endereco

    Private Cidade

    Private Cep

    Private IdEstado



    '

    ' Métodos Get e Set de cada propriedade

    '

    Public function getId()

        getId = Id

    End function



    Public sub setId(byval p_id)

        Id = p_id

    End sub	



    Public function getUsuario()

        getUsuario = Usuario

    End function



    Public sub setUsuario(byval p_usuario)

        Usuario = p_usuario

    End sub

	

    Public function getSenha()

        getSenha = Senha

    End function



    Public sub setSenha(byval p_senha)

        Senha = p_senha

    End sub



    Public function getNome()

        getNome = Nome

    End function



    Public sub setNome(byval p_nome)

        Nome = p_nome

    End sub

 

    Public function getEndereco()

        getEndereco = Endereco

    End function



    Public sub setEndereco(byval p_endereco)

        Endereco = p_endereco

    End sub



    Public function getCidade()

        getCidade = Cidade

    End function



    Public sub setCidade(byval p_cidade)

        Cidade = p_cidade

    End sub



    Public function getCep()

        getCep = Cidade

    End function



    Public sub setCep(byval p_cep)

        Cep = p_cep

    End sub

    

    Public function getIdEstado()

        getIdEstado = IdEstado

    End function



    Public sub setIdEstado(byval p_IdEstado)

        IdEstado = p_IdEstado

    End sub





    '

    ' Métodos complementares

    '

	

    'Inserção de usuários

    public function InsercaoUsuario(cn,ObjUsuario)

        '

        ' TODO Lógica de inserção de usuários novos

        '

        stop

        sql="INSERT INTO [dbo].[usuario] (usuario,senha,nome,endereco,cidade,cep,estadoid) VALUES ("

        sql=sql & "'" & ObjUsuario.getUsuario() & "',"

        sql=sql & "'" & ObjUsuario.getSenha() & "',"

        sql=sql & "'" & ObjUsuario.getNome() & "',"

        sql=sql & "'" & ObjUsuario.getEndereco() & "',"

        sql=sql & "'" & ObjUsuario.getCidade() & "',"

        sql=sql & "'" & ObjUsuario.getCep() & "',"

        sql=sql & "'" & ObjUsuario.getIdEstado() & "');SELECT SCOPE_IDENTITY() As usuid"

        on error resume next

        'Set rs=Server.CreateObject("ADODB.recordset")

        set rs = cn.Execute(sql)

        'rs.Open "select @@identity as 'usuid';", cn

         usid = rs("usuid")

        set InsercaoUsuario =0

        'if err=0 then

         '   set InsercaoUsuario = "Registro gravado com sucesso"

        'end if        

	end function



    'Update de usuários

    public function UpadateUsuario(Id)

        '

        ' TODO Lógica de update de usuários

        '

		set UpadateUsuario = rs

	end function



    'Buscar usuários do banco de dados

    public function BuscarUsuarios(cn, palavraParaPesquisa)

        '

        ' TODO Lógica para busca de usuários

        '

        ' definir o SQL para pesquisa de acordo com a entrada

        ' Irá buscar todos os registros na tabela que contem os caracteres da pesquisa

        sql = "SELECT [nome],[usuario],[endereco],[cidade],[cep],[usuid] FROM [treinamento].[dbo].[usuario]"

        sqlPesquisa = "SELECT [usuid],[nome],[usuario],[endereco],[cidade],[cep] "

        sqlPesquisa = sqlPesquisa & "FROM [treinamento].[dbo].[usuario] WHERE [usuario] LIKE '%"

        sqlPesquisa = sqlPesquisa & Replace(palavraParaPesquisa, "'", "''") & "%'"

        Set rs=Server.CreateObject("ADODB.recordset")

        rs.CursorLocation = 3 ' adUseClient

        rs.Open sqlPesquisa, cn, &H0001

		set BuscarUsuarios = rs

	end function



    '

    'Buscar um usuário para efetuar o login

    '

    public function BuscarUsuarioPorNomeSenha(cn,usuario,senha)        

        sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuario='" & usuario & "' and senha='" & senha & "'" 

        Set rs=Server.CreateObject("ADODB.recordset")

        rs.Open sql, cn, &H0001

        set BuscarUsuarioPorNomeSenha = rs

    end function

    

    '

    'Buscar um usuário para efetuar o login

    '

    public function BuscarUsuarioPorId(cn,usuId)  

        sql = "SELECT * FROM [treinamento].[dbo].[usuario] where usuId='" & usuId & "'" 

        Set rs=Server.CreateObject("ADODB.recordset")

        rs.Open sql, cn, &H0001

        set BuscarUsuarioPorId = rs

    end function

End Class





%>