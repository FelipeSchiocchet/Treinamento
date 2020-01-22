<!-- #include file = "../configs/config.asp" -->
<%

Response.CodePage = 65001
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"

if (Request("fnTarget") <> "") then
Execute(Request("fnTarget") & "()")
end if
   
dim intLimit
dim numeroAtual
dim Npagina
dim botao
dim btnAcao
dim inputAcao
dim Ndepaginas, Ndepaginas2
     
function BuscarUsuariosPaginados()
    stop      
    inputAcao = request.form("input")
    if inputAcao = "" then 
        btnAcao = request.form("botao")
    else
        btnAcao = 0
    end if
    if inputAcao = "" then 
        if btnAcao = ">>" then
            btnAcao = 1
        end if 
    if btnAcao = "<<" then
        btnAcao = -1
    end if
        inputAcao = 0 
    end if
    Npagina = request.form("Npagina")
           
    Npagina = CInt(Npagina)
    inputAcao = CInt(inputAcao)
                     
    intLimit = 30
    set recordSet = Server.CreateObject("ADODB.recordset")
    call recordSet.Open("SELECT usuid FROM usuario ORDER BY usuid asc;",cn,1,1)
    Ndepaginas =  Round(recordSet.recordcount / 30 + 1)
    Ndepaginas2 = recordSet.recordcount / 30 + 1
    if Ndepaginas >= Ndepaginas2 then
        Ndepaginas = Ndepaginas - 1 
    end if
            
    if btnAcao = "-1" then
        Npagina = Npagina + btnAcao     
    end if
    if btnAcao = "1" then
        Npagina = Npagina + btnAcao   
    end if 
    if not inputAcao = 0 then
        if not inputAcao = "" and inputAcao <= Ndepaginas then               
            Npagina = inputAcao
        else 
            Npagina = Ndepaginas
        end if 
    end if 
    if Npagina <= 0 then
        Npagina = 1
    end if
    if Npagina = 1 then
        voltarDisabled = "disabled"
    end if
    intTotal = recordSet.recordcount
    recordSet.pageSize = intLimit 
    if recordSet.PageCount > 0 then
        if intPagina = 0 then
            intPagina = 1
        end if
        recordSet.AbsolutePage = Npagina
    end if
    strIDs = "0"
    if not recordSet.eof then
        strIDs = recordSet.GetString(,intLimit,"",",","")
        strIDs = left(strIDs, len(strIDs) - 1) 
    end if
    recordSet.close()
    call recordSet.Open("SELECT * FROM usuario WHERE usuid in("& strIDs &") ORDER BY usuid ASC;",cn,1,1)

    recordSet.pageSize = intLimit
            
    numeroAtual = intLimit * (Npagina - 1) + recordSet.recordcount
    
    response.Write "{"
    response.Write """TotalRegistros"":""" & intTotal & """"
    response.Write ",""RegistrosPorPagina"":""" & intLimit & """"
    response.Write ",""PaginaAtual"":""" & Npagina & """"
    response.Write ",""TotalPaginas"":""" & Ndepaginas & """"
    response.Write ",""Dados"":["
    
    Do While (not recordSet.EOF)
        response.Write  "{"
            response.Write      """Nome"": """ & recordSet("nome") & """"
            response.Write      ",""Usuario"": """ & recordSet("usuario") & """"
            response.Write      ",""Endereco"": """ & recordSet("endereco") & """"
            response.Write      ",""Cidade"": """ & recordSet("cidade") & """"
            response.Write      ",""Cep"": """ & recordSet("cep") & """"
            response.Write      ",""usuid"":""" & recordSet("usuid") &""""
        response.Write  "}"
        if recordSet.AbsolutePosition < recordSet.RecordCount then
            response.Write ","
        end if   
        recordSet.MoveNext
    Loop
    response.Write "]"
    response.Write "}" 

    recordSet.close()
    if numeroAtual = intTotal then
        voltarDisableddenovo = "disabled"
    end if
end function 

%>