<%  
    dim cn
    set cn = Server.CreateObject("ADODB.Connection")
    cn.Provider = "sqloledb" 
    cn.Open("Server=ES203;Database=treinamento;User Id=sa;Password=Ss123456;")     
%>