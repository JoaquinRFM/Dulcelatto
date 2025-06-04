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
        fetch(`http://farbeg.com/Dulcelatto-main/Dulcelatto/includes/filter_products.php?${queryParams.toString()}`)
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

    categoriaSelect.addEventListener('change', applyFilters);
    minPriceInput.addEventListener('input', applyFilters);
    maxPriceInput.addEventListener('input', applyFilters);
    sortSelect.addEventListener('change', applyFilters);

    applyFilters();
});