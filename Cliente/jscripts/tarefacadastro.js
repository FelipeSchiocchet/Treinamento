window.addEventListener('DOMContentLoaded', function () {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    var tarID = urlParams.get("tarID");
    AdicionarEventos(tarID);
    debugger;
    if (tarID > 0) {
        cadastrar.style.display = 'none';
        alterar.style.display = 'inline';
        deletar.style.display = 'inline';
        prencherdados(tarID);
    } else {
        var geradorID = 1;
        buscaUsuarios(document.getElementById("geradorID"), geradorID);
    }
});

function AdicionarEventos(tarID) {
    $btnCadastrar = document.getElementById("cadastrar");
    $btnAlterar = document.getElementById("alterar");
    $btnDeletar = document.getElementById("deletar");
    $btnNovo = document.getElementById("novo");

    $btnCadastrar.addEventListener("click", function (e) {
        cadastrarTarefa(e);
    });

    $btnAlterar.addEventListener("click", function (e) {
        alterarTarefa(e, tarID);
    });

    $btnDeletar.addEventListener("click", function (e) {
        deletarTarefa(e, tarID);
    });

    $btnNovo.addEventListener("click", function (e) {
        window.location.href = "tarefacadastro.asp";
    });

}

function prencherdados(tarID) {
    return $.ajax({
        type: "POST",
        url: "../Servidor/Controllers/TarefaCadastroAjax.asp",
        data: {
            fnTarget: "colocarDados",
            tarID: tarID
        },
        success: function (data) {
            if (data) {
                debugger;
                document.getElementById("tarTitulo").value = data.tarTitulo;
                document.getElementById("geradorID").value = data.geradorID;
                document.getElementById("tarData").value = data.tarData;
                document.getElementById("tarStatus").value = data.tarStatus;
                document.getElementById("tarDescricao").value = data.tarDescricao;
                var geradorID = data.geradorID;
                buscaUsuarios(document.getElementById("geradorID"), geradorID);
            }
        },
        error: function (obj, err) {
            mostraAlerta("Servidor com erro, por favor usar mais tarde. " + err)
        }
    })
}

function cadastrarTarefa(event) {
    event.preventDefault();
    if (validarDados()) {
        debugger;
        var dados = {
            fnTarget: "cadastrarTarefa",
            tarTitulo: document.getElementById("tarTitulo").value,
            geradorID: document.getElementById("geradorID").value,
            tarData: document.getElementById("tarData").value,
            tarStatus: document.getElementById("tarStatus").value,
            tarDescricao: document.getElementById("tarDescricao").value
        };
        $.ajax({
            type: "POST",
            url: "../Servidor/Controllers/TarefaCadastroAjax.asp",
            data: dados,
            success: function (retorno) {
                if (retorno.sucesso == 'true') {
                    mostraAlerta("Tarefa cadastrada com sucesso");
                    location.href = "tarefacadastro.asp?tarID=" + retorno.tarID;
                }
            }
        });

    }
}

function buscaUsuarios(idElemento, geradorID) {
    if (!idElemento) {
        return false;
    }
    return $.ajax({
        url: "../Servidor/Controllers/TarefaCadastroAjax.asp",
        type: 'GET',
        contentType: 'application/json',
        data: {
            fnTarget: "buscaUsuarios"
        },
        success: function (data) {
            preencheOptions(idElemento, data, geradorID);
        },
        error: function (obj, err) {
            mostraAlerta("Servidor com erro, por favor usar mais tarde. \n" + obj.responseText)
        }
    });
}

function preencheOptions(idElemento, data, geradorID) {
    var usuarios = data['Usuarios'];
    for (var i = 0; i < usuarios.length; i++) {
        var opt = document.createElement('option');
        if (i == geradorID) {
            document.getElementById(i).selected = "true"
        }
        opt.innerHTML = usuarios[i]['nome'];
        opt.value = usuarios[i]['geradorID'];
        opt.id = usuarios[i]['geradorID'];
        idElemento.appendChild(opt);
    }
}

function validarDados() {
    if (tarTitulo.value == "") {
        mostraAlerta("Preencha o campo Título!");
        return false;
    }
    else if (geradorID.value == "") {
        mostraAlerta("Preencha o campo Gerador!");
        return false;
    }
    else if (tarDescricao.value == "") {
        mostraAlerta("Preencha o campo Descrição!");
        return false;
    }
    else if (tarStatus.value == "") {
        mostraAlerta("Preencha o campo Status!");
        return false;
    }
    else if (tarData.value == "") {
        mostraAlerta("Preencha o campo Data!");
        return false;
    }
    return true;
}

function alterarTarefa(event, tarID) {
    event.preventDefault();
    var data = {
        fnTarget: "alterarTarefa",
        tarID: tarID,
        tarTitulo: document.getElementById("tarTitulo").value,
        geradorID: document.getElementById("geradorID").value,
        tarData: document.getElementById("tarData").value,
        tarStatus: document.getElementById("tarStatus").value,
        tarDescricao: document.getElementById("tarDescricao").value
    };
    if (validarDados()) {
        $.ajax({
            type: "POST",
            url: "../Servidor/Controllers/TarefaCadastroAjax.asp",
            data: data,
            success: function (retorno) {
                if (retorno.sucesso == 'true') {
                    mostraAlerta("Tarefa alterada com sucesso")
                }
            },
            error: function (obj, err) {
                mostraAlerta("Servidor com erro, por favor usar mais tarde. " + err)
            }
        });
    }
}

function deletarTarefa(event, tarID) {
    event.preventDefault();

    $.ajax({
        type: "POST",
        url: "../Servidor/Controllers/TarefaCadastroAjax.asp",
        data: {
            fnTarget: "deletarTarefa",
            tarID: tarID
        },
        success: function (retorno) {
            if (retorno.sucesso == 'true') {
                mostraAlerta("Tarefa deletada com sucesso")
                window.location.href = "lista.asp";
            }
        },
        error: function (obj, err) {
            mostraAlerta("Servidor com erro, por favor usar mais tarde. " + err)
        }
    });
}

function mostraAlerta(mensagem) {
    alert(mensagem);
}
