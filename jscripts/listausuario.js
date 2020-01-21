window.addEventListener('load', function () {
    debugger;
    $.ajax({
        type: "POST",
        url: "ajax/listausuarioAjax.asp",
        async: false,
    data: {
            fnTarget: "validar",
        },
    });
});

function mudarpagina(event) {

    if (event.keyCode === 13) {
        event.preventDefault();
        document.getElementById("input").submit();
    }
}
