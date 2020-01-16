window.addEventListener('load', function () {
    if (usuid.value > 0) {
        cadastrar.style.display = 'none';
        alterar.style.display = 'inline';
        deletar.style.display = 'inline';
    }
    prencherdados();
    buscaEstados(idElemento)

});

function limparCampos() {
    //debugger
    document.getElementById("usuario").value = "";
    document.getElementById("senha").value = "";
    document.getElementById("nome").value = "";
    document.getElementById("endereco").value = "";
    document.getElementById("cidade").value = "";
    document.getElementById("cep").value = "";
    document.getElementById("estadoid").value = "";
}

function mascara(t, mask) {
    var i = t.value.length;
    var saida = mask.substring(1, 0);
    var texto = mask.substring(i)
    if (texto.substring(0, 1) != saida) {
        t.value += texto.substring(0, 1);
    }
}

function prencherdados() {
    /*
     * pegar o id do usuario
     * fazer uma requisiçao
     * pegar os dados de retorno
     * prencher os formulario
     */
    const queryString = window.location.search;
    console.log(queryString);
    const urlParams = new URLSearchParams(queryString);
    var usuid = urlParams.get("usuid");
   return $.ajax({
        type: "POST",
        url: "ajax/usuariocadastroAjax.asp",
        async: false,
        data: {
            fnTarget: "colocarDados",
            usuid: usuid
        },
        success: function (data) {
            debugger;
            if (data.retorno) {
                document.getElementById("usuario").value = "sss";
                document.getElementById("senha").value = "sss";
                document.getElementById("nome").value = "sss";
                document.getElementById("endereco").value = "sss";
                document.getElementById("cidade").value = "sss";
                document.getElementById("cep").value = "sss";
                document.getElementById("estadoid").value = "sss";
                document.getElementById("geradorID").value = "sss";
            }
       },
        error: function (obj, err) {
           mostraAlerta("Servidor com erro, por favor usar mais tarde. " + err)
       }
    })
}

function cadastrarUsuario(event) {
    event.preventDefault();

    if (validarDados()) {

        $.ajax({
            type: "POST",
            url: "ajax/usuariocadastroAjax.asp",
            async: false,
            data: {
                fnTarget: "cadastrarUsuario",
                usuario: document.getElementById("usuario").value,
                senha: document.getElementById("senha").value,
                nome: document.getElementById("nome").value,
                endereco: document.getElementById("endereco").value,
                cidade: document.getElementById("cidade").value,
                cep: document.getElementById("cep").value,
                estadoid: document.getElementById("estadoid").value,
                geradorID: document.getElementById("geradorID").value
            },
            success: function (retorno) {

                if (retorno.sucesso == 'true') {
                    mostraAlerta("Usuário cadastrado com sucesso");

                    var cadastrar = document.getElementById('cadastrar');
                    var alterar = document.getElementById('alterar');
                    var deletar = document.getElementById('deletar');

                    document.getElementById("usuid").value = retorno.UsuID;

                    cadastrar.style.display = 'none';
                    alterar.style.display = 'inline';
                    deletar.style.display = 'inline';
                }
            }
        });

    }
}

function buscaEstados(idElemento) {
    if (!idElemento) {
        return false;
    }
    debugger
    return $.ajax({
        url: "./AspPages/estado.asp",
        type: 'GET',
        contentType: 'application/json',
        success: function (data) {
            preencheOptions(idElemento, JSON.parse(data));
        }
    });
}

function validarDados() {
    if (usuario.value == "") {
        mostraAlerta("Preencha o campo usuário!");
        return false;
    }
    else if (senha.value == "") {
        mostraAlerta("Preencha o campo senha!");
        return false;
    }
    else if (nome.value == "") {
        mostraAlerta("Preencha o campo nome!");
        return false;
    }
    else if (endereco.value == "") {
        mostraAlerta("Preencha o campo endereço!");
        return false;
    }
    else if (cidade.value == "") {
        mostraAlerta("Preencha o campo cidade!");
        return false;
    }
    else if (cep.value == "") {
        mostraAlerta("Preencha o campo cep!");
        return false;
    }
    else if (estadoid.value == "") {
        mostraAlerta("Preencha o campo estado!");
        return false;
    }

    return true;
}

function alterarUsuario(event) {
    event.preventDefault();

    if (validarDados()) {
        $.ajax({
            type: "POST",
            url: "ajax/usuariocadastroAjax.asp",
            async: false,
            data: {
                fnTarget: "alterarUsuario",
                usuid: document.getElementById("usuid").value,
                usuario: document.getElementById("usuario").value,
                senha: document.getElementById("senha").value,
                nome: document.getElementById("nome").value,
                endereco: document.getElementById("endereco").value,
                cidade: document.getElementById("cidade").value,
                cep: document.getElementById("cep").value,
                estadoid: document.getElementById("estadoid").value,
                geradorID: document.getElementById("geradorID").value
            },
            success: function (retorno) {
                if (retorno == 'true') {
                    mostraAlerta("Usuário alterado com sucesso")
                }
            }
        });
    }
}

function deletarUsuario(event) {
    event.preventDefault();

    if (usuid.value == geradorID.value) {
        mostraAlerta("Usuários geradores de tarefas não podem ser deletados");
        return false;
    }

    $.ajax({
        type: "POST",
        url: "ajax/usuariocadastroAjax.asp",
        async: false,
        data: {
            fnTarget: "deletarUsuario",
            usuid: document.getElementById("usuid").value
        },
        success: function (retorno) {
            if (retorno == 'true') {
                mostraAlerta("Usuário deletado com sucesso")
                window.location.href = "listausuario.asp";
            }
        }
    });
}

function mostraAlerta(mensagem) {
    alert(mensagem);
}