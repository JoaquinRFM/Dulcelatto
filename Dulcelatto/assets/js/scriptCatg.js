document.addEventListener('DOMContentLoaded', function() {     
    const categoriaGrid = document.querySelector('.categoria-grid');
    if (!categoriaGrid) {
        console.error('Error: No se encontró el contenedor .categoria-grid');
        return;
    }

    console.log('Iniciando solicitud fetch a ../includes/getCategorias.php');

    const categoriaSeleccionada = categoriaGrid.getAttribute('data-categoria');
    console.log('Categoría seleccionada:', categoriaSeleccionada);

    fetch('http://farbeg.com/Dulcelatto-main/Dulcelatto/includes/getCategorias.php')
    //fetch('../includes/getCategorias.php')
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

            categoriaGrid.innerHTML = '';

            if (categoriaSeleccionada) {
                if (data[categoriaSeleccionada] && data[categoriaSeleccionada].length > 0) {
                    agregarProductosPorCategoria(categoriaSeleccionada, data[categoriaSeleccionada]);
                } else {
                    categoriaGrid.innerHTML = '<p>No hay productos disponibles en esta categoría.</p>';
                }
            } else {
                Object.keys(data).forEach(categoria => {
                    agregarProductosPorCategoria(categoria, data[categoria]);
                });
            }
        })
        .catch(error => console.error('Error:', error));

    function agregarProductosPorCategoria(categoria, productos) {
        const categoryContainer = document.createElement('div');
        categoryContainer.classList.add('productos-grid');

        productos.forEach(producto => {
            const productoDiv = document.createElement('div');    
            productoDiv.classList.add('producto');
            productoDiv.style.cursor = 'pointer';

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

            productoDiv.addEventListener('click', () => {
                openProductModal(producto);
            });

            categoryContainer.appendChild(productoDiv);
        });

        categoriaGrid.appendChild(categoryContainer);
    }

    function openProductModal(producto) {
        const overlay = document.createElement('div');
        overlay.classList.add('modal-overlay');

        const modal = document.createElement('div');
        modal.classList.add('modal');

        const ratingHTML = `
            <div class="modal-rating">
                <span>★★★★★</span>
            </div>
        `;

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
                    <button class="modal-add-to-cart" data-id="${producto.id}">Agregar al carrito</button>
                </div>
            </div>
        `;

        document.body.appendChild(overlay);
        document.body.appendChild(modal);

        const closeBtn = modal.querySelector('.modal-close');
        closeBtn.addEventListener('click', () => {
            modal.remove();
            overlay.remove();
        });

        overlay.addEventListener('click', () => {
            modal.remove();
            overlay.remove();
        });

        const productImage = modal.querySelector('.modal-left img');
        productImage.addEventListener('click', () => {
            const zoomOverlay = document.createElement('div');
            zoomOverlay.classList.add('modal-overlay');

            const zoomModal = document.createElement('div');
            zoomModal.classList.add('image-zoom-modal');
            zoomModal.innerHTML = `
                <span class="modal-close">×</span>
                <img src="${producto.imagen}" alt="${producto.nombre}">
            `;

            document.body.appendChild(zoomOverlay);
            document.body.appendChild(zoomModal);

            const zoomCloseBtn = zoomModal.querySelector('.modal-close');
            zoomCloseBtn.addEventListener('click', () => {
                zoomModal.remove();
                zoomOverlay.remove();
            });

            zoomOverlay.addEventListener('click', () => {
                zoomModal.remove();
                zoomOverlay.remove();
            });
        });

        const addToCartBtn = modal.querySelector('.modal-add-to-cart');
        addToCartBtn.addEventListener('click', () => {
            const cantidad = parseInt(modal.querySelector('.modal-quantity').value);
            fetch('../includes/add_to_cart.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `id_producto=${producto.id}&cantidad=${cantidad}`
            })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                    if (data.success) {
                        modal.remove();
                        overlay.remove();
                        fetch('../includes/get_cart_count.php')
                            .then(res => res.json())
                            .then(cartData => {
                                if (cartData.success) {
                                    document.querySelector('#cart-count').textContent = cartData.count;
                                }
                            });
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error al añadir al carrito');
                });
        });
    }
});