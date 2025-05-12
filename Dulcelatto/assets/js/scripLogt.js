// Selecciona los contenedores de inicio de sesión y registro usando querySelector
// sign_in_container: Contenedor para el formulario de inicio de sesión (clase 'sign-in-container')
const sign_in_container = document.querySelector('.sign-in-container'),
      // sign_up_container: Contenedor para el formulario de registro (clase 'sign-up-container')
      sign_up_container = document.querySelector('.sign-up-container');

// Añade un evento 'click' al documento para manejar clics en elementos específicos
document.addEventListener('click', e => {
    // Verifica si el elemento clicado tiene la clase 'ok-account' (botón/enlace para mostrar el formulario de registro)
    if (e.target.matches('.ok-account')) {
        // Muestra el contenedor de registro (sign_up_container) estableciendo display en 'block'
        sign_up_container.style.display = 'block';
        // Oculta el contenedor de inicio de sesión (sign_in_container) estableciendo display en 'none'
        sign_in_container.style.display = 'none';
    }
    // Verifica si el elemento clicado tiene la clase 'no-account' (botón/enlace para mostrar el formulario de inicio de sesión)
    else if (e.target.matches('.no-account')) {
        // Muestra el contenedor de inicio de sesión (sign_in_container) estableciendo display en 'block'
        sign_in_container.style.display = 'block';
        // Oculta el contenedor de registro (sign_up_container) estableciendo display en 'none'
        sign_up_container.style.display = 'none';
    }
});