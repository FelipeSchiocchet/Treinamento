window.addEventListener('load', function () {
    
    const queryString = window.location.search;
    console.log(queryString);
    const urlParams = new URLSearchParams(queryString);
    var usuid = urlParams.get("usuid");
    if (usuid > 0) {
        cadastrar.style.display = 'none';
        alterar.style.display = 'inline';
        deletar.style.display = 'inline';
        prencherdados(usuid);
    }

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

function prencherdados(usuid) {
    /*
     * pegar o id do usuario
     * fazer uma requisiçao
     * pegar os dados de retorno
     * prencher os formulario
     */
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
            if (data) {
                document.getElementById("usuario").value = data.usuario;
                document.getElementById("senha").value = data.senha;
                document.getElementById("nome").value = data.nome;
                document.getElementById("endereco").value = data.endereco;
                document.getElementById("cidade").value = data.cidade;
                document.getElementById("cep").value = data.cep;
                document.getElementById("estadoid").options.selectedIndex = data.estadoid;
                document.getElementById("geradorID").value = data.geradorID;
                var estadoid = data.estadoid;
                buscaEstados(document.getElementById("estadoid"), estadoid);
            }
       },
        error: function (obj, err) {
           mostraAlerta("Servidor com erro, por favor usar mais tarde. " + err)
       }
    })
}

function cadastrarUsuario(event) {
    event.preventDefault();
    debugger
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

function buscaEstados(idElemento, estadoid) {
    if (!idElemento) {
        return false;
    }
    return $.ajax({
        url: "ajax/usuariocadastroAjax.asp",
        type: 'GET',
        contentType: 'application/json',
        data: {
            fnTarget: "buscarEstados",
            
        },
        success: function (data) {
            preencheOptions(idElemento, data, estadoid);
        },
        error: function (obj, err) {
            mostraAlerta("Servidor com erro, por favor usar mais tarde. \n" + obj.responseText)
        }
    });
}
function preencheOptions(idElemento, data, estadoid) {
    debugger;
    var estados = data['Estados'];
    for (var i = 0; i < estados.length; i++) {
        var opt = document.createElement('option');
        if (i == estadoid) {
            document.getElementById(i).selected = "true"
        }
        opt.innerHTML = estados[i]['nome'];
        opt.value = estados[i]['estadoid'];
        opt.id = estados[i]['estadoid'];
        idElemento.appendChild(opt);
    }
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
    debugger;
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    var usuid = urlParams.get("usuid");
    var ddd = validarDados();
    var data = {
        fnTarget: "alterarUsuario",
        usuid: usuid,
        usuario: document.getElementById("usuario").value,
        senha: document.getElementById("senha").value,
        nome: document.getElementById("nome").value,
        endereco: document.getElementById("endereco").value,
        cidade: document.getElementById("cidade").value,
        cep: document.getElementById("cep").value,
        estadoid: document.getElementById("estadoid").value,
        geradorID: document.getElementById("geradorID").value
    };
    if (ddd) {
        $.ajax({
            type: "POST",
            url: "ajax/usuariocadastroAjax.asp",
            async: false,
            data: data,
            success: function (retorno) {
                debugger
                if (retorno.sucesso == 'true')  {
                    mostraAlerta("Usuário alterado com sucesso")
                }
            },
            error: function (obj, err) {
                mostraAlerta("Servidor com erro, por favor usar mais tarde. " + err)
            }
        });
    }
}

function deletarUsuario(event) {
    event.preventDefault();
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    var usuid = urlParams.get("usuid");
    debugger;
    if (usuid == geradorID.value) {
        mostraAlerta("Usuários geradores de tarefas não podem ser deletados");
        return false;
    }

    $.ajax({
        type: "POST",
        url: "ajax/usuariocadastroAjax.asp",
        async: false,
        data: {
            fnTarget: "deletarUsuario",
            usuid: usuid
        },
        success: function (retorno) {
            debugger;
            if (retorno.sucesso == 'true') {
                mostraAlerta("Usuário deletado com sucesso")
                window.location.href = "listausuario.asp";
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