$.ajax({
        type: "POST",
        url: "ajax/listausuarioAjax.asp",
        async: false,
    data: {
            fnTarget: "validar"
        },
});

function myFunction(event) {

    if (event.keyCode === 13) {
        event.preventDefault();
        document.getElementById("input").submit();
    }
}
