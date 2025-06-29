function toggleRdfMenu() {
    const menu = document.getElementById('rdfMenu');
    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
}

document.addEventListener('click', function(event) {
    const menu = document.getElementById('rdfMenu');
    const icon = document.querySelector('.rdf-menu-wrapper img');
    if (!menu.contains(event.target) && !icon.contains(event.target)) {
        menu.style.display = 'none';
    }
});

function getCategoriaDesdeURL() {
    const params = new URLSearchParams(window.location.search);
    return params.get('categoria');
}

function descargarRDF() {
    const categoria = getCategoriaDesdeURL();
    let url = "";
    let nombreDescarga = "";

    if (categoria) {
        const file = categoria.replace(/ /g, "_") + ".rdf.php";
        url = "https://bublut.com/Dulcelatto/" + file;
        nombreDescarga = categoria.replace(/ /g, "_") + ".rdf.xml";
    } else {
        url = "https://bublut.com/Dulcelatto/productos.rdf.php";
        nombreDescarga = "productos.rdf.xml";
    }

    const a = document.createElement('a');
    a.href = url;
    a.setAttribute("download", nombreDescarga);
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}



