-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 29-06-2025 a las 21:35:51
-- Versión del servidor: 10.11.10-MariaDB-log
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u535045561_dulcelatto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id_carrito` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `fecha_agregado` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id_carrito`, `id_usuario`, `id_producto`, `cantidad`, `fecha_agregado`) VALUES
(13, 7, 59, 1000, '2025-06-26 16:06:41'),
(17, 12, 1, 1, '2025-06-29 01:39:07'),
(18, 12, 2, 2, '2025-06-29 03:19:02'),
(19, 12, 3, 1, '2025-06-29 03:27:53'),
(20, 12, 4, 1, '2025-06-29 03:27:59'),
(26, 6, 4, 1, '2025-06-29 04:50:02'),
(28, 14, 76, 3, '2025-06-29 05:08:29'),
(30, 14, 64, 1, '2025-06-29 05:12:11'),
(32, 15, 1, 1, '2025-06-29 18:47:53'),
(38, 8, 45, 1, '2025-06-29 18:58:51'),
(40, 8, 2, 3, '2025-06-29 18:59:20'),
(45, 18, 90, 2, '2025-06-29 19:41:57'),
(46, 18, 6, 1, '2025-06-29 19:42:09'),
(50, 9, 15, 1, '2025-06-29 20:55:56'),
(51, 9, 42, 1, '2025-06-29 20:56:00'),
(52, 9, 39, 1, '2025-06-29 20:56:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_catg` int(11) NOT NULL,
  `nombr_catg` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_catg`, `nombr_catg`) VALUES
(1, 'Pasteles y Tortas'),
(2, 'Helados'),
(3, 'Galletas y Bizcochos'),
(4, 'Cupcakes'),
(5, 'Postres salados'),
(6, 'Postres dulces'),
(7, 'Postres de crema o frias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `imagen` varchar(255) NOT NULL,
  `id_catg` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `imagen`, `id_catg`) VALUES
(1, 'Torta de chocolate', 'Bizcocho esponjoso cubierto cuidadosamente con una capa de chocolate negro y una frambuesa en el centro.', 37.80, '../assets/img/pasteles_y_tortas/torta_de_chocolate.jpg', 1),
(2, 'Cheesecake de Frutos Rojos', 'Una base de galleta crocante que sostiene una cremosa mezcla de queso, coronada con una capa generosa de mermelada de frutos rojos naturales: frambuesas, fresas y arándanos.', 43.70, '../assets/img/pasteles_y_tortas/cheesecake_de_frutos_rojos.jpg', 1),
(3, 'Tiramisú Clásico Italiano', 'Bizcochos empapados en café espresso, entre capas de crema de mascarpone sedosa, espolvoreado con cacao puro para un final sofisticado. 2 por unidad', 9.50, '../assets/img/postres_dulces/tiramisu_clasico_italiano.jpg', 6),
(4, 'Flan Casero con Caramelo', 'Textura suave y delicada, con un brillante caramelo líquido que aporta dulzura y un sabor nostálgico a cada bocado.', 5.20, '../assets/img/postres_de_crema_o_frios/flan_casero_con_caramelo.jpg', 7),
(5, 'Brownie de Chocolate Amargo con Nueces', 'Denso, húmedo y con un intenso sabor a chocolate, con nueces tostadas que aportan un contraste crujiente irresistible.', 15.30, '../assets/img/postres_dulces/brownie_de_chocolate_amargo_con_nueces.jpg', 6),
(6, 'Pastel Tres Leches Tradicional', ' Un bizcocho esponjoso bañado en leche condensada, evaporada y crema de leche, cubierto con merengue dorado y un toque de canela', 42.50, '../assets/img/pasteles_y_tortas/pastel_de_tres_leches_tradicional.jpg', 1),
(7, 'Mousse de Maracuyá con Base Crocante', 'Postre aireado con el sabor exótico y ligeramente ácido del maracuyá, servido sobre una base de galleta triturada.', 41.20, '../assets/img/postres_de_crema_o_frios/mousse_de_maracuya.jpg', 7),
(8, 'Tarta de Manzana Casera', 'Manzanas caramelizadas al horno sobre masa hojaldrada, aromatizadas con canela y nuez moscada.', 36.20, '../assets/img/pasteles_y_tortas/tarta_manzana_casera.jpg', 1),
(9, 'Cupcake Red Velvet con Crema de Queso', 'Suave pastel rojo con glaseado de queso crema batido, decorado con migas de red velvet. 6 por unidad', 15.10, '../assets/img/cupcakes/cupcake_red_velvet_con_crema_de_queso.jpg', 4),
(10, 'Profiteroles Rellenos de Crema Pastelera', 'Delicadas bolas de masa choux rellenas de crema de vainilla, bañadas en chocolate negro. 6 por unidad ', 12.60, '../assets/img/postres_dulces/profiteroles_rellenos_de_crema_pastelera.jpg', 6),
(11, 'Gelatina Tricolor de Sabores Frutales', 'Tres capas coloridas con sabores de uva, piña y fresa, perfectamente definidas y refrescantes.', 23.50, '../assets/img/postres_de_crema_o_frios/gelatina_tricolor_de_sabores_frutales.jpg', 7),
(12, 'Arroz con Leche Cremoso a la Canela', 'Arroz tierno cocinado con leche, azúcar, canela y ralladura de naranja.', 4.10, '../assets/img/postres_dulces/arroz_con_leche_cremoso_a_la_canela.jpg', 6),
(13, 'Pastel de Zanahoria con Nueces y Glaseado', 'Bizcocho húmedo con zanahoria rallada y nueces, cubierto con glaseado de queso crema.', 48.80, '../assets/img/pasteles_y_tortas/pastel_de_zanahoria_con_nueces_y_glaseado.jpg', 1),
(14, 'Helado Artesanal de Fresa Natural', 'Helado hecho con fresas frescas, sin colorantes, con textura suave y sabor auténtico.', 6.30, '../assets/img/helados/helado_artesanal_de_fresa_natural.jpg', 2),
(15, 'Pastel de Chocolate Intenso con Ganache', 'Bizcocho oscuro con cobertura espesa de ganache de chocolate derretido.', 58.20, '../assets/img/pasteles_y_tortas/pastel_de_chocolate_intenso_con_ganeche.jpg', 1),
(16, 'Pay de Limón con Merengue Tostado', 'Relleno de limón sobre base de galleta, cubierto con merengue dorado al horno.', 36.50, '../assets/img/postres_dulces/pay_de_limon_con_merengue_tostado.jpg', 6),
(17, 'Mousse de Chocolate Negro', 'Espuma de chocolate aireada, decorada con ralladura de chocolate y menta fresca. ', 4.50, '../assets/img/postres_de_crema_o_frios/mousse_chocolate_negro.jpg', 7),
(18, 'Pannacotta de Coco con Salsa Tropical', 'Suave postre italiano con leche de coco y reducción de piña y mango.', 6.40, '../assets/img/postres_de_crema_o_frios/pannacotta_de_coco_con_salsa_tropical.jpeg', 7),
(19, 'Pastel Selva Negra Clásico', 'Capas de bizcocho de chocolate, cerezas maceradas y crema batida, con virutas de chocolate.', 52.50, '../assets/img/pasteles_y_tortas/pastel_selva_negra_clasico.jpg', 1),
(20, 'Bavarois de Mango Tropical', 'Postre frío y ligero con mango fresco y nata, ideal como postre refrescante.', 20.20, '../assets/img/postres_de_crema_o_frios/bavarois_de_mango_tropical.jpg', 7),
(21, 'Donas Glaseadas Artesanales', 'Donas esponjosas con glaseado dulce de vainilla o chocolate. 6 por unidad', 14.60, '../assets/img/postres_dulces/donas_glaseadas_artesanales.jpg', 6),
(22, 'Pastel de Oreo con Crema de Vainilla', 'Capas de crema batida con galleta Oreo y base crocante de chocolate.', 50.20, '../assets/img/pasteles_y_tortas/pastel_de_oreo_con_crema_de_vainilla.jpg', 1),
(23, 'Crema Volteada Casera', 'Similar al flan, con textura firme, cubierta con caramelo espeso.', 32.40, '../assets/img/postres_de_crema_o_frios/crema_volteada_casera.jpg', 7),
(24, 'Rollitos de Canela recién horneados', 'Masa tierna enrollada con canela y azúcar moreno, glaseada con vainilla. 6 por unidad', 11.40, '../assets/img/postres_dulces/rollitos_de_canela.jpg', 6),
(25, 'Napoleón de Fresas y Crema Pastelera', 'Capas de hojaldre rellenas con crema pastelera y fresas frescas.', 21.10, '../assets/img/postres_dulces/napoleon_de_fresas_y_crema_pastelera.jpg', 6),
(26, 'Pastel de Limón y Arándanos', 'Bizcocho con arándanos frescos y glaseado de limón natural.', 48.90, '../assets/img/pasteles_y_tortas/pastel_de_limon_y_arandanos.jpeg', 1),
(27, 'Trufas de Chocolate con Relleno Cremoso', 'Bombones redondos con centro suave de ganache y cobertura de cacao. 6 por unidad', 10.20, '../assets/img/postres_dulces/trufas_de_chocolate_con_relleno.jpg', 6),
(28, 'Tarta de Queso al Horno estilo Nueva York', 'Cremosa, firme y dorada, servida con salsa de frutos rojos.', 48.20, '../assets/img/pasteles_y_tortas/tarta_de_queso_estilo_nueva_york.jpg', 1),
(29, 'Parfait de Yogur Griego y Frutas', 'Capas frescas de yogur cremoso, granola tostada con miel y frutas naturales como kiwi, fresas y arándanos', 6.10, '../assets/img/postres_de_crema_o_frios/parfait_de_yogur_griego_y_frutas.jpg', 7),
(30, 'Helado de Maracuyá con Chips de Chocolate', 'Helado tropical con toque ácido y trozos crujientes de chocolate.', 7.30, '../assets/img/helados/helado_de_maracuya_con_chips_de_chocolate.jpg', 2),
(31, 'Torta de Plátano y Nuez Caramelizada', 'Bizcocho húmedo de plátano con nueces tostadas y glaseado de caramelo caliente', 55.60, '../assets/img/pasteles_y_tortas/torta_de_platano_y_nuez_caramelizada.jpg', 1),
(32, 'Pastel de Vainilla y Fresas', 'Esponjoso pastel de vainilla con fresas frescas y crema', 35.50, '../assets/img/pasteles_y_tortas/pastel_de_vainilla_y_fresas.jpg', 1),
(33, 'Torta de Zanahoria con Nueces', 'Torta húmeda de zanahoria con nueces y frosting de queso', 38.00, '../assets/img/pasteles_y_tortas/torta_de_zanahoria_con_nueces.jpg', 1),
(34, 'Pastel de Almendra y Miel', 'Delicado pastel de almendra con un toque de miel natural', 40.20, '../assets/img/pasteles_y_tortas/pastel_de_almendra_y_miel.jpg', 1),
(35, 'Torta de Café y Chocolate', 'Combinación intensa de café y chocolate oscuro', 42.30, '../assets/img/pasteles_y_tortas/torta_de_cafe_y_chocolate.jpg', 1),
(36, 'Pastel de Coco Rallado', 'Suave pastel de coco con cobertura de coco rallado', 36.80, '../assets/img/pasteles_y_tortas/pastel_de_coco_rallado.jpg', 1),
(37, 'Torta de Naranja y Almendra', 'Sabor cítrico con almendras tostadas', 39.50, '../assets/img/pasteles_y_tortas/torta_de_naranja_y_almendra.jpg', 1),
(38, 'Pastel de Piña Colada', 'Tropical pastel con piña y un toque de coco', 37.90, '../assets/img/pasteles_y_tortas/pastel_de_pina_colada.jpg', 1),
(39, 'Torta de Avellana y Chocolate', 'Rica torta con avellanas trituradas y ganache', 43.10, '../assets/img/pasteles_y_tortas/torta_de_avellana_y_chocolate.jpg', 1),
(40, 'Pastel de Manzana y Canela', 'Clásico pastel con manzana caramelizada y canela', 34.70, '../assets/img/pasteles_y_tortas/pastel_de_manzana_y_canela.jpg', 1),
(41, 'Torta de Limón Merengue', 'Fresca torta de limón con merengue tostado', 41.60, '../assets/img/pasteles_y_tortas/torta_de_limon_merengue.jpg', 1),
(42, 'Pastel de Frutas Silvestres', 'Mezcla de frutos rojos en un pastel esponjoso', 38.20, '../assets/img/pasteles_y_tortas/pastel_de_frutas_silvestres.jpg', 1),
(43, 'Torta de Yogur y Arándanos', 'Suave torta de yogur con arándanos frescos', 36.40, '../assets/img/pasteles_y_tortas/torta_de_yogur_y_arandanos.jpg', 1),
(44, 'Pastel de Chocolate Blanco', 'Delicado pastel con cobertura de chocolate blanco', 44.00, '../assets/img/pasteles_y_tortas/pastel_de_chocolate_blanco.jpg', 1),
(45, 'Torta de Pistacho y Rosa', 'Exótico sabor a pistacho con notas de rosa', 45.30, '../assets/img/pasteles_y_tortas/torta_de_pistacho_y_rosa.jpg', 1),
(46, 'Pastel de Moka y Avellana', 'Combinación cremosa de moka y avellanas', 42.80, '../assets/img/pasteles_y_tortas/pastel_de_moka_y_avellana.jpg', 1),
(47, 'Helado de Mango y Chile', 'Helado cremoso con un toque picante de chile', 25.00, '../assets/img/helados/helado_de_mango_y_chile.jpg', 2),
(48, 'Helado de Chocolate Amargo', 'Intenso helado de chocolate negro', 27.50, '../assets/img/helados/helado_de_chocolate_amargo.jpg', 2),
(49, 'Helado de Coco y Maracuyá', 'Refrescante mezcla tropical', 26.80, '../assets/img/helados/helado_de_coco_y_maracuya.jpg', 2),
(50, 'Helado de Vainilla Bourbon', 'Elaborado con vainilla de alta calidad', 28.20, '../assets/img/helados/helado_de_vainilla_bourbon.jpg', 2),
(51, 'Helado de Caramelo Salado', 'Dulce y salado en cada cucharada', 29.00, '../assets/img/helados/helado_de_caramelo_salado.jpg', 2),
(52, 'Helado de Pistacho', 'Sabor intenso y cremoso de pistacho', 30.40, '../assets/img/helados/helado_de_pistacho.jpg', 2),
(53, 'Helado de Frutos Rojos', 'Mezcla de fresas, frambuesas y moras', 27.90, '../assets/img/helados/helado_de_frutos_rojos.jpg', 2),
(54, 'Helado de Tiramisú', 'Inspirado en el clásico italiano', 31.50, '../assets/img/helados/helado_de_tiramisu.jpg', 2),
(55, 'Helado de Limón Siciliano', 'Cítrico y refrescante', 26.30, '../assets/img/helados/helado_de_limon_siciliano.jpg', 2),
(56, 'Helado de Nutella', 'Cremoso con avellanas y chocolate', 32.00, '../assets/img/helados/helado_de_nutella.jpg', 2),
(57, 'Helado de Té Verde', 'Sutil sabor a té con un toque dulce', 28.70, '../assets/img/helados/helado_de_te_verde.jpg', 2),
(58, 'Helado de Café Espresso', 'Fuerte y aromático', 30.10, '../assets/img/helados/helado_de_cafe_espresso.jpg', 2),
(59, 'Helado de Arándanos y Yogur', 'Ligero y con notas ácidas', 27.60, '../assets/img/helados/helado_de_arandanos_y_yogur.jpg', 2),
(60, 'Helado de Chocolate con Menta', 'Refrescante combinación', 29.80, '../assets/img/helados/helado_de_chocolate_con_menta.jpg', 2),
(61, 'Helado de Dulce de Leche', 'Clásico argentino cremoso', 31.20, '../assets/img/helados/helado_de_dulce_de_leche.jpg', 2),
(62, 'Galletas de Avena y Pasas', 'Crujientes con pasas jugosas', 12.50, '../assets/img/galletas_y_bizcochos/galletas_de_avena_y_pasas.jpg', 3),
(63, 'Bizcocho de Limón Glaseado', 'Esponjoso con glaseado cítrico', 15.00, '../assets/img/galletas_y_bizcochos/bizcocho_de_limon_glaseado.jpg', 3),
(64, 'Galletas de Canela', 'Aromáticas y crujientes', 11.80, '../assets/img/galletas_y_bizcochos/galletas_de_canela.jpg', 3),
(65, 'Bizcocho de Naranja', 'Suave y con ralladura de naranja', 14.20, '../assets/img/galletas_y_bizcochos/bizcocho_de_naranja.jpg', 3),
(66, 'Galletas de Chocolate y Almendra', 'Ricas en sabor a chocolate', 13.90, '../assets/img/galletas_y_bizcochos/galletas_de_chocolate_y_almendra.jpg', 3),
(67, 'Bizcocho de Yogur', 'Húmedo y ligero', 15.60, '../assets/img/galletas_y_bizcochos/bizcocho_de_yogur.jpg', 3),
(68, 'Galletas de Mantequilla', 'Clásicas y derretidas en boca', 12.30, '../assets/img/galletas_y_bizcochos/galletas_de_mantequilla.jpg', 3),
(69, 'Bizcocho de Manzana', 'Con trozos de manzana fresca', 16.00, '../assets/img/galletas_y_bizcochos/bizcocho_de_manzana.jpg', 3),
(70, 'Galletas de Avellana', 'Crujientes con avellanas tostadas', 14.70, '../assets/img/galletas_y_bizcochos/galletas_de_avellana.jpg', 3),
(71, 'Bizcocho de Café', 'Aromático y esponjoso', 15.40, '../assets/img/galletas_y_bizcochos/bizcocho_de_cafe.jpg', 3),
(72, 'Galletas de Jengibre', 'Especiadas y festivas', 13.50, '../assets/img/galletas_y_bizcochos/galletas_de_jengibre.jpg', 3),
(73, 'Bizcocho de Coco', 'Tropical y húmedo', 16.20, '../assets/img/galletas_y_bizcochos/bizcocho_de_coco.jpg', 3),
(74, 'Galletas de Chispas de Chocolate', 'Clásicas americanas', 12.90, '../assets/img/galletas_y_bizcochos/galletas_de_chispas_de_chocolate.jpg', 3),
(75, 'Bizcocho de Pistacho', 'Exótico y delicado', 17.00, '../assets/img/galletas_y_bizcochos/bizcocho_de_pistacho.jpg', 3),
(76, 'Galletas de Miel y Nueces', 'Dulces con un toque crujiente', 14.30, '../assets/img/galletas_y_bizcochos/galletas_de_miel_y_nueces.jpg', 3),
(77, 'Cupcake de Vainilla y Fresas', 'Suave con crema de fresas', 18.00, '../assets/img/cupcakes/cupcake_de_vainilla_y_fresas.JPG', 4),
(78, 'Cupcake de Chocolate y Menta', 'Fresco con toque de menta', 19.50, '../assets/img/cupcakes/cupcake_de_chocolate_y_menta.jpeg', 4),
(79, 'Cupcake de Limón', 'Cítrico con glaseado ligero', 17.80, '../assets/img/cupcakes/cupcake_de_limon.jpg', 4),
(80, 'Cupcake de Caramelo', 'Dulce con salsa de caramelo', 20.20, '../assets/img/cupcakes/cupcake_de_caramelo.jpg', 4),
(81, 'Cupcake de Frutos Rojos', 'Decorado con frutos frescos', 18.90, '../assets/img/cupcakes/cupcake_de_frutos_rojos.jpg', 4),
(82, 'Cupcake de Café', 'Aromático con crema de café', 19.70, '../assets/img/cupcakes/cupcake_de_cafe.jpg', 4),
(83, 'Cupcake de Pistacho', 'Sabor intenso y cremoso', 21.00, '../assets/img/cupcakes/cupcake_de_pistacho.jpg', 4),
(84, 'Cupcake de Coco', 'Tropical con coco rallado', 18.40, '../assets/img/cupcakes/cupcake_de_coco.jpg', 4),
(85, 'Cupcake de Arándanos', 'Suave con arándanos frescos', 19.30, '../assets/img/cupcakes/cupcake_de_arandanos.jpg', 4),
(86, 'Cupcake de Chocolate Blanco', 'Delicado con crema suave', 20.60, '../assets/img/cupcakes/cupcake_de_chocolate_blanco.jpg', 4),
(87, 'Cupcake de Moka', 'Combinación de café y chocolate', 21.50, '../assets/img/cupcakes/cupcake_de_moka.jpg', 4),
(88, 'Cupcake de Nutella', 'Cremoso con avellanas', 22.00, '../assets/img/cupcakes/cupcake_de_nutella.jpeg', 4),
(89, 'Cupcake de Vainilla y Caramelo', 'Dulce con salsa dorada', 19.10, '../assets/img/cupcakes/cupcake_de_vainilla_y_caramelo.jpg', 4),
(90, 'Cupcake de Fresa y Crema', 'Fresco y decorado con crema', 20.30, '../assets/img/cupcakes/cupcake_de_fresa_y_crema.jpg', 4),
(91, 'Cupcake de Canela', 'Aromático con glaseado', 18.70, '../assets/img/cupcakes/cupcake_de_canela.png', 4),
(92, 'Quiche de Espinaca y Queso', 'Tarta salada con espinaca y queso', 22.50, '../assets/img/postres_salados/quiche_de_espinaca_y_queso.jpg', 5),
(93, 'Tarta de Tomate y Albahaca', 'Sabor fresco con albahaca', 23.80, '../assets/img/postres_salados/tarta_de_tomate_y_albahaca.jpg', 5),
(94, 'Empanada de Pollo', 'Rellena de pollo desmenuzado', 20.90, '../assets/img/postres_salados/empanada_de_pollo.jpg', 5),
(95, 'Tarta de Cebolla Caramelizada', 'Dulce y salada con cebolla', 24.30, '../assets/img/postres_salados/tarta_de_cebolla_caramelizada.jpg', 5),
(96, 'Quiche de Champiñones', 'Cremosa con champiñones frescos', 22.00, '../assets/img/postres_salados/quiche_de_champiñones.jpeg', 5),
(97, 'Tarta de Atún y Pimientos', 'Sabrosa con atún y vegetales', 23.40, '../assets/img/postres_salados/tarta_de_atun_y_pimientos.jpg', 5),
(98, 'Empanada de Carne', 'Clásica con carne especiada', 21.70, '../assets/img/postres_salados/empanada_de_carne.jpg', 5),
(99, 'Tarta de Brócoli y Queso', 'Saludable con brócoli', 24.60, '../assets/img/postres_salados/tarta_de_brocoli_y_queso.jpg', 5),
(100, 'Quiche de Salmón', 'Delicada con salmón ahumado', 25.20, '../assets/img/postres_salados/quiche_de_salmon.jpg', 5),
(101, 'Tarta de Espárragos', 'Fresca con espárragos tiernos', 23.10, '../assets/img/postres_salados/tarta_de_esparragos.jpeg', 5),
(102, 'Empanada de Verduras', 'Rellena de vegetales mixtos', 20.50, '../assets/img/postres_salados/empanada_de_verduras.jpeg', 5),
(103, 'Tarta de Jamón y Queso', 'Clásica y reconfortante', 24.90, '../assets/img/postres_salados/tarta_de_jamon_y_queso.jpg', 5),
(104, 'Quiche de Puerro', 'Cremosa con puerro salteado', 22.70, '../assets/img/postres_salados/quiche_de_puerro.jpg', 5),
(105, 'Tarta de Pollo y Maíz', 'Sabrosa con maíz dulce', 23.60, '../assets/img/postres_salados/tarta_de_pollo_y_maiz.jpg', 5),
(106, 'Empanada de Setas', 'Aromática con setas silvestres', 25.00, '../assets/img/postres_salados/empanada_de_setas.jpg', 5),
(107, 'Flan de Café', 'Suave con un toque de café', 16.50, '../assets/img/postres_dulces/flan_de_cafe.jpg', 6),
(108, 'Gelatina de Frutas Mixtas', 'Colorida con frutas frescas', 14.80, '../assets/img/postres_dulces/gelatina_de_frutas_mixtas.jpg', 6),
(109, 'Arroz con Leche de Coco', 'Cremoso con coco rallado', 17.20, '../assets/img/postres_dulces/arroz_con_leche_de_coco.jpg', 6),
(110, 'Pudín de Pan y Canela', 'Tradicional con pan y especias', 15.90, '../assets/img/postres_dulces/pudin_de_pan_y_canela.jpg', 6),
(111, 'Semifreddo de Chocolate', 'Fresco y con chocolate oscuro', 18.30, '../assets/img/postres_dulces/semifreddo_de_chocolate.jpeg', 6),
(112, 'Mousse de Limón', 'Ligero y cítrico', 16.70, '../assets/img/postres_dulces/mousse_de_limon.jpg', 6),
(113, 'Panna Cotta de Vainilla', 'Suave con salsa de frutos rojos', 17.60, '../assets/img/postres_dulces/panna_cotta_de_vainilla.jpg', 6),
(114, 'Terrina de Frutas', 'Fresca con capas de frutas', 15.40, '../assets/img/postres_dulces/terrina_de_frutas.jpg', 6),
(115, 'Parfait de Yogur', 'Cremoso con frutas y granola', 18.00, '../assets/img/postres_dulces/parfait_de_yogur.jpg', 6),
(116, 'Sorbete de Mango', 'Refrescante y natural', 16.20, '../assets/img/postres_dulces/sorbete_de_mango.jpg', 6),
(117, 'Crema Catalana', 'Clásica con crujiente de azúcar', 17.90, '../assets/img/postres_dulces/crema_catalana.jpg', 6),
(118, 'Gelatina de Vino Tinto', 'Elegante con notas de vino', 15.70, '../assets/img/postres_dulces/gelatina_de_vino_tinto.jpeg', 6),
(119, 'Pudín de Chocolate', 'Intenso y cremoso', 18.50, '../assets/img/postres_dulces/pudin_de_chocolate.jpg', 6),
(120, 'Mousse de Frambuesa', 'Ligero con frambuesas frescas', 17.30, '../assets/img/postres_dulces/mousse_de_frambuesa.jpeg', 6),
(121, 'Semifreddo de Avellana', 'Dulce con avellanas tostadas', 19.10, '../assets/img/postres_dulces/semifreddo_de_avellana.jpg', 6),
(122, 'Crema de Almendra', 'Suave con almendras trituradas', 20.40, '../assets/img/postres_de_crema_o_frios/crema_de_almendra.jpg', 7),
(123, 'Mousse de Tiramisú', 'Cremosa con café y mascarpone', 22.10, '../assets/img/postres_de_crema_o_frios/mousse_de_tiramisu.jpg', 7),
(124, 'Panna Cotta de Caramelo', 'Dulce con salsa de caramelo', 21.80, '../assets/img/postres_de_crema_o_frios/panna_cotta_de_caramelo.jpg', 7),
(125, 'Crema de Chocolate Blanco', 'Delicada y suave', 23.50, '../assets/img/postres_de_crema_o_frios/crema_de_chocolate_blanco.jpg', 7),
(126, 'Mousse de Mango', 'Tropical y refrescante', 6.90, '../assets/img/postres_de_crema_o_frios/mousse_de_mango.jpg', 7),
(127, 'Panna Cotta de Fresa', 'Con salsa de fresas frescas', 5.70, '../assets/img/postres_de_crema_o_frios/panna_cotta_de_fresa.jpg', 7),
(128, 'Crema de Café', 'Aromática con toque de canela', 6.30, '../assets/img/postres_de_crema_o_frios/crema_de_cafe.jpg', 7),
(129, 'Mousse de Avellana', 'Cremosa con avellanas', 15.20, '../assets/img/postres_de_crema_o_frios/mousse_de_avellana.jpg', 7),
(130, 'Panna Cotta de Pistacho', 'Exótica con pistacho', 22.60, '../assets/img/postres_de_crema_o_frios/panna_cotta_de_pistacho.jpeg', 7),
(131, 'Crema de Limón', 'Cítrica y ligera', 8.70, '../assets/img/postres_de_crema_o_frios/crema_de_limon.jpg', 7),
(132, 'Mousse de Chocolate Blanco y Maracuyá', 'Doble capa de mousse combinando chocolate blanco y maracuyá con decoración de fruta', 7.00, '../assets/img/postres_de_crema_o_frios/mousse_de_chocolate_blanco_y_maracuya.jpg', 7),
(133, 'Panna Cotta de Baileys', 'Con un toque de licor', 8.90, '../assets/img/postres_de_crema_o_frios/panna_cotta_de_baileys.jpg', 7),
(134, 'Crema de Vainilla', 'Clásica con notas suaves', 21.50, '../assets/img/postres_de_crema_o_frios/crema_de_vainilla.jpg', 7),
(135, 'Mousse de Frutas del Bosque', 'Fresca con frutos mixtos', 22.30, '../assets/img/postres_de_crema_o_frios/mousse_de_frutas_del_bosque.jpeg', 7),
(136, 'Panna Cotta de Naranja', 'Cítrica con gelatina de naranja', 21.10, '../assets/img/postres_de_crema_o_frios/panna_cotta_de_naranja.jpg', 7),
(141, 'Prueba', 'Prueba', 1000.00, '../assets/img/helados/butisito 2.png', 2),
(142, 'Turron', 'Delicioso dulce tradicional hecho con miel pura, azúcar y almendras seleccionadas, perfecto para compartir en cualquier ocasión. Suave, crujiente y 100% irresistible.', 15.00, '../assets/img/postres_dulces/turron.jpg', 6),
(143, 'Torta Opera', 'Un exquisito pastel francés de finas capas de bizcocho Joconde almendrado, empapado en café, relleno con suave crema de mantequilla y ganache de chocolate oscuro. Un postre sofisticado, intenso y perfectamente equilibrado entre lo dulce y lo amargo. Ideal para amantes del café y el buen gusto.', 60.00, '../assets/img/pasteles_y_tortas/tortaopera.jpg', 1),
(144, 'Pavlova', 'Ligera, crujiente y celestial. Una base de merengue crocante por fuera y suave como nube por dentro, coronada con crema batida y frutas frescas como fresas, kiwi o maracuyá. Un postre delicado pero explosivo en sabor. Perfecta para impresionar… o simplemente darte un gusto de reina. ', 56.00, '../assets/img/postres_dulces/pavlova.jpg', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_us` int(11) NOT NULL,
  `nombre_us` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `fech_nacmnto` date NOT NULL,
  `es_admin` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_us`, `nombre_us`, `correo`, `password`, `fech_nacmnto`, `es_admin`) VALUES
(6, 'Joaquin', 'joaquin@gmail.com', '$2y$10$ha3Yi4koXTwRiUPC.vylj.m6wMYnP87M.vPMVVt8RU6pe5/Q0IoUe', '2005-04-03', 0),
(7, 'Luciana', 'luciana@gmail.com', '$2y$10$Z/maz.RSjELLEe/Xa7OYrOlGjyEFtz9J6k.Y63vi5KJUDNoSWr2Ni', '2006-10-25', 0),
(8, 'Cuenta', 'cuenta@gmail.com', '$2y$10$3mpJ7qc8VGhgrxirRmolRe/PacFZfnH/8O3/kZE/b0BuPn0y51voi', '1998-01-21', 0),
(9, 'adminDulcelatto', 'adminDulcelatto@gmail.com', '$2y$10$Gul3YUeDTENzczckK930RuY8XsaigV/JL598v24HzD7nL5QvVKScC', '2006-12-12', 1),
(10, 'jhoanisrq', 'jhoanisrq@gmail.com', '$2y$10$bSU0v.cFYtoYAAVK5ZkBre8qqjP3SZr88icPFMKDFTfj1YcnSgahe', '2006-12-18', 0),
(11, 'luis', 'luis@gmail.com', '$2y$10$i0cdKwigI8b1PZsjzBR5a.2izCwRwntge3Az9nZZvF5zGRxjjnWz6', '2006-11-15', 0),
(12, 'prueba', 'prueba@gmail.com', '$2y$10$mi10qY0KeN9I/o5KzA44feY38rHusqa.iN5Qxt5VO1amHW4tmfKh2', '0001-12-12', 0),
(13, 'prueba2', 'prueba2@gmail.com', '$2y$10$J40WZ2E2oICtkDD9JB3yI.yCgt9kcdkMNDC45rObGtkBx8y.E1E.W', '2003-12-04', 0),
(14, 'prueba3', 'prueba3@gmail.com', '$2y$10$he/IPWWq5Rivba91K1oLp.VAPRxNsXC304VB5ldXzng3NACQaaV/K', '2003-05-06', 0),
(15, 'Maria', 'cuentaMaria@gmail.com', '$2y$10$bxANc9MDMZ2ntPHqMbI8VOmMEC4LtwNhzlzzJ0ERwLvPSBDXIC9pC', '2025-06-10', 0),
(16, 'Maria', 'maria123@gmail.com', '$2y$10$uFvHhfuxRusuNUOsUHc1geld5cVKWhoL96fPApWr8AcdeAYWXnzIK', '1999-06-15', 0),
(17, 'Lucia', 'lucia@gmail.com', '$2y$10$jK9okB7.hAqWr4poWcEXveDlMh3wO/k4OTnYZUPyDDxqMz/KhJ9.W', '2005-04-13', 0),
(18, 'juan', 'juan@gmail.com', '$2y$10$WoWGTSQ01XRsEFK3pmQpI.lvgIab/Z7ASQYRXfyalAvEMfB6k7HYG', '1998-04-12', 0),
(19, 'cuenta5', 'cuenta5@gmail.com', '$2y$10$IwFKjSLhBx59YI8cjAdZrez.4B/TrVNonVsGnrP.Vqw2.NkI.LvXa', '1999-12-12', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `idx_carrito_usuario_producto` (`id_usuario`,`id_producto`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_catg`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_catg` (`id_catg`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_us`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_catg` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_us` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_us`) ON DELETE CASCADE,
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_catg`) REFERENCES `categorias` (`id_catg`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
