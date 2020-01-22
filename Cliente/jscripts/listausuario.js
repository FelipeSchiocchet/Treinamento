window.addEventListener('load', function () {
    BuscarUsuarios("BuscarUsuariosPaginados", 20, 1);
});

function BuscarUsuarios(fnTarget, RegistrosPorPagina, PaginaPesquisa) {

    /*
    * Lógica para preenchimento dos dados iniciais da tabela de usuários    
    */
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
            debugger;
            PreencheTabela(data);
        },
        error: function (xhr, status, error) {
           alert("Erro: " + xhr + status + error);
        }
    });
}

function PreencheTabela(dados) {
    var dadosCabecalho = Object.keys(dados.Dados[0]);
    var dadosCorpo = dados.Dados;
    debugger;
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
    debugger;
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
                imagem.src = "../imagens/editar.png";
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
    debugger;
    var tfoot = tabela.createTFoot(); //<tfoot></tfoot>
    var row = tfoot.insertRow(0); //<tr></tr>
    var cell = row.insertCell(0);//<th></th>
    cell.colSpan = tabela.rows[0].cells.length;

    var div = document.createElement("div");//<div></div>
    div.setAttribute("class", "pagination");//<div class="pagination">

    var ul = document.createElement("ul");//<ul></ul>;

    var linkPrimeiraPagina = document.createElement("a");//<a></a>
    linkPrimeiraPagina.href = "usuarioTabela.asp?pagina=1&registrosPorPagina=20"; // href="usuarioTabela.asp?pagina=1&registrosPorPagina=20">
    var liPrimeiraPagina = document.createElement("li");//<li></li>;
    liPrimeiraPagina.innerText = "<<"; // <<
    linkPrimeiraPagina.appendChild(liPrimeiraPagina);//<a href="#"><li> << </li></a>

    var linkVoltaUmaPagina = document.createElement("a");//<a></a>
    linkVoltaUmaPagina.href = "usuarioTabela.asp?pagina=1&registrosPorPagina=20"; // href="usuarioTabela.asp?pagina=1&registrosPorPagina=20">
    var liVoltaUmaPagina = document.createElement("li");//<li></li>;
    liVoltaUmaPagina.innerText = "<"; // <
    linkVoltaUmaPagina.appendChild(liVoltaUmaPagina);//<a href="#"><li> < </li></a>

    var inputPagina = document.createElement("input");// <input/>
    inputPagina.type = "text";//type="text"
    inputPagina.id = "txtPagina";// id="txtPagina"
    inputPagina.name = "txtPagina";//name="txtPagina" 

    var linkAvancaUmaPagina = document.createElement("a");//<a></a>
    linkAvancaUmaPagina.href = "usuarioTabela.asp?pagina=1&registrosPorPagina=20"; // href="usuarioTabela.asp?pagina=1&registrosPorPagina=20">
    var liAvancaUmaPagina = document.createElement("li");//<li></li>;
    liAvancaUmaPagina.innerText = ">"; // >
    linkAvancaUmaPagina.appendChild(liAvancaUmaPagina);//<a href="#"><li> < </li></a>

    var linkUltimaPagina = document.createElement("a");//<a></a>
    linkUltimaPagina.href = "usuarioTabela.asp?pagina=1&registrosPorPagina=20"; // href="usuarioTabela.asp?pagina=1&registrosPorPagina=20">
    var liUltimaPagina = document.createElement("li");//<li></li>;
    liUltimaPagina.innerText = ">>"; // >>
    linkUltimaPagina.appendChild(liUltimaPagina);//<a href="#"><li> >> </li></a>


    var liInfo = document.createElement("li");//<li></li>;
    liInfo.innerText = "Mostrando " + dados.RegistrosPorPagina + " de " + dados.TotalRegistros + " Registros"; // Mostrando 2 de 2 registros

    var liQtdRegistros = document.createElement("li");//<li></li>;
    var inputQtdRegistros = document.createElement("input");// <input/>
    inputQtdRegistros.type = "text";//type="text"
    inputQtdRegistros.id = "txtQtdRegistros";// id="txtQtdRegistros"
    inputQtdRegistros.name = "txtQtdRegistros";//name="txtQtdRegistros" 
    inputQtdRegistros.value = dados.RegistrosPorPagina;
    lblQtdRegistros = document.createElement("label");
    lblQtdRegistros.innerText = "Quantidade de Registros por Página: "
    liQtdRegistros.appendChild(lblQtdRegistros);
    liQtdRegistros.appendChild(inputQtdRegistros);


    ul.appendChild(linkPrimeiraPagina);
    ul.appendChild(linkVoltaUmaPagina);
    ul.appendChild(inputPagina);
    ul.appendChild(linkAvancaUmaPagina);
    ul.appendChild(linkUltimaPagina);
    ul.appendChild(liInfo);
    ul.appendChild(liQtdRegistros);
    div.appendChild(ul);
    cell.appendChild(div);
}
function mudarpagina(event) {

    if (event.keyCode === 13) {
        event.preventDefault();
        document.getElementById("input").submit();
    }
}
