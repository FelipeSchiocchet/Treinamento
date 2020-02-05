<%
Class cTarefa
    '
    ' Propriedades da classe
    '
    Private Id
    Private Titulo
    Private GeradorId
    Private DataGeracao
    Private Status
    Private Descricao

    '
    ' Métodos Get e Set de cada propriedade
    '
    Public function getId()
        getId = Id
    End function

    Public sub setId(byval p_id)
        Id = p_id
    End sub	

    Public function getTitulo()
        getTitulo = Titulo
    End function

    Public sub setTitulo(byval p_Titulo)
        Titulo = p_Titulo
    End sub
	
    Public function getGeradorId()
        getGeradorId = GeradorId
    End function

    Public sub setGeradorId(byval p_GeradorId)
        GeradorId = p_GeradorId
    End sub

    Public function getDataGeracao()
        getDataGeracao = DataGeracao
    End function

    Public sub setDataGeracao(byval p_DataGeracao)
        DataGeracao = p_DataGeracao
    End sub
 
    Public function getStatus()
        getStatus = Status
    End function

    Public sub setStatus(byval p_Status)
        Status = p_Status
    End sub

    Public function getDescricao()
        getDescricao = Descricao
    End function

    Public sub setDescricao(byval p_Descricao)
        Descricao = p_Descricao
    End sub

    public function InsercaoTarefa(cn,ObjTarefa)
        sql="INSERT INTO [dbo].[tarefa] ([tarTitulo],[geradorID],[tarData],[tarStatus],[tarDescricao]) VALUES ("
        sql=sql & "'" & ObjTarefa.getTitulo() & "',"
        sql=sql & "'" & ObjTarefa.getGeradorId() & "',"
        sql=sql & "'" & ObjTarefa.getDataGeracao() & "',"
        sql=sql & "'" & ObjTarefa.getStatus() & "',"
        sql=sql & "'" & ObjTarefa.getDescricao() & "');"
        on error resume next
        cn.Execute(sql)
        if err<>0 then
            InsercaoTarefa =  err.Description
        else    
            Set rs=Server.CreateObject("ADODB.recordset")
            rs.Open "SELECT SCOPE_IDENTITY() As tarID;", cn
            InsercaoTarefa = rs("tarID").value
            rs.close()
        end if
	end function

    public function UpdateTarefa(cn,ObjTarefa)
        sql="UPDATE [dbo].[tarefa] SET "
        sql=sql & "[tarTitulo] = '" & ObjTarefa.getTitulo() & "',"
        sql=sql & "[geradorID] = '" & ObjTarefa.getGeradorId() & "',"
        sql=sql & "[tarData] = '" & ObjTarefa.getDataGeracao() & "',"
        sql=sql & "[tarStatus] = '" & ObjTarefa.getStatus() & "',"
        sql=sql & "[tarDescricao] = '" & ObjTarefa.getDescricao() & "'"
        sql=sql & " WHERE [tarID]=" & ObjTarefa.getId() & ";"
        on error resume next
        cn.Execute(sql)
        if err<>0 then
            UpdateTarefa =  err.Description
        else    
            UpdateTarefa = Cint(ObjTarefa.getId())
        end if
	end function
    
    public function AlterarTitulo(cn,ObjTarefa)
        sql="UPDATE [dbo].[tarefa] SET "
        sql=sql & "[tarTitulo] = '" & ObjTarefa.getTitulo() & "'"       
        sql=sql & " WHERE [tarID]=" & ObjTarefa.getId() & ";"
        on error resume next
        cn.Execute(sql)
        if err<>0 then
            UpdateTitulo =  err.Description
        else    
            UpdateTitulo = Cint(ObjTarefa.getId())
        end if
	end function

    public function AlterarStatus(cn,ObjTarefa)
        sql="UPDATE [dbo].[tarefa] SET "
        sql=sql & "[tarStatus] = '" & ObjTarefa.getStatus() & "'"
        sql=sql & " WHERE [tarID]=" & ObjTarefa.getId() & ";"
        on error resume next
        cn.Execute(sql)
        if err<>0 then
            AlterarStatus =  err.Description
        else    
            AlterarStatus = Cint(ObjTarefa.getId())
        end if
	end function

    public function ExcluirTarefa(cn,tarID)
        if(tarID="") then
            ExcluirTarefa = "Usuário não informado"
        else
            sql="DELETE FROM [tarefa] WHERE [tarID]='" & tarID & "'"
            on error resume next
            cn.Execute sql, recaffected
            if err<>0 then
                ExcluirTarefa =  err.Description
            else    
                ExcluirTarefa = recaffected
            end if
        end if
    end function

    public function BuscarTarefas(cn, palavraParaPesquisa, colunaOrdenacao)
        sqlPesquisa = "SELECT [tarID],[tarTitulo],[tarDescricao],[tarData],[tarStatus] "
        sqlPesquisa = sqlPesquisa & "FROM [tarefa] WHERE [tarTitulo] LIKE '%"
        sqlPesquisa = sqlPesquisa & Replace(palavraParaPesquisa, "'", "''") & "%'"
        sqlPesquisa = sqlPesquisa & " ORDER BY " & colunaOrdenacao
        Set rs = Server.CreateObject("ADODB.recordset")
        rs.CursorLocation = 3 ' adUseClient
        rs.Open sqlPesquisa, cn, &H0001
		set BuscarTarefas = rs
	end function

    public function BuscarTarefaPorId(cn,tarID)
        sql = "SELECT * FROM [tarefa] where [tarID]='" & tarID & "'" 
        Set rs = Server.CreateObject("ADODB.recordset")
        rs.Open sql, cn, &H0001
        set BuscarTarefaPorId = rs
    end function
End Class


%>