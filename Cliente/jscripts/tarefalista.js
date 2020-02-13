if (PaginaPesquisa = "") then
var PaginaPesquisa = 1;

var RegistrosPorPagina = 30;
window.addEventListener('load', function () {
    BuscarTarefas("BuscarTarefasPaginadas", RegistrosPorPagina, PaginaPesquisa);
});

function BuscarTarefas(fnTarget, RegistrosPorPagina, PaginaPesquisa) {
    dadosPesquisa = {
        "fnTarget": fnTarget,
        "RegistrosPorPagina": RegistrosPorPagina,
        "PaginaPesquisa": PaginaPesquisa,
    }
    return $.ajax({
        url: "../Servidor/Controllers/tarefa.asp",
        type: 'POST',
        data: dadosPesquisa,
        success: function (data) {
            if(typeof data =='string'){
                data = JSON.parse(data);
            }
            PreencheTabela(data);
            AdicionarEventos(data);
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

function PreencheTabela(dados) {
    if (!dados) {
        return;
    }
    var dadosCabecalho = Object.keys(dados.Dados[0]);
    var dadosCorpo = dados.Dados;
    var dadosRodape = {
        "TotalRegistros": dados.TotalRegistros,
        "RegistrosPorPagina": dados.RegistrosPorPagina,
        "PaginaAtual": dados.PaginaAtual,
        "TotalPaginas": dados.TotalPaginas,
    }
    var $tblTarefa = document.getElementById("tblTarefas");
    TabelaCriarCabecalho($tblTarefa, dadosCabecalho);
    TabelaCriarCorpo($tblTarefa, dadosCorpo);
    TabelaCriarRodape($tblTarefa, dadosRodape);
}

function TabelaCriarCabecalho(tabela, dadosCabecalho) {
    var cabecalho = tabela.createTHead();
    var novaLinha = cabecalho.insertRow();
    for (var key of dadosCabecalho) {
        var th = document.createElement("th");
        var texto = document.createTextNode(key);
        if (key == 'usuid') {
            texto = document.createTextNode('Editar');
        }
        th.appendChild(texto);
        novaLinha.appendChild(th);
    }
}

function TabelaCriarCorpo(tabela, dadosCorpo) {
    var tbody = tabela.createTBody();
    for (var element of dadosCorpo) {
        var row = tbody.insertRow();
        for (key in element) {
            var cell = row.insertCell();
            if (key == 'tarID') {
                var a = document.createElement("a");
                var params = new URLSearchParams();
                params.append(key, element[key]);
                var url = 'tarefacadastro.asp?' + params.toString();
                a.href = url;
                a.innerText = element[key];
                cell.appendChild(a);
                continue;
            }
            if (key == 'Titulo') {
                cell.id = element['tarID'];
                cell.addEventListener("dblclick", function (e){
                   editarTitulo(e);
                });
            } 
            if (key == 'Status') {
                var imagem = document.createElement("img");
                imagem.src = "./imagens/" + element[key] + ".gif";
                imagem.setAttribute('Status',element[key]);
                imagem.id = element['tarID'];
                imagem.addEventListener("dblclick", function (e) {
                    mudarImagem(e);
                });
                cell.appendChild(imagem);
                continue;
            }
            var text = document.createTextNode(element[key]);
            cell.appendChild(text);
        }
    }
}

function TabelaCriarRodape(tabela, dados) {
    var tfoot = tabela.createTFoot();//<tfoot></tfoot>
    var row = tfoot.insertRow(0);//<tr></tr>
    var cell2 = row.insertCell(0);//<th></th>
    cell2.colSpan = 4;
    var cell = row.insertCell(0);//<th></th>
    cell.colSpan = 1;
    var div = document.createElement("div");//<div></div>
    div.setAttribute("class", "pagination");//<div class="pagination">
    var div2 = document.createElement("div");//<div></div>
    div2.setAttribute("class", "motrarRegistros");//<div class="motrarRegistros">

    var ul = document.createElement("ul");//<ul></ul>;
    var ul2 = document.createElement("ul");//<ul></ul>;

    var linkVoltaUmaPagina = document.createElement("b");//<a></a>
    var liVoltaUmaPagina = document.createElement("button");//<li></li>;
    liVoltaUmaPagina.innerText = "<<";// <<
    liVoltaUmaPagina.type = "submit";//type="submit"
    liVoltaUmaPagina.id = "botaovoltar";// id="botaovoltar""
    liVoltaUmaPagina.classList.add("botaovoltar");// class="botaovoltar""
    linkVoltaUmaPagina.appendChild(liVoltaUmaPagina);//<a href="#"><li> << </li></a>

    var inputPagina = document.createElement("input");// <input/>
    inputPagina.type = "text";//type="text"
    inputPagina.id = "input";// id="input"
    inputPagina.name = "input";//name="input" 
    
    var linkAvancaUmaPagina = document.createElement("b");//<a></a>
    var liAvancaUmaPagina = document.createElement("button");//<li></li>;
    liAvancaUmaPagina.innerText = ">>";// >>
    liAvancaUmaPagina.type = "submit";//type="submit"
    liAvancaUmaPagina.id = "botaoavancar";// id="botaoavancar"
    liAvancaUmaPagina.classList.add("botaoavancar");// class="botaoavancar""
    linkAvancaUmaPagina.appendChild(liAvancaUmaPagina);//<a href="#"><li> >> </li></a>
    
    var liPagina = document.createElement("li");//<li></li>;
    liPagina.innerText = "Página " + dados.PaginaAtual + " de " + dados.TotalPaginas + " Páginas";// Página 1 de 2 Páginas
    var liInfo = document.createElement("li");//<li></li>;
    liInfo.innerText = "Mostrando " + dados.RegistrosPorPagina + " de " + dados.TotalRegistros + " Registros";// Mostrando 2 de 2 registros
    
    ul.appendChild(liVoltaUmaPagina);
    ul.appendChild(inputPagina);
    ul.appendChild(liAvancaUmaPagina);
    div.appendChild(ul);
    cell.appendChild(div);
    ul2.appendChild(liPagina);
    ul2.appendChild(liInfo);
    div2.appendChild(ul2);
    cell2.appendChild(div2);
    
    if (dados.PaginaAtual == dados.TotalPaginas) {
        if (!document.getElementById('botaoavancar').disabled)
        document.getElementById('botaoavancar').disabled = true;
    }
    if (dados.PaginaAtual <= 1) {
        if (!document.getElementById('botaovoltar').disabled)
            document.getElementById('botaovoltar').disabled = true;
        }
}

function mudarImagem(e) {
    debugger;
    var objImagem = e.currentTarget;
    if (objImagem.getAttribute('status') == "0") {
        objImagem.src = "./imagens/7.gif";
        status = 7;
    }
    else if (objImagem.getAttribute('status') == "7") {
        objImagem.src = "./imagens/9.gif";
        status = 9;
    }
    else if (objImagem.getAttribute('status') == "9") {
        objImagem.src = "./imagens/1.gif";
        status = 1;
    }
    else if (objImagem.getAttribute('status') == "1") {
        objImagem.src = "./imagens/0.gif";
        status = 0;
    }
    return $.ajax({
        url: "../Servidor/Controllers/tarefa.asp",
        type: 'POST',
        data: {
            "fnTarget": "salvarStatuseTitulo",
            "status": status,
            "id": objImagem.id
        },
        success: function (status) {
            debugger;
            if (objImagem.getAttribute('status') == "0") {
                alert('Tarefa Cancelada')
            }
            else if (objImagem.getAttribute('status') == "7") {
                alert('Tarefa concluída')
            }
            else if (objImagem.getAttribute('status') == "9") {
                alert('Tarefa não iniciada')
            }
            else if (objImagem.getAttribute('status') == "1") {
                alert('Tarefa em andamento')
            }
            location.reload();
        },
        error: function (xhr, status, error) {
            alert("Erro: " + error.Message);
        }
    });
}

function editarTitulo(e) {
    var titulo = e.currentTarget.innerText;
    var input = document.createElement("input");
    input.value = titulo;
    input.id = e.currentTarget.getAttribute('id');
    e.currentTarget.innerText = "";

    input.addEventListener('keydown', function (e) {
        if (e.keyCode == 13) {
            salvaTarefa(input.value, input.id);
        }
        if (e.keyCode == 27) {
            e.currentTarget.parentElement.innerText = titulo;
            var remove = e.currentTarget;
            remove.remove();            
        }
    });
    input.addEventListener('blur', function (e) {
        e.currentTarget.parentElement.innerText = titulo;
        var remove = e.currentTarget;
        remove.remove();      
    });
    e.currentTarget.appendChild(input);
}   

function salvaTarefa(txt, id) {
    return $.ajax({
        url: "../Servidor/Controllers/tarefa.asp",
        type: 'POST',
        data: {
            "fnTarget": "salvarStatuseTitulo",
            "titulo": txt,
            "id": id
        },
        success: function (titulo) {
            location.reload();
        },
        error: function (xhr, titulo, error) {
            alert("Erro: " + error.Message);
        }
    });
}

function AdicionarEventos(dados) {
    $input = document.getElementById("input");
    $botaovoltar = document.getElementById("botaovoltar");
    $botaoavancar = document.getElementById("botaoavancar");
    $botaovoltar.addEventListener("click", function (e) {
        voltar(e);
    });

    $botaoavancar.addEventListener("click", function (e) {
        avancar(e);
    });

    $input.addEventListener("keydown", function (e) {
        if (e.keyCode == 13) {
            input(dados);
        }
    });
}

function voltar(e) {
    PaginaPesquisa = Number(PaginaPesquisa - 1);
    var table = document.getElementById("tblTarefas")
    while (table.rows.length > 0) {
        table.deleteRow(0);
    }
    BuscarTarefas("BuscarTarefasPaginadas", RegistrosPorPagina, PaginaPesquisa);
}

function avancar(e) {
    PaginaPesquisa = Number(PaginaPesquisa + 1);
    var table = document.getElementById("tblTarefas")
    while (table.rows.length > 0) {
        table.deleteRow(0);
    }
    BuscarTarefas("BuscarTarefasPaginadas", RegistrosPorPagina, PaginaPesquisa);
}

function input(dados) {
    PaginaPesquisa = isNaN($input.value) ? 0 : Number($input.value);
    if (PaginaPesquisa <= 0) {
        mostraAlerta("Caracter inválido, voltando para a primeira página")
        PaginaPesquisa = 1
    }
    if (PaginaPesquisa > dados.TotalPaginas) {
        PaginaPesquisa = Number(dados.TotalPaginas)
    }
    var table = document.getElementById("tblTarefas")
    while (table.rows.length > 0) {
        table.deleteRow(0);
    }
    BuscarTarefas("BuscarTarefasPaginadas", RegistrosPorPagina, PaginaPesquisa);
}

function mostraAlerta(mensagem) {
    alert(mensagem);
}