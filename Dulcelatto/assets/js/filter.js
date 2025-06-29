document.addEventListener('DOMContentLoaded', function() {
    const filterContainer = document.querySelector('.filter-container');
    if (!filterContainer) return;

    const categoriaSelect = filterContainer.querySelector('#filter-categoria');
    const minPriceInput = filterContainer.querySelector('#filter-min-price');
    const maxPriceInput = filterContainer.querySelector('#filter-max-price');
    const sortSelect = filterContainer.querySelector('#filter-sort');
    const productosGrid = document.querySelector('.productos-grid') || document.querySelector('.categoria-grid');

    function applyFilters() {
        const categoria = categoriaSelect.value;
        const minPrice = parseFloat(minPriceInput.value) || 0;
        const maxPrice = parseFloat(maxPriceInput.value) || 999999;
        const sort = sortSelect.value;

        const queryParams = new URLSearchParams({
            categoria: categoria,
            min_price: minPrice,
            max_price: maxPrice,
            sort: sort
        });
        fetch(`https://bublut.com/Dulcelatto/includes/filter_products.php?${queryParams.toString()}`)
        //fetch(`../includes/filter_products.php?${queryParams.toString()}`)
            .then(response => {
                if (!response.ok) throw new Error('Error al filtrar productos');
                return response.json();
            })
            .then(data => {
                if (!data.success) {
                    productosGrid.innerHTML = '<p>No se encontraron productos.</p>';
                    return;
                }

                productosGrid.innerHTML = '';
                data.productos.forEach(producto => {
                    const productoDiv = document.createElement('div');
                    productoDiv.classList.add('producto');
                    productoDiv.style.cursor = 'pointer';

                    const price = producto.price || 'Precio no disponible';
                    const priceHTML = `<span>S/ ${price}</span>`;

                    productoDiv.innerHTML = `
                        <img src="${producto.imagen}" alt="${producto.nombre}">
                        <h3>${producto.nombre}</h3>
                        <div class="price">${priceHTML}</div>
                    `;

                    productoDiv.addEventListener('click', () => {
                        openProductModal(producto);
                    });

                    productosGrid.appendChild(productoDiv);
                });
            })
            .catch(error => {
                console.error('Error:', error);
                productosGrid.innerHTML = '<p>Error al cargar los productos.</p>';
            });
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

    categoriaSelect.addEventListener('change', applyFilters);
    minPriceInput.addEventListener('input', applyFilters);
    maxPriceInput.addEventListener('input', applyFilters);
    sortSelect.addEventListener('change', applyFilters);

    applyFilters();
});