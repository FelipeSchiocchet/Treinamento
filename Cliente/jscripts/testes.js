var btn = document.getElementById('btn_form');
var form = document.getElementById('my_form');

btn.addEventListener('click', function () {
    if (form.style.display != 'block') {
        form.style.display = 'block';
        return;
    }
    form.style.display = 'none';
});