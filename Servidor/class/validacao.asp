<%  
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