document.addEventListener('DOMContentLoaded', function() {    
    const menuBtn = document.querySelector('.menu-btn');
    const menuLateral = document.querySelector('.menu-lateral');
    const menuOverlay = document.querySelector('.menu-overlay');
    const salirBtn = document.querySelector('.xmenu-btn');

    menuBtn.addEventListener('click', function() {
        menuLateral.classList.toggle('active');
        menuOverlay.classList.toggle('active');
    });
    menuOverlay.addEventListener('click', function() {
        menuLateral.classList.remove('active');
        menuOverlay.classList.remove('active');
    });
    salirBtn.addEventListener('click', function() {
        menuLateral.classList.remove('active');
        menuOverlay.classList.remove('active');
    });
    
});