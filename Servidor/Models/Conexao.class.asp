<%

Class Conexao

    '

    ' Propriedades da classe

    '

    Private DataSource

    Private DataBase

    Private Usuario

    Private Senha



    '

    ' M�todos Get e Set de cada propriedade

    '

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



    '

    ' M�todos complementares  

    '

  

    'Abre uma conexao

    public function AbreConexao()

        '

        ' TODO L�gica de abertura de uma conex�o

        ' precisa ter uma forma de pegar os dados da conex�o de um arquivo de configura��o

        ' quer seja um arquivo de vari�veis de ambiente, ou um web.config

        ' precisa ter os seguintes valores no arquivo ou variavel de ambiente:

        '   - Datasource

        '   - DataBase

        '   - Usuario

        '   - Senha 

        '

        dim DataSource : DataSource= "localhost"

        dim DataBase : DataBase = "treinamento"

        dim Usuario : Usuario = "sa"

        dim Senha : Senha = "123456"

        dim stringConexao : stringConexao = "Data Source=" & Datasource & ";Initial Catalog=" & DataBase & ";User Id=" & Usuario & ";Password=" & Senha

        Set cn = Server.CreateObject("ADODB.Connection")

        cn.Provider = "sqloledb"

        cn.Open(stringConexao)

		set AbreConexao = cn

	end function

    

    'Fecha uma conex�o

    public function FecharConexao(cn)

        '

        ' TODO L�gica para fechamento de uma conex�o

        '

        cn.Close()

	end function

End Class%>