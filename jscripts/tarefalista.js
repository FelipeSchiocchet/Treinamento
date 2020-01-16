(function () {
    adicionarEventos();
})();

function adicionarEventos() {
    
}



function mudarImagem(objImagem, tarID) {
    if (objImagem.src.indexOf("0") > -1) {         
        objImagem.src = "./imagens/7.gif";
        status = 7;
    }
    else if (objImagem.src.indexOf("7") > -1) {
        objImagem.src = "./imagens/9.gif";
        status = 9;
    }
    else if (objImagem.src.indexOf("9") > -1) {
        objImagem.src = "./imagens/1.gif";
        status = 1;
    }
    else if (objImagem.src.indexOf("1") > -1) {
        objImagem.src = "./imagens/0.gif";
        status = 0;

    }
    return $.ajax({
        url: "update.asp",
        type: 'POST',
        data: {
            "status": status,
            "id": tarID
        },
        success: function (status) {
            if (objImagem.src.indexOf("1") > -1) {      
            alert('Tarefa não iniciada')    
            }
            else if (objImagem.src.indexOf("0") > -1) {
                alert('Tarefa em andamento')
            }
            else if (objImagem.src.indexOf("7") > -1) {
                alert('Tarefa Cancelada')
            }
            else if (objImagem.src.indexOf("9") > -1) {
                alert('Tarefa concluída')
            }
            location.reload();
        },
        error: function (xhr, status, error) {
            alert("Erro: " + error.Message);
        }
    });
}


function myFunction(event) {

    if (event.keyCode === 13) {
        event.preventDefault();
        document.getElementById("input").submit();
    }
}



function edicaoTarefa(tableData, tarID) {
    var titulo = tableData.textContent;
    tableData.textContent = "";
    var input = document.createElement("input");
    input.value = titulo;

    input.addEventListener('keydown', function (e) {
debugger
        if (e.keyCode == 13) {

            salvaTarefa(input.value, tarID);
        }
        if (e.keyCode == 27) {
            e.target.parentElement.innerHTML = titulo;
        }
    });
    input.addEventListener('blur', function (e) {
        debugger
        e.target.parentElement.innerHTML = titulo;
    });

    tableData.appendChild(input);
 }   
   


function salvaTarefa(txt, tarID) {

    return $.ajax({
        url: "update.asp",
        type: 'POST',
        data: {
            "titulo": txt,
            "id": tarID
        },
        success: function (titulo) {
            location.reload();
        },
        error: function (xhr, titulo, error) {
            alert("Erro: " + error.Message);
        }
    });
}

