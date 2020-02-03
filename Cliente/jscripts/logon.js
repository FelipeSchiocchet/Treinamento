window.addEventListener('load', function () {
    debugger;
    document.getElementById("botaologin").addEventListener("click", function () {
        event.preventDefault();
        validarLogon();
    });
});


function validarLogon() {
    if (usuario.value == "") {
        mostraAlerta("Preencha o campo usuario!");
        return false;
    }
    else if (senha.value == "") {
        mostraAlerta("Preencha o campo senha!");
        return false;
    }

    $.ajax({
        url: "../Servidor/Controllers/logonAjax.asp",
        type: "POST",
        async: false,
        data: {
            fnTarget: "validarLogon",
            usuario: document.getElementById("usuario").value,
            senha: document.getElementById("senha").value
        },
        success: function (data) {
            debugger;
            if (data.retorno) {
                window.location.href = "header.asp";
            } else {
                mostraAlerta("Usuario e/ou senha incorretos!")
                document.getElementById("senha").value = "";
            }
        },
        error: function (obj, err) {

            mostraAlerta("Servidor com erro, por favor usar mais tarde. " + err)
        }
    });
}

function mostraAlerta(mensagem) {
    var alerta = document.getElementById("divAlerta");
    alerta.innerHTML = mensagem;
    alerta.classList.add('alerta-show');
    setTimeout(function () {
        alerta.className = alerta.className.replace("alerta-show", "");
    }, 10000);
}