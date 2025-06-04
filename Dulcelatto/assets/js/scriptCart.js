document.addEventListener('DOMContentLoaded', function() {
    const carritoGrid = document.querySelector('#carrito-grid');
    const totalPrice = document.querySelector('#carrito-total-price');

    if (!carritoGrid) {
        console.error('Error: No se encontró el contenedor #carrito-grid');
        return;
    }

    fetch('http://farbeg.com/Dulcelatto-main/Dulcelatto/includes/get_cart.php')
    //fetch('../includes/get_cart.php')
        .then(response => {
            if (!response.ok) throw new Error('Error al cargar el carrito');
            return response.json();
        })
        .then(data => {
            if (!data.success) {
                carritoGrid.innerHTML = '<p>' + data.message + '</p>';
                return;
            }

            carritoGrid.innerHTML = '';
            data.carrito.forEach(item => {
                const itemDiv = document.createElement('div');
                itemDiv.classList.add('carrito-item');
                itemDiv.innerHTML = `
                    <img src="${item.imagen}" alt="${item.nombre}">
                    <div class="nombre">${item.nombre}</div>
                    <div class="cantidad">
                        <input type="number" value="${item.cantidad}" min="1" data-id="${item.id_carrito}">
                    </div>
                    <div class="precio">S/ ${item.subtotal}</div>
                    <div class="eliminar" data-id="${item.id_carrito}">Eliminar</div>
                `;
                carritoGrid.appendChild(itemDiv);
            });

            totalPrice.textContent = data.total;
        })
        .catch(error => {
            console.error('Error:', error);
            carritoGrid.innerHTML = '<p>Error al cargar el carrito. Por favor, intenta de nuevo.</p>';
        });

    carritoGrid.addEventListener('change', function(e) {
        if (e.target.tagName === 'INPUT' && e.target.type === 'number') {
            const id_carrito = e.target.dataset.id;
            const cantidad = parseInt(e.target.value);

            fetch('../includes/update_cart.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `action=update&id_carrito=${id_carrito}&cantidad=${cantidad}`
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                        fetch('../includes/get_cart_count.php')
                            .then(res => res.json())
                            .then(cartData => {
                                if (cartData.success) {
                                    document.querySelector('#cart-count').textContent = cartData.count;
                                }
                            });
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => console.error('Error:', error));
        }
    });

    carritoGrid.addEventListener('click', function(e) {
        if (e.target.classList.contains('eliminar')) {
            const id_carrito = e.target.dataset.id;

            fetch('../includes/update_cart.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `action=delete&id_carrito=${id_carrito}`
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                        fetch('../includes/get_cart_count.php')
                            .then(res => res.json())
                            .then(cartData => {
                                if (cartData.success) {
                                    document.querySelector('#cart-count').textContent = cartData.count;
                                }
                            });
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => console.error('Error:', error));
        }
    });
});