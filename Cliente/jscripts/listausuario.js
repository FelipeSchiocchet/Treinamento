
if (PaginaPesquisa = "") then
var PaginaPesquisa = 1;

var RegistrosPorPagina = 30;
window.addEventListener('load', function () {
    BuscarUsuarios("BuscarUsuariosPaginados", RegistrosPorPagina, PaginaPesquisa);

});



function BuscarUsuarios(fnTarget, RegistrosPorPagina, PaginaPesquisa) {
    dadosPesquisa = {
        "fnTarget": fnTarget,
        "RegistrosPorPagina": RegistrosPorPagina,
        "PaginaPesquisa": PaginaPesquisa,
    }
    return $.ajax({
        url: "../Servidor/ajax/listausuarioAjax.asp",
        type: 'POST',
        data: dadosPesquisa,
        success: function (data) {
            PreencheTabela(data);
            AdicionarEventos(event);
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

function AdicionarEventos(event) {
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
            input(e);
        }
    });
}

function input(e) {
    return $.ajax({
        url: "../Servidor/ajax/listausuarioAjax.asp",
        type: 'POST',
        data: {
            fnTarget: "botao",
        },
        success: function (data) {
            alert("Teste");
        },
        error: function (xhr, status, error) {
            alert("Erro: " + xhr + status + error);
        }
    });
}

function avancar(e) {
    PaginaPesquisa = PaginaPesquisa + 1;
    //document.getElementsByTagName("tr").remove();
    $("#tblUsuarios tr").remove();
    BuscarUsuarios("BuscarUsuariosPaginados", RegistrosPorPagina, PaginaPesquisa);
    // document.location.reload(true);
    // return $.ajax({
    //     url: "../Servidor/ajax/listausuarioAjax.asp",
    //     type: 'POST',
    //     data: {
    //         fnTarget: "avancar",
    //     },
    //     success: function (data) {
    //         alert("Teste");
    //     },
    //     error: function (xhr, status, error) {
    //         alert("Erro: " + xhr + status + error);
    //     }
    // });
}

function PreencheTabela(dados) {
    var dadosCabecalho = Object.keys(dados.Dados[0]);
    var dadosCorpo = dados.Dados;
    var dadosRodape = {
        "TotalRegistros": dados.TotalRegistros,
        "RegistrosPorPagina": dados.RegistrosPorPagina,
        "PaginaAtual": dados.PaginaAtual,
        "TotalPaginas": dados.TotalPaginas,
    }
    var $tblUsuarios = document.getElementById("tblUsuarios");
    TabelaCriarCabecalho($tblUsuarios, dadosCabecalho);
    TabelaCriarCorpo($tblUsuarios, dadosCorpo);
    TabelaCriarRodape($tblUsuarios, dadosRodape);
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
            if (key == 'usuid') {
                var a = document.createElement("a");
                var params = new URLSearchParams();
                params.append(key, element[key]);
                var url = 'usuarioCadastro.asp?' + params.toString();
                a.href = url;
                var imagem = document.createElement("IMG");
                imagem.src = "./imagens/editar.png";
                a.appendChild(imagem);
                cell.appendChild(a);
                break;
            }
            var text = document.createTextNode(element[key]);
            cell.appendChild(text);
        }
    }
}

function TabelaCriarRodape(tabela, dados) {
    var tfoot = tabela.createTFoot(); //<tfoot></tfoot>
    var row = tfoot.insertRow(0); //<tr></tr>
    var cell = row.insertCell(0);//<th></th>
    cell.colSpan = tabela.rows[0].cells.length;
    debugger;
    var div = document.createElement("div");//<div></div>
    div.setAttribute("class", "pagination");//<div class="pagination">

    var ul = document.createElement("ul");//<ul></ul>;

    var linkVoltaUmaPagina = document.createElement("b");//<a></a>
    var liVoltaUmaPagina = document.createElement("button");//<li></li>;
    liVoltaUmaPagina.innerText = "<<"; // <<
    //liAvancaUmaPagina.type = "submit";//type="submit"
    liVoltaUmaPagina.id = "botaovoltar";// id="<<""
    linkVoltaUmaPagina.appendChild(liVoltaUmaPagina);//<a href="#"><li> << </li></a>

    var inputPagina = document.createElement("input");// <input/>
    inputPagina.type = "text";//type="text"
    inputPagina.id = "input";// id="input"
    inputPagina.name = "input";//name="input" 


    var linkAvancaUmaPagina = document.createElement("b");//<a></a>
    var liAvancaUmaPagina = document.createElement("button");//<li></li>;
    liAvancaUmaPagina.innerText = ">>"; // >>
    liAvancaUmaPagina.type = "submit";//type="submit"
    liAvancaUmaPagina.id = "botaoavancar";// id="botaoavancar"
    linkAvancaUmaPagina.appendChild(liAvancaUmaPagina);//<a href="#"><li> >> </li></a>


    var liInfo = document.createElement("li");//<li></li>;
    liInfo.innerText = "Mostrando " + dados.RegistrosPorPagina + " de " + dados.TotalRegistros + " Registros"; // Mostrando 2 de 2 registros


    ul.appendChild(linkVoltaUmaPagina);
    ul.appendChild(inputPagina);
    ul.appendChild(liAvancaUmaPagina);
    ul.appendChild(liInfo);
    div.appendChild(ul);
    cell.appendChild(div);
}