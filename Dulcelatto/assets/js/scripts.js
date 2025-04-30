document.addEventListener('DOMContentLoaded', function() {
    const productosGrid = document.querySelector('.productos-grid');
    if (!productosGrid) {
        console.error('Error: No se encontró el contenedor .productos-grid');
        return;
    }

    console.log('Iniciando solicitud fetch a ../includes/getProductos.php');

    fetch('../includes/getProductos.php')
        .then(response => {
            console.log('Respuesta recibida:', response);
            if (!response.ok) {
                throw new Error(`Error al cargar los productos: ${response.status} ${response.statusText}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Datos recibidos:', data);
            if (data.error) {
                throw new Error(data.error);
            }
            if (!Array.isArray(data) || data.length === 0) {
                throw new Error('No se recibieron productos válidos');
            }

            const productos = data;
            productos.forEach((producto, index) => {
                console.log(`Generando producto ${index + 1}: ${producto.nombre}`);
                const productoDiv = document.createElement('div');
                productoDiv.classList.add('producto');
                productoDiv.style.cursor = 'pointer'; // Indica que el producto es clickable

                let priceHTML = '';
                const price = producto.price || 'Precio no disponible';
                if (typeof price === 'string' && price.includes('SALE')) {
                    const [originalPrice, salePrice] = price.split(' SALE ');
                    priceHTML = `<span class="old-price">${originalPrice}</span><span>${salePrice}</span>`;
                } else {
                    priceHTML = `<span>${price}</span>`;
                }

                productoDiv.innerHTML = `
                    <img src="${producto.imagen}" alt="${producto.nombre}">
                    <h3>${producto.nombre}</h3>
                    ${producto.rating ? `<div class="rating">${producto.rating}</div>` : ''}
                    <div class="price">Precio: S/.${priceHTML}</div>
                `;

                // Añadir event listener para abrir el modal al hacer clic
                productoDiv.addEventListener('click', () => {
                    openProductModal(producto);
                });

                console.log('Añadiendo producto al DOM:', productoDiv);
                productosGrid.appendChild(productoDiv);
            });

            console.log('Total de productos añadidos:', productosGrid.children.length);
        })
        .catch(error => {
            console.error('Error:', error);
            productosGrid.innerHTML = '<p>Error al cargar los productos. Por favor, intenta de nuevo más tarde.</p>';
        });

    // Función para abrir el modal con los detalles del producto
    function openProductModal(producto) {
        // Crear el fondo del modal (overlay)
        const overlay = document.createElement('div');
        overlay.classList.add('modal-overlay');

        // Crear el contenedor del modal
        const modal = document.createElement('div');
        modal.classList.add('modal');

        // Calificación estática
        const ratingHTML = `
            <div class="modal-rating">
                <span>★★★★★</span>
            </div>
        `;

        // Contenido del modal
        modal.innerHTML = `
            <div class="modal-content">
                <span class="modal-close">&times;</span>
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

        // Añadir el modal y el overlay al cuerpo
        document.body.appendChild(overlay);
        document.body.appendChild(modal);

        // Añadir evento para cerrar el modal al hacer clic en la "X"
        const closeBtn = modal.querySelector('.modal-close');
        closeBtn.addEventListener('click', () => {
            modal.remove();
            overlay.remove();
        });

        // Añadir evento para cerrar el modal al hacer clic fuera de él (en el overlay)
        overlay.addEventListener('click', () => {
            modal.remove();
            overlay.remove();
        });
    }
});