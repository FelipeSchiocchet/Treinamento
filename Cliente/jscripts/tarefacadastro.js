window.addEventListener('load', function () {
    if (tarID.value > 0) {
        cadastrar.style.display = 'none';
        alterar.style.display = 'inline';
        deletar.style.display = 'inline';
    }
});

function limparCampos() {
    //debugger
    document.getElementById("tarTitulo").value = "";
    document.getElementById("geradorID").value = "";
    document.getElementById("tarDescricao").value = "";
    document.getElementById("tarStatus").value = "";
    document.getElementById("tarData").value = "";

}

function cadastrarTarefa(event) {
    event.preventDefault();

    if (validarDados()) {

        $.ajax({
            type: "POST",
            url: "ajax/TarefaCadastroAjax.asp",
            async: false,
            data: {
                fnTarget: "cadastrarTarefa",
                tarTitulo: document.getElementById("tarTitulo").value,
                geradorId: document.getElementById("geradorId").value,
                tarDescricao: document.getElementById("tarDescricao").value,
                tarStatus: document.getElementById("tarStatus").value,
                tarData: document.getElementById("tarData").value
                
            },
            success: function (retorno) {
                if (retorno.sucesso == 'true') {
                    mostraAlerta("Tarefa cadastrado com sucesso");

                    var cadastrar = document.getElementById('cadastrar');
                    var alterar = document.getElementById('alterar');
                    var deletar = document.getElementById('deletar');

                    document.getElementById("tarID").value = retorno.UsuID;

                    cadastrar.style.display = 'none';
                    alterar.style.display = 'inline';
                    deletar.style.display = 'inline';
                }
            }
        });

    }
}
function validarDados() {
    if (tarTitulo.value == "") {
        mostraAlerta("Preencha o campo titulo!");
        return false;
    }
    else if (geradorId.value == "") {
        mostraAlerta("Preencha o campo gerador!");
        return false;
    }
    else if (tarDescricao.value == "") {
        mostraAlerta("Preencha o campo decrição!");
        return false;
    }
    else if (tarStatus.value == "") {
        mostraAlerta("Preencha o campo status!");
        return false;
    }
    else if (tarData.value == "") {
        mostraAlerta("Preencha o campo data!");
        return false;
    }
    return true;
}

function alterarTarefa(event) {
    event.preventDefault();
    debugger
    var d = document.getElementById("tarTitulo").value;
    if (validarDados()) {
        $.ajax({
            type: "POST",
            url: "ajax/TarefaCadastroAjax.asp",
            async: false,
            data: {
                fnTarget: "alterarTarefa",
                tarID: document.getElementById("tarID").value,
                tarTitulo: document.getElementById("tarTitulo").value,
                geradorId: document.getElementById("geradorId").value,
                tarDescricao: document.getElementById("tarDescricao").value,
                tarStatus: document.getElementById("tarStatus").value,
                tarData: document.getElementById("tarData").value

            },
            success: function (retorno) {
                if (retorno == 'true') {
                    mostraAlerta("Tarefa alterado com sucesso")
                }
            }
        });
    }
}

function deletarTarefa(event) {
    event.preventDefault();

    $.ajax({
        type: "POST",
        url: "ajax/TarefaCadastroAjax.asp",
        async: false,
        data: {
            fnTarget: "deletarTarefa",
            tarID: document.getElementById("tarID").value
        },
        success: function (retorno) {
            if (retorno == 'true') {
                mostraAlerta("tarefa deletada com sucesso")
                window.location.href = "lista.asp";
            }
        }
    });
}

function mostraAlerta(mensagem) {
    alert(mensagem);
}