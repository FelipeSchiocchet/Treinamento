<%
Class Conexao

    Private DataSource
    Private DataBase
    Private Usuario
    Private Senha

    Public function getDataSource()
        getDataSource = DataSource
    End function

    Public sub setDataSource(byval p_dataSource)
        DataSource = p_dataSource
    End sub	
    
    Public function getDataBase()
        getDataBase = DataBase
    End function

    Public sub setDataBase(byval p_dataBase)
        DataBase = p_dataBase
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

    public function AbreConexao()
        dim DataSource : DataSource= "ES203"
        dim DataBase : DataBase = "treinamento"
        dim Usuario : Usuario = "sa"
        dim Senha : Senha = "Ss123456"
        dim stringConexao : stringConexao = "Data Source=" & Datasource & ";Initial Catalog=" & DataBase & ";User Id=" & Usuario & ";Password=" & Senha
        Set cn = Server.CreateObject("ADODB.Connection")
        cn.Provider = "sqloledb"
        cn.Open(stringConexao)
		set AbreConexao = cn
	end function

    public function FecharConexao(cn)
        cn.Close()
	end function
End Class%>