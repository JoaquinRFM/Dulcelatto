document.addEventListener('DOMContentLoaded', () => {    
    const mostrarBtn = document.getElementById("mostrarFormularioBtn");
    const formOverlay = document.getElementById("formOverlay");
    const cerrarBtn = document.getElementById("cerrarFormularioBtn");

    if (mostrarBtn && formOverlay) {
        mostrarBtn.addEventListener("click", () => {
            formOverlay.style.display = "flex";
        });

        cerrarBtn.addEventListener("click", () => {
            formOverlay.style.display = "none";
        });

        formOverlay.addEventListener("click", (e) => {
            if (e.target === formOverlay) {
                formOverlay.style.display = "none";
            }
        });
    }
});