import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const DulcelattoApp());
}

class DulcelattoApp extends StatelessWidget {
  const DulcelattoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dulcelatto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ------------------- SPLASH PARA AUTOLOGIN -------------------
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    final userName = prefs.getString('user_name');
    if (userId != null && userName != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeTabsPage(userName: userName)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BienvenidaPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

// ------------------- BIENVENIDA -------------------
class BienvenidaPage extends StatelessWidget {
  const BienvenidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/pastel.png', width: 120, height: 120),
              const SizedBox(height: 16),
              const Text(
                'Dulcelatto',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cursive',
                ),
              ),
              const Text(
                'POSTRES',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '¡Bienvenido a Dulcelatto!\nDonde encontrarás los postres más deliciosos, con una decoración encantadora, un sabor inolvidable y precios que te van a sorprender',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const AuthPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  side: const BorderSide(color: Colors.deepPurple),
                ),
                child: const Text('continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- LOGIN/REGISTER -------------------
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  final _regUsernameController = TextEditingController();
  final _regBirthController = TextEditingController();
  final _regEmailController = TextEditingController();
  final _regPasswordController = TextEditingController();
  final _regPassword2Controller = TextEditingController();

  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    final email = _loginEmailController.text.trim();
    final password = _loginPasswordController.text.trim();

    final response = await http.post(
      Uri.parse('https://bublut.com/Dulcelatto/includes/login_user.php'),
      body: {'email': email, 'password': password},
    );
    setState(() => _loading = false);

    final data = json.decode(response.body);
    if (data['status'] == 'success') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', data['user_id'].toString());
      await prefs.setString('user_name', data['user_name']);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeTabsPage(userName: data['user_name']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Error al iniciar sesión')),
      );
    }
  }

  Future<void> _register() async {
    setState(() => _loading = true);
    final username = _regUsernameController.text.trim();
    final birth = _regBirthController.text.trim();
    final email = _regEmailController.text.trim();
    final password = _regPasswordController.text.trim();
    final password2 = _regPassword2Controller.text.trim();

    if (password != password2) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('https://bublut.com/Dulcelatto/includes/register_user.php'),
      body: {
        'username': username,
        'birth': birth,
        'email': email,
        'password': password,
      },
    );
    setState(() => _loading = false);

    final data = json.decode(response.body);
    if (data['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Registro exitoso! Ahora inicia sesión.'),
        ),
      );
      setState(() => isLogin = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Error al registrar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/pastel.png', width: 120, height: 120),
              const SizedBox(height: 16),
              const Text(
                'Dulcelatto',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cursive',
                ),
              ),
              const Text(
                'POSTRES',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              if (isLogin) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Use su correo y contraseña',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _loginEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electronico',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _loginPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[100],
                      foregroundColor: Colors.black,
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Iniciar sesión'),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes una cuenta? '),
                    GestureDetector(
                      onTap: () => setState(() => isLogin = false),
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Regístrate',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Use su correo electronico para registrarse',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _regUsernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _regBirthController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de nacimiento',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _regEmailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _regPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _regPassword2Controller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Nuevamente la contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[100],
                      foregroundColor: Colors.black,
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('registrarse'),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿Ya tienes cuenta? '),
                    GestureDetector(
                      onTap: () => setState(() => isLogin = true),
                      child: const Text(
                        'Inicie sesión',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- HOME TABS -------------------
class HomeTabsPage extends StatefulWidget {
  final String userName;
  const HomeTabsPage({super.key, required this.userName});
  @override
  State<HomeTabsPage> createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  int _selectedIndex = 1; // 1 = catalogo por defecto

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      InicioPage(userName: widget.userName),
      const CatalogoPage(),
      const CarritoPage(),
      Container(), // Placeholder para salir
    ]);
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthPage()),
      (route) => false,
    );
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas salir de tu cuenta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Salir'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _logout();
    } else {
      setState(() => _selectedIndex = 1); // Vuelve al catálogo si cancela
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 3 ? Container() : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.black54,
        onTap: (index) async {
          if (index == 3) {
            setState(() => _selectedIndex = 3);
            await _confirmLogout();
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'catalogo'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'carrito',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'salir'),
        ],
      ),
    );
  }
}

// ------------------- INICIO -------------------
class InicioPage extends StatelessWidget {
  final String userName;
  const InicioPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Text(
                  '¡Hola $userName!',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _ProductoMiniCard(
                      nombre: 'Cupcake',
                      imagen: 'assets/images/pastel.png',
                    ),
                    SizedBox(width: 16),
                    _ProductoMiniCard(
                      nombre: 'Brownie',
                      imagen: 'assets/images/pastel.png',
                    ),
                    SizedBox(width: 16),
                    _ProductoMiniCard(
                      nombre: 'Cheesecake',
                      imagen: 'assets/images/pastel.png',
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(16),
                  color: Colors.yellow[100],
                  child: const Text(
                    'La palabra amigos al reves es sogima, lo cual significa amigos pero al reves.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ------------------- CATALOGO -------------------
class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  List productos = [];
  bool loading = true;
  TextEditingController _searchController = TextEditingController();
  List productosFiltrados = [];

  @override
  void initState() {
    super.initState();
    fetchProductos();
    _searchController.addListener(() {
      _filtrarProductos(_searchController.text);
    });
  }

  Future<void> fetchProductos() async {
    setState(() {
      loading = true;
      productos = [];
      productosFiltrados = [];
    });
    try {
      final response = await http.get(
        Uri.parse(
          'https://bublut.com/Dulcelatto/includes/get_products.php?ts=${DateTime.now().millisecondsSinceEpoch}',
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          productos = data;
          productosFiltrados = data;
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  void _filtrarProductos(String query) {
    final queryLower = query.toLowerCase();
    setState(() {
      productosFiltrados = productos.where((producto) {
        final nombre = (producto['nombre'] ?? '').toString().toLowerCase();
        return nombre.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Buscar...',
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _filtrarProductos('');
                              },
                            ),
                          ),
                          onChanged: _filtrarProductos,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('buscar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nuestro Catalogo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: loading ? null : fetchProductos,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Actualizar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[100],
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (loading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (productos.isEmpty)
              const Expanded(
                child: Center(child: Text('No hay productos disponibles')),
              )
            else
              Expanded(
                child: GridView.builder(
                  itemCount: productosFiltrados.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final producto = productosFiltrados[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => _ProductoDetalleModal(
                            producto: producto,
                            onProductoAgregado: () {},
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/pastel.png', // Imagen de prueba para todos los productos
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 60),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              producto['nombre'].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('S/.${producto['precio']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ------------------- MODAL DETALLE PRODUCTO -------------------
class _ProductoDetalleModal extends StatefulWidget {
  final Map<String, dynamic> producto;
  final VoidCallback? onProductoAgregado;
  const _ProductoDetalleModal({
    required this.producto,
    this.onProductoAgregado,
  });

  @override
  State<_ProductoDetalleModal> createState() => _ProductoDetalleModalState();
}

class _ProductoDetalleModalState extends State<_ProductoDetalleModal> {
  int unidades = 1;

  Future<void> agregarAlCarrito(int productoId, int cantidad) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    print(
      'Intentando agregar al carrito: user_id=$userId, producto_id=$productoId, cantidad=$cantidad',
    );
    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Debes iniciar sesión')));
      return;
    }
    try {
      final response = await http.post(
        Uri.parse('https://bublut.com/Dulcelatto/includes/add_to_carrito.php'),
        body: {
          'user_id': userId,
          'producto_id': productoId.toString(),
          'cantidad': cantidad.toString(),
        },
      );
      print('Respuesta add_to_carrito: ${response.body}');
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Producto agregado al carrito'),
          ),
        );
        if (widget.onProductoAgregado != null) {
          widget.onProductoAgregado!();
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Error al agregar')),
        );
      }
    } catch (e) {
      print('Error de conexión al agregar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de conexión al agregar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(widget.producto['nombre'] ?? 'Producto')],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/pastel.png', // Imagen de prueba para todos los productos
            width: 120,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 120),
          ),
          const SizedBox(height: 10),
          Text(widget.producto['descripcion'] ?? ''),
          const SizedBox(height: 10),
          Text('Precio: S/.${widget.producto['precio']}'),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Cantidad:'),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (unidades > 1) setState(() => unidades--);
                },
              ),
              Text(unidades.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() => unidades++);
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            final productoIdRaw = widget.producto['id'];
            final productoId = int.tryParse(productoIdRaw.toString());
            if (productoId == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No se encontró el ID del producto'),
                ),
              );
              return;
            }
            await agregarAlCarrito(productoId, unidades);
          },
          child: const Text('Agregar al carrito'),
        ),
      ],
    );
  }
}

// ------------------- CARRITO -------------------
class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  List carrito = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchCarrito();
  }

  Future<void> fetchCarrito() async {
    setState(() {
      loading = true;
      // carrito = []; // Opcional: puedes dejarlo o quitarlo
    });
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    if (userId == null) {
      setState(() {
        loading = false;
      });
      return;
    }
    final response = await http.get(
      Uri.parse(
        'https://bublut.com/Dulcelatto/includes/get_carrito.php?user_id=$userId&ts=${DateTime.now().millisecondsSinceEpoch}',
      ),
    );
    final data = json.decode(response.body);
    if (data['status'] == 'success') {
      setState(() {
        carrito = data['carrito'];
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> eliminarDelCarrito(int idCarrito) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://bublut.com/Dulcelatto/includes/delete_from_carrito.php',
        ),
        body: {'id_carrito': idCarrito.toString()},
      );
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        fetchCarrito(); // Recarga el carrito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Producto eliminado')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Error al eliminar')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de conexión al eliminar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Carrito',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: loading ? null : fetchCarrito,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Actualizar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[100],
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            if (loading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (carrito.isEmpty)
              const Expanded(
                child: Center(child: Text('No hay productos en el carrito')),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: carrito.length,
                  itemBuilder: (context, index) {
                    final item = carrito[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(item['nombre'].toString()),
                        subtitle: Text(
                          'Precio: S/.${item['precio']} x ${item['cantidad']}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Subtotal: S/.${(double.parse(item['precio'].toString()) * int.parse(item['cantidad'].toString())).toStringAsFixed(2)}',
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: 'Eliminar',
                              onPressed: () async {
                                await eliminarDelCarrito(item['id_carrito']);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ------------------- MENÚ -------------------
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Center(child: Text('Menú de usuario (próximamente)')),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- COMPONENTES REUTILIZABLES -------------------

class _ProductoMiniCard extends StatelessWidget {
  final String nombre;
  final String imagen;
  const _ProductoMiniCard({required this.nombre, required this.imagen});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Image.asset(imagen, width: 60, height: 60), Text(nombre)],
      ),
    );
  }
}
