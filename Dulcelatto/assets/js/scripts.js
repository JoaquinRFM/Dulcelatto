// Espera a que el DOM esté completamente cargado antes de ejecutar el código
document.addEventListener('DOMContentLoaded', function() {
    // Selecciona el contenedor donde se mostrarán los productos (debe tener la clase 'productos-grid')
    const productosGrid = document.querySelector('.productos-grid');

    // Verifica si el contenedor existe; si no, registra un error y termina la ejecución
    if (!productosGrid) {
        console.error('Error: No se encontró el contenedor .productos-grid');
        return;
    }

    // Registra en la consola que se está iniciando la solicitud al servidor
    console.log('Iniciando solicitud fetch a ../includes/getProductos.php');

    // Realiza una solicitud HTTP al script PHP que devuelve los productos en formato JSON
    fetch('../includes/getProductos.php')
        .then(response => {
            // Registra la respuesta recibida del servidor para depuración
            console.log('Respuesta recibida:', response);

            // Verifica si la respuesta HTTP es exitosa (código 200-299)
            if (!response.ok) {
                // Si hay un error (por ejemplo, 404 o 500), lanza una excepción con el estado HTTP
                throw new Error(`Error al cargar los productos: ${response.status} ${response.statusText}`);
            }

            // Convierte la respuesta a formato JSON
            return response.json();
        })
        .then(data => {
            // Registra los datos JSON recibidos para depuración
            console.log('Datos recibidos:', data);

            // Verifica si los datos contienen un campo 'error' (por ejemplo, error de conexión o consulta)
            if (data.error) {
                throw new Error(data.error);
            }

            // Verifica si los datos son un arreglo y no están vacíos
            if (!Array.isArray(data) || data.length === 0) {
                throw new Error('No se recibieron productos válidos');
            }

            // Almacena los datos como la lista de productos
            const productos = data;

            // Itera sobre cada producto para generar su representación en el DOM
            productos.forEach((producto, index) => {
                // Registra en la consola que se está generando un producto
                console.log(`Generando producto ${index + 1}: ${producto.nombre}`);

                // Crea un nuevo elemento <div> para el producto
                const productoDiv = document.createElement('div');

                // Añade la clase 'producto' al div para aplicar estilos CSS
                productoDiv.classList.add('producto');

                // Establece el cursor como 'pointer' para indicar que el elemento es clickable
                productoDiv.style.cursor = 'pointer';

                // Inicializa la variable para el HTML del precio
                let priceHTML = '';

                // Obtiene el precio del producto o usa un valor por defecto si no existe
                const price = producto.price || 'Precio no disponible';

                // Verifica si el precio incluye una oferta (formato: "original SALE oferta")
                if (typeof price === 'string' && price.includes('SALE')) {
                    // Divide el precio en precio original y precio de oferta
                    const [originalPrice, salePrice] = price.split('SALE');
                    // Genera HTML para mostrar ambos precios (original tachado y oferta)
                    priceHTML = `<span class="old-price">${originalPrice}</span><span>${salePrice}</span>`;
                } else {
                    // Si no hay oferta, muestra el precio normal
                    priceHTML = `<span>${price}</span>`;
                }

                // Genera el HTML del producto con su imagen, nombre, calificación (si existe) y precio
                productoDiv.innerHTML = `
                    <img src="${producto.imagen}" alt="${producto.nombre}">
                    <h3>${producto.nombre}</h3>
                    ${producto.rating ? `<div class="rating">${producto.rating}</div>` : ''}
                    <div class="price">Precio: S/.${priceHTML}</div>
                `;

                // Añade un evento 'click' al div del producto para abrir un modal con sus detalles
                productoDiv.addEventListener('click', () => {
                    openProductModal(producto);
                });

                // Registra en la consola que se está añadiendo el producto al DOM
                console.log('Añadiendo producto al DOM:', productoDiv);

                // Añade el div del producto al contenedor productosGrid
                productosGrid.appendChild(productoDiv);
            });

            // Registra en la consola el número total de productos añadidos
            console.log('Total de productos añadidos:', productosGrid.children.length);
        })
        .catch(error => {
            // Maneja cualquier error durante la solicitud o procesamiento de datos
            console.error('Error:', error);

            // Muestra un mensaje de error en el contenedor si falla la carga de productos
            productosGrid.innerHTML = '<p>Error al cargar los productos. Por favor, intenta de nuevo más tarde.</p>';
        });

    // Define la función para abrir un modal con los detalles de un producto
    function openProductModal(producto) {
        // Crea un div para el fondo del modal (overlay oscuro)
        const overlay = document.createElement('div');
        overlay.classList.add('modal-overlay');

        // Crea un div para el contenedor del modal
        const modal = document.createElement('div');
        modal.classList.add('modal');

        // Define una calificación estática para el modal (cinco estrellas)
        const ratingHTML = `
            <div class="modal-rating">
                <span>★★★★★</span>
            </div>
        `;

        // Genera el HTML del modal con los detalles del producto
        modal.innerHTML = `
            <div class="modal-content">
                <span class="modal-close">×</span>
                <div class="modal-left">
                    <img src="${producto.imagen}" alt="${producto.nombre}">
                </div>
                <div class="modal-right">
                    <h2>${producto.nombre}</h2>
                    ${ratingHTML}
                    <p class="modal-price">Costo: S/ ${producto.price}</p>
                    <div class="modal-description">
                        <h3>Descripción:</h3>
                        <p>${producto.descripcion}</p>
                    </div>
                    <div class="modal-options">
                        <h3>Cantidad:</h3>
                        <input type="number" class="modal-quantity" value="1" min="1">
                    </div>
                    <button class="modal-add-to-cart">Agregar al carrito</button>
                </div>
            </div>
        `;

        // Añade el overlay y el modal al cuerpo del documento
        document.body.appendChild(overlay);
        document.body.appendChild(modal);

        // Selecciona el botón de cierre del modal (la "×")
        const closeBtn = modal.querySelector('.modal-close');

        // Añade un evento 'click' para cerrar el modal al hacer clic en la "×"
        closeBtn.addEventListener('click', () => {
            modal.remove(); // Elimina el modal del DOM
            overlay.remove(); // Elimina el overlay del DOM
        });

        // Añade un evento 'click' al overlay para cerrar el modal al hacer clic fuera de él
        overlay.addEventListener('click', () => {
            modal.remove(); // Elimina el modal del DOM
            overlay.remove(); // Elimina el overlay del DOM
        });
    }
});