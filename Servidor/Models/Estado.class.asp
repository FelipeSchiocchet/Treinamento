<%
Class Estado

    Private Id
    Private Nome

    Public function getId()
        getId = Id
    End function

    Public sub setId(byval p_id)
        Id = p_id
    End sub	

    Public function getNome()
        getNome = Nome
    End function

    Public sub setNome(byval p_nome)
        Nome = p_nome
    End sub

    public function BuscarEstados(cn)
        dim sql : sql = "SELECT * FROM [treinamento].[dbo].[estado]"
        Set rs=Server.CreateObject("ADODB.recordset")
        rs.Open sql, cn, &H0001
        set BuscarEstados = rs
	end function
End Class

%>