window.addEventListener('load', function () {
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
        type: "POST",
        url: "ajax/logonAjax.asp",
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
        error: function (obj, err) { debugger; }
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