-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2025 at 09:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dulcelatto`
--

-- --------------------------------------------------------

--
-- Table structure for table `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `imagen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `precio`, `imagen`) VALUES
(1, 'Torta de chocolate', 'Bizcocho esponjoso cubierto cuidadosamente con una capa de chocolate negro y una frambuesa en el centro.', 40.10, '../assets/img/postres/torta_de_chocolate.jpg'),
(2, 'Cheesecake de Frutos Rojos', 'Una base de galleta crocante que sostiene una cremosa mezcla de queso, coronada con una capa generosa de mermelada de frutos rojos naturales: frambuesas, fresas y arándanos.', 58.20, '../assets/img/postres/cheesecake_de_frutos_rojos.jpg'),
(3, 'Tiramisú Clásico Italiano', 'Bizcochos empapados en café espresso, entre capas de crema de mascarpone sedosa, espolvoreado con cacao puro para un final sofisticado.', 9.50, '../assets/img/postres/tiramisu_clasico_italiano.jpg'),
(4, 'Flan Casero con Caramelo', 'Textura suave y delicada, con un brillante caramelo líquido que aporta dulzura y un sabor nostálgico a cada bocado.', 7.20, '../assets/img/postres/flan_casero_con_caramelo.jpg'),
(5, 'Brownie de Chocolate Amargo con Nueces', 'Denso, húmedo y con un intenso sabor a chocolate, con nueces tostadas que aportan un contraste crujiente irresistible.', 15.30, '../assets/img/postres/brownie_de_chocolate_amargo_con_nueces.jpg'),
(6, 'Pastel Tres Leches Tradicional', ' Un bizcocho esponjoso bañado en leche condensada, evaporada y crema de leche, cubierto con merengue dorado y un toque de canela', 47.00, '../assets/img/postres/pastel_de_tres_leches_tradicional.jpg'),
(7, 'Mousse de Maracuyá con Base Crocante', 'Postre aireado con el sabor exótico y ligeramente ácido del maracuyá, servido sobre una base de galleta triturada.', 46.20, '../assets/img/postres/mousse_de_maracuya.jpg'),
(8, 'Tarta de Manzana Casera', 'Manzanas caramelizadas al horno sobre masa hojaldrada, aromatizadas con canela y nuez moscada.', 50.20, '../assets/img/postres/tarta_manzana_casera.jpg'),
(9, 'Cupcake Red Velvet con Crema de Queso', 'Suave pastel rojo con glaseado de queso crema batido, decorado con migas de red velvet.', 8.10, '../assets/img/postres/cupcake_red_velvet_con_crema_de_queso.jpg'),
(10, 'Profiteroles Rellenos de Crema Pastelera', 'Delicadas bolas de masa choux rellenas de crema de vainilla, bañadas en chocolate negro.', 18.60, '../assets/img/postres/profiteroles_rellenos_de_crema_pastelera.jpg'),
(11, 'Gelatina Tricolor de Sabores Frutales', 'Tres capas coloridas con sabores de uva, piña y fresa, perfectamente definidas y refrescantes.', 20.00, '../assets/img/postres/gelatina_tricolor_de_sabores_frutales.jpg'),
(12, 'Arroz con Leche Cremoso a la Canela', 'Arroz tierno cocinado con leche, azúcar, canela y ralladura de naranja.', 7.15, '../assets/img/postres/arroz_con_leche_cremoso_a_la_canela.jpg'),
(13, 'Pastel de Zanahoria con Nueces y Glaseado', 'Bizcocho húmedo con zanahoria rallada y nueces, cubierto con glaseado de queso crema.', 55.80, '../assets/img/postres/pastel_de_zanahoria_con_nueces_y_glaseado.jpg'),
(14, 'Helado Artesanal de Fresa Natural', 'Helado hecho con fresas frescas, sin colorantes, con textura suave y sabor auténtico.', 15.30, '../assets/img/postres/helado_artesanal_de_fresa_natural.jpg'),
(15, 'Pastel de Chocolate Intenso con Ganache', 'Bizcocho oscuro con cobertura espesa de ganache de chocolate derretido.', 69.20, '../assets/img/postres/pastel_de_chocolate_intenso_con_ganeche.jpg'),
(16, 'Pay de Limón con Merengue Tostado', 'Relleno de limón sobre base de galleta, cubierto con merengue dorado al horno.', 42.50, '../assets/img/postres/pay_de_limon_con_merengue_tostado.jpg'),
(17, 'Mousse de Chocolate Negro', 'Espuma de chocolate aireada, decorada con ralladura de chocolate y menta fresca.', 12.40, '../assets/img/postres/mousse_chocolate_negro.jpg'),
(18, 'Pannacotta de Coco con Salsa Tropical', 'Suave postre italiano con leche de coco y reducción de piña y mango.', 14.40, '../assets/img/postres/pannacotta_de_coco_con_salsa_tropical.jpeg'),
(19, 'Pastel Selva Negra Clásico', 'Capas de bizcocho de chocolate, cerezas maceradas y crema batida, con virutas de chocolate.', 54.50, '../assets/img/postres/pastel_selva_negra_clasico.jpg'),
(20, 'Bavarois de Mango Tropical', 'Postre frío y ligero con mango fresco y nata, ideal como postre refrescante.', 13.20, '../assets/img/postres/bavarois_de_mango_tropical.jpg'),
(21, 'Donas Glaseadas Artesanales', 'Donas esponjosas con glaseado dulce de vainilla o chocolate.', 14.60, '../assets/img/postres/donas_glaseadas_artesanales.jpg'),
(22, 'Pastel de Oreo con Crema de Vainilla', 'Capas de crema batida con galleta Oreo y base crocante de chocolate.', 52.20, '../assets/img/postres/pastel_de_oreo_con_crema_de_vainilla.jpg'),
(23, 'Crema Volteada Casera', 'Similar al flan, con textura firme, cubierta con caramelo espeso.', 36.00, '../assets/img/postres/Crema_Volteada_Casera.jpg'),
(24, 'Rollitos de Canela recién horneados', 'Masa tierna enrollada con canela y azúcar moreno, glaseada con vainilla.', 12.40, '../assets/img/postres/rollitos_de_canela.jpg'),
(25, 'Napoleón de Fresas y Crema Pastelera', 'Capas de hojaldre rellenas con crema pastelera y fresas frescas.', 21.10, '../assets/img/postres/napoleon_de_fresas_y_crema_pastelera.jpg'),
(26, 'Pastel de Limón y Arándanos', 'Bizcocho con arándanos frescos y glaseado de limón natural.', 48.90, '../assets/img/postres/pastel_de_limon_y_arandanos.jpeg'),
(27, 'Trufas de Chocolate con Relleno Cremoso', 'Bombones redondos con centro suave de ganache y cobertura de cacao.', 11.20, '../assets/img/postres/trufas_de_chocolate_con_relleno.jpg'),
(28, 'Tarta de Queso al Horno estilo Nueva York', 'Cremosa, firme y dorada, servida con salsa de frutos rojos.', 78.20, '../assets/img/postres/tarta_de_queso_estilo_nueva_york.jpg'),
(29, 'Parfait de Yogur Griego y Frutas', 'Capas frescas de yogur cremoso, granola tostada con miel y frutas naturales como kiwi, fresas y arándanos', 11.40, '../assets/img/postres/parfait_de_yogur_griego_y_frutas.jpg'),
(30, 'Helado de Maracuyá con Chips de Chocolate', 'Helado tropical con toque ácido y trozos crujientes de chocolate.', 14.30, '../assets/img/postres/helado_de_maracuya_con_chips_de_chocolate.jpg'),
(31, 'Torta de Plátano y Nuez Caramelizada', 'Bizcocho húmedo de plátano con nueces tostadas y glaseado de caramelo caliente', 59.60, '../assets/img/postres/torta_de_platano_y_nuez_caramelizada.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id_us` int(11) NOT NULL,
  `nombre_us` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `fech_nacmnto` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id_us`, `nombre_us`, `correo`, `password`, `fech_nacmnto`) VALUES
(1, 'luciana', 'luciana@gmail.com', '251006', '2006-10-25'),
(2, 'maria', 'maria@gmail.com', '12345', '2004-07-22'),
(3, 'juan', 'juan5412@gmail.com', 'juan', '2025-05-29'),
(4, 'Joaquin', 'joaquin@gmail.com', 'femboy', '2005-03-04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_us`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_us` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
