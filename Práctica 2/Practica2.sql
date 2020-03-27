-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 25-03-2020 a las 02:24:18
-- Versión del servidor: 8.0.19-0ubuntu0.19.10.3
-- Versión de PHP: 7.3.11-0ubuntu0.19.10.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Practica2`
--

USE `ic18rgp`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `FacturacionDelMes` (`idClienteFacturacion` INT, `mesFacturacion` CHAR(50), OUT `facturacion` DECIMAL(8,2))  BEGIN
	DECLARE cursorFacturacion CURSOR FOR
		SELECT SUM(precio) FROM Clientes LEFT JOIN Compras USING(idCliente) LEFT JOIN ComprasProductos USING (idCompra) LEFT JOIN Productos USING (idProducto) WHERE idCliente = idClienteFacturacion AND MONTHNAME (fechaCompra) = mesFacturacion;
	OPEN cursorFacturacion;
		FETCH cursorFacturacion INTO facturacion;
    CLOSE cursorFacturacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Monto_Total_y_Envio` (`cliente` INT, `producto` INT, `numProductos` INT, OUT `montoTotal` DECIMAL(10,2), OUT `montoEnvio` DECIMAL(10,2))  BEGIN
 DECLARE costoProducto DECIMAL(10,2);
 DECLARE categoriaCliente VARCHAR(50);
 DECLARE curPrecioProducto CURSOR FOR
  SELECT precio FROM Productos WHERE idProducto = producto;
DECLARE curCategoriaCliente CURSOR FOR
  SELECT nombreCategoriaCliente, porcentajeEnvio FROM Clientes LEFT JOIN CategoriaClientes USING(idCategoriaCliente) WHERE idCliente = cliente;
DECLARE EXIT HANDLER FOR NOT FOUND SET montoTotal = 0; SET montoEnvio = 0;
OPEN curPrecioProducto;
  FETCH curPrecioProducto INTO costoProducto;
CLOSE curPrecioProducto;

OPEN curCategoriaCliente;
  FETCH curCategoriaCliente INTO categoriaCliente, montoEnvio;
CLOSE curCategoriaCliente;

SET montoTotal = costoProducto * numProductos;

SET montoEnvio = montoTotal * montoEnvio;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ProductosEnCategoria` (`categoria` CHAR(50))  BEGIN
	SELECT nombre, descripcion, COUNT(idOpinion) AS Cuantos_Comentarios FROM CategoriaProductos RIGHT JOIN Productos USING(idCategoriaProducto) LEFT JOIN Opiniones USING(idProducto) WHERE nombreCategoriaProducto = categoria GROUP BY idProducto;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Administradores`
--

CREATE TABLE `Administradores` (
  `idAdministrador` int NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `nombreAdministrador` varchar(50) NOT NULL,
  `aPaternoAdministrador` varchar(50) NOT NULL,
  `aMaternoAdministrador` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Administradores`
--

INSERT INTO `Administradores` (`idAdministrador`, `usuario`, `password`, `nombreAdministrador`, `aPaternoAdministrador`, `aMaternoAdministrador`) VALUES
(1, 'raulgp', '00000006', 'Raúl', 'González', 'Portillo'),
(2, 'cesar', '123', 'César Mauricio', 'Arellano', 'Velázquez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Asesores`
--

CREATE TABLE `Asesores` (
  `idAsesor` int NOT NULL,
  `nombreAsesor` varchar(45) NOT NULL,
  `aPaternoAsesor` varchar(45) DEFAULT NULL,
  `aMaternoAsesor` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Asesores`
--

INSERT INTO `Asesores` (`idAsesor`, `nombreAsesor`, `aPaternoAsesor`, `aMaternoAsesor`) VALUES
(1, 'Daniel', 'Gómez', 'Flores'),
(2, 'Carlos', 'Cruz', 'Ramírez'),
(3, 'Jorge', 'Sánchez', 'Rodríguez'),
(4, 'Josefina', 'Hernández', 'Hernández');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CategoriaClientes`
--

CREATE TABLE `CategoriaClientes` (
  `idCategoriaCliente` int NOT NULL,
  `nombreCategoriaCliente` varchar(45) NOT NULL,
  `porcentajeEnvio` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `CategoriaClientes`
--

INSERT INTO `CategoriaClientes` (`idCategoriaCliente`, `nombreCategoriaCliente`, `porcentajeEnvio`) VALUES
(1, 'Novato', '0.20'),
(2, 'Principiante', '0.15'),
(3, 'Intermedio', '0.10'),
(4, 'Avanzado', '0.05'),
(5, 'Entusiasta', '0.02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CategoriaProductos`
--

CREATE TABLE `CategoriaProductos` (
  `idCategoriaProducto` int NOT NULL,
  `nombreCategoriaProducto` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `CategoriaProductos`
--

INSERT INTO `CategoriaProductos` (`idCategoriaProducto`, `nombreCategoriaProducto`) VALUES
(1, 'Accesorios de electrónica'),
(2, 'Celulares'),
(3, 'Cocina'),
(4, 'Baño');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Clientes`
--

CREATE TABLE `Clientes` (
  `idCliente` int NOT NULL,
  `idCategoriaCliente` int NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `nombreCliente` varchar(45) NOT NULL,
  `aPaternoCliente` varchar(45) NOT NULL,
  `aMaternoCliente` varchar(45) NOT NULL,
  `rfc` varchar(13) NOT NULL,
  `direccionEnvio` varchar(150) NOT NULL,
  `direccionFacturacion` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Clientes`
--

INSERT INTO `Clientes` (`idCliente`, `idCategoriaCliente`, `usuario`, `password`, `nombreCliente`, `aPaternoCliente`, `aMaternoCliente`, `rfc`, `direccionEnvio`, `direccionFacturacion`) VALUES
(1, 1, 'sofiahg', '00000001', 'Sofía', 'Hernández', 'García', 'HEGS750809IS1', 'Calle Guillermo Gonzalez Camarena 450, Santa Fe, Zedec Sta Fé, Álvaro Obregón, 01219 Ciudad de México, CDMX ', 'Calle Guillermo Gonzalez Camarena 450, Santa Fe, Zedec Sta Fé, Álvaro Obregón, 01219 Ciudad de México, CDMX '),
(2, 2, 'joseml', '00000002', 'José', 'Martínez', 'López', 'MALJ900221NW9', 'Albert Einstein 104-81, Santa Fe, Paseo de las Lomas, Álvaro Obregón, 01330 Ciudad de México, CDMX', 'Albert Einstein 104-81, Santa Fe, Paseo de las Lomas, Álvaro Obregón, 01330 Ciudad de México, CDMX'),
(3, 3, 'camilagp', '00000003', 'Camila', 'González', 'Pérez', 'GOPC4203253C9', 'Vasco de Quiroga 2000, Santa Fe, Zedec Sta Fé, Álvaro Obregón, 01219 Ciudad de México, CDMX', 'Vasco de Quiroga 2000, Santa Fe, Zedec Sta Fé, Álvaro Obregón, 01219 Ciudad de México, CDMX'),
(4, 4, 'miguelrs', '00000004', 'Miguel', 'Rodríguez', 'Sánchez', 'ROSM961110RM7', 'Cda. Palo Alto MZ4 LT10, Granjas Palo Alto, Cuajimalpa de Morelos, 05110 Ciudad de México, CDMX', 'Cda. Palo Alto MZ4 LT10, Granjas Palo Alto, Cuajimalpa de Morelos, 05110 Ciudad de México, CDMX'),
(5, 5, 'valentinarc', '00000005', 'Valentina', 'Ramírez', 'Cruz', 'RACV600205I88', 'Cedro 20, El Olivo, 52789 Naucalpan de Juárez, Méx.', 'Cedro 20, El Olivo, 52789 Naucalpan de Juárez, Méx.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Compras`
--

CREATE TABLE `Compras` (
  `idCompra` int NOT NULL,
  `idCliente` int DEFAULT NULL,
  `formaPago` enum('Tarjeta de crédito','Depósito bancario','Transferencia electrónica','Pago en tienda de conveniencia') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fechaCompra` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Compras`
--

INSERT INTO `Compras` (`idCompra`, `idCliente`, `formaPago`, `fechaCompra`) VALUES
(1, 1, 'Tarjeta de crédito', '2019-11-03 10:21:39'),
(2, 2, 'Depósito bancario', '2019-05-25 05:46:21'),
(3, 3, 'Transferencia electrónica', '2019-02-16 19:48:59'),
(4, 1, 'Pago en tienda de conveniencia', '2019-02-19 13:19:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ComprasProductos`
--

CREATE TABLE `ComprasProductos` (
  `idCompra` int NOT NULL,
  `idProducto` int NOT NULL,
  `cantidadProducto` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ComprasProductos`
--

INSERT INTO `ComprasProductos` (`idCompra`, `idProducto`, `cantidadProducto`) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 4, 1),
(3, 5, 1),
(3, 6, 4),
(3, 7, 1),
(4, 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Departamentos`
--

CREATE TABLE `Departamentos` (
  `idDepartamento` int NOT NULL,
  `nombreDepartamento` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Departamentos`
--

INSERT INTO `Departamentos` (`idDepartamento`, `nombreDepartamento`) VALUES
(1, 'Electrónicos'),
(2, 'Hogar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DevolucionesCancelaciones`
--

CREATE TABLE `DevolucionesCancelaciones` (
  `idCaso` int NOT NULL,
  `idProducto` int NOT NULL,
  `idCompra` int NOT NULL,
  `tipo` enum('Cancelacion','Devolucion') NOT NULL,
  `cantidadDC` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `DevolucionesCancelaciones`
--

INSERT INTO `DevolucionesCancelaciones` (`idCaso`, `idProducto`, `idCompra`, `tipo`, `cantidadDC`) VALUES
(1, 4, 2, 'Devolucion', 1),
(2, 7, 3, 'Devolucion', 1),
(3, 4, 4, 'Cancelacion', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HistorialAtencion`
--

CREATE TABLE `HistorialAtencion` (
  `idAtencion` int NOT NULL,
  `idAsesor` int NOT NULL,
  `idCliente` int NOT NULL,
  `estado` enum('Abierto','Cerrado') NOT NULL,
  `comentarios` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `HistorialAtencion`
--

INSERT INTO `HistorialAtencion` (`idAtencion`, `idAsesor`, `idCliente`, `estado`, `comentarios`) VALUES
(1, 1, 1, 'Abierto', 'Requiere cambiar su dirección.'),
(2, 2, 2, 'Cerrado', 'No podía ingresar al sistema, se restableció su contraseña.'),
(3, 3, 3, 'Abierto', 'No puede agregar una tarjeta.'),
(4, 4, 4, 'Cerrado', 'Su nombre estaba mal ingresado, se corrijió.'),
(5, 1, 5, 'Abierto', 'No le llegó un producto.'),
(8, 2, 1, 'Cerrado', 'No abría el sitio web en su dispositivo móvil, se restauró la configuración de red del terminal y se resolvió el problema.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Opiniones`
--

CREATE TABLE `Opiniones` (
  `idOpinion` int NOT NULL,
  `idCliente` int NOT NULL,
  `idProducto` int NOT NULL,
  `calificacion` int NOT NULL,
  `comentario` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Opiniones`
--

INSERT INTO `Opiniones` (`idOpinion`, `idCliente`, `idProducto`, `calificacion`, `comentario`) VALUES
(1, 2, 3, 9, 'Buena pantalla, rendimiento y cámaras. El Software podría estar mejor.'),
(2, 3, 5, 8, 'Tiene buen aspecto y materiales de construcción, pero calienta lento en comparación con otras cafeteras.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Productos`
--

CREATE TABLE `Productos` (
  `idProducto` int NOT NULL,
  `idDepartamento` int NOT NULL,
  `idCategoriaProducto` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `marca` varchar(45) NOT NULL,
  `descripcion` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Productos`
--

INSERT INTO `Productos` (`idProducto`, `idDepartamento`, `idCategoriaProducto`, `nombre`, `marca`, `descripcion`, `precio`, `stock`) VALUES
(1, 1, 1, 'Redmi Airdots', 'Xiaomi', '- Compatibles con Bluetooth 5.0\r\n- Tecnología True Wireless, como en los Airdots Pro, para una conexión super rápida.\r\n- Estuche cargador con entrada microusb y batería de 300mAh, tus audífonos se cargan mientras están guardados en su estuche.\r\n- Hasta 4 horas de uso continuo, con batería de 40mAh.\r\n- Muy ligeros, con peso de 4g.\r\n', '447.00', 50),
(2, 1, 1, 'Tarjeta microSDXC con adaptador de 128GB', 'ADATA', '- Código de proveedor RAM-3040\r\n- UHS-I\r\n- Clase 10 A1\r\n- Velocidad de transferencia de 85Mb/s', '325.00', 50),
(3, 1, 2, 'Redmi Note 8', 'Xiaomi', '- Pantalla: Grande 6,3 pulgadas, 1080 x 2340 píxeles\r\n- Chipset: Qualcomm SDM665 Snapdragon 665, hasta 2.0Ghz\r\n- Sistema: Android 9.0 (Pie) Con MIUI 10\r\n- Cámara: 13MP cámara selfie, 48MP 8MP 2MP 2MP cámaras quad traseras\r\n- Batería: batería de gran capacidad 4000mAh, viene con cargador rápido de 18W', '3779.00', 50),
(4, 1, 2, 'P30 Lite', 'Huawuei', '- Tamaño de la pantalla: 6.15 pulgadas\r\n- MicroSD expandible a 256 GB\r\n- Parlantes stereo\r\n- Tipo de batería: Batería de polímero de litio\r\n- Sistema operativo: EMUI 9.0 (Basado en Android 9)', '4746.00', 50),
(5, 2, 3, 'Cafetera de 4 tazas', 'Oster', '- Luz indicadora de encendido y apagado permite saber si la cafetera está encendida o apagada, lo que ofrece un punto de seguridad importante.\r\n- Filtro permanente y la canasta removible facilita su llenado y limpieza.\r\n- La función de pausa para servir permite servir café durante el proceso de colado.\r\n- Las ventanillas dobles muestran la cantidad de agua que se encuentra en el tanque para llenarlo con precisión.\r\n- El espacio para almacenar el cable permite guardar el excedente de forma segura para mantener el mostrador organizado.', '165.00', 50),
(6, 2, 3, 'Termo de acero inoxidable de 473ml', 'Contigo', '- Botón AutoSeal negro, apto para lavado en rejilla superior de lavaplatos, cuerpo lavado a mano; libre de BPA.\r\n- Tecnología de aislamiento al vacío que mantiene el calor de tus bebidas por hasta 5 horas y el frío por hasta 12 horas.\r\n- Se ajusta debajo de la mayoría de las máquinas de café para servicio individual y en la mayoría de los portavasos de automóviles.\r\n- La tapa AutoSeal patentada se sella automáticamente entre sorbos para evitar derrames y goteo.', '321.00', 50),
(7, 2, 4, 'Toalla deportiva de microfibra de 80 x 160cm', 'Sharx', '- Las Mejores Toallas de Microfibra ahora en México.\r\n- Usa Sharx para: Natación, Gym, Correr, Box, Bici, CrossFit, Trekking, Hiking, Yoga, Tenis, Squash, Racquet, Golf, Kayak, Velero, Surf, Rafting, Motos, Coches, Volley, Beis, Fut, Basket, Patinaje, Excursiones, Días de Campo, Playa, Alberca o en tu Casa después de bañarte.\r\n- Sharx es el producto indispensable para todos los que practicamos un deporte ya sea a nivel profesional, amateur o simplemente como diversión.\r\n- Nuestra Toallas son: 3 veces más Ligeras que una Toalla de Algodón. 6 veces más compactas que una Toalla de Algodón. Absorben 3 veces su peso en Agua. Se secan 3 veces más rapido que una Toalla de Algodón. Mucho más atractivas que una Toalla de Algodón. 16 modelos diferentes. ', '369.00', 50),
(8, 2, 4, 'Organizador de maquillaje rotador', 'JSBelle', '- ORGANIZADOR DE ROTACIÓN DE 360 °: organiza y almacena perfectamente sus cosméticos; permite un fácil acceso a todos tus productos y maquillaje.\r\n- GRAN CAPACIDAD: Acomoda al menos 30 pinceles de maquillaje, 20 botellas de productos para el cuidado de la piel y otros accesorios de maquillaje.\r\n- 7 CAPAS AJUSTABLES: le permiten ajustar la altura de la bandeja para adaptarse a diferentes tipos de cosméticos y envases.\r\n- FÁCIL DE ENSAMBLAR Y LAVAR: monte y desarme rápidamente el organizador siguiendo la guía.\r\n- Paquete incluido: 1 x organizador de Cosméticos, guía de instalación', '499.00', 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TarjetasClientes`
--

CREATE TABLE `TarjetasClientes` (
  `idTarjeta` int NOT NULL,
  `idCliente` int NOT NULL,
  `numeroTarjeta` varchar(16) NOT NULL,
  `tipoTarjeta` enum('Credito','Debito') NOT NULL,
  `mesCaducidad` varchar(2) DEFAULT NULL,
  `anioCaducidad` varchar(4) DEFAULT NULL,
  `nombreTarjetaHabiente` varchar(150) NOT NULL,
  `institucionFinanciera` enum('American Express','Mastercard','Visa') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `TarjetasClientes`
--

INSERT INTO `TarjetasClientes` (`idTarjeta`, `idCliente`, `numeroTarjeta`, `tipoTarjeta`, `mesCaducidad`, `anioCaducidad`, `nombreTarjetaHabiente`, `institucionFinanciera`) VALUES
(1, 1, '1000200030004000', 'Credito', '09', '2022', 'Sofía Hernández García', 'American Express'),
(2, 2, '5000600070008000', 'Debito', '03', '2022', 'José Martínez López', 'Mastercard');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Administradores`
--
ALTER TABLE `Administradores`
  ADD PRIMARY KEY (`idAdministrador`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- Indices de la tabla `Asesores`
--
ALTER TABLE `Asesores`
  ADD PRIMARY KEY (`idAsesor`);

--
-- Indices de la tabla `CategoriaClientes`
--
ALTER TABLE `CategoriaClientes`
  ADD PRIMARY KEY (`idCategoriaCliente`);

--
-- Indices de la tabla `CategoriaProductos`
--
ALTER TABLE `CategoriaProductos`
  ADD PRIMARY KEY (`idCategoriaProducto`);

--
-- Indices de la tabla `Clientes`
--
ALTER TABLE `Clientes`
  ADD PRIMARY KEY (`idCliente`),
  ADD UNIQUE KEY `usuario_UNIQUE` (`usuario`),
  ADD KEY `ID Categoria Cliente_idx` (`idCategoriaCliente`);

--
-- Indices de la tabla `Compras`
--
ALTER TABLE `Compras`
  ADD PRIMARY KEY (`idCompra`),
  ADD KEY `idCliente_idx` (`idCliente`);

--
-- Indices de la tabla `ComprasProductos`
--
ALTER TABLE `ComprasProductos`
  ADD PRIMARY KEY (`idCompra`,`idProducto`),
  ADD KEY `ID Producto_idx` (`idProducto`);

--
-- Indices de la tabla `Departamentos`
--
ALTER TABLE `Departamentos`
  ADD PRIMARY KEY (`idDepartamento`);

--
-- Indices de la tabla `DevolucionesCancelaciones`
--
ALTER TABLE `DevolucionesCancelaciones`
  ADD PRIMARY KEY (`idCaso`),
  ADD KEY `ID Producto_idx` (`idProducto`),
  ADD KEY `ID Compra_idx` (`idCompra`);

--
-- Indices de la tabla `HistorialAtencion`
--
ALTER TABLE `HistorialAtencion`
  ADD PRIMARY KEY (`idAtencion`),
  ADD KEY `ID Cliente_idx` (`idCliente`),
  ADD KEY `ID Asesor HistorialAtencion_idx` (`idAsesor`);

--
-- Indices de la tabla `Opiniones`
--
ALTER TABLE `Opiniones`
  ADD PRIMARY KEY (`idOpinion`),
  ADD KEY `ID Cliente_idx` (`idCliente`),
  ADD KEY `ID Producto_idx` (`idProducto`);

--
-- Indices de la tabla `Productos`
--
ALTER TABLE `Productos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `ID Departamento_idx` (`idDepartamento`),
  ADD KEY `ID Categoria Producto_idx` (`idCategoriaProducto`);

--
-- Indices de la tabla `TarjetasClientes`
--
ALTER TABLE `TarjetasClientes`
  ADD PRIMARY KEY (`idTarjeta`),
  ADD KEY `ID Cliente_idx` (`idCliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Administradores`
--
ALTER TABLE `Administradores`
  MODIFY `idAdministrador` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `Asesores`
--
ALTER TABLE `Asesores`
  MODIFY `idAsesor` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `CategoriaClientes`
--
ALTER TABLE `CategoriaClientes`
  MODIFY `idCategoriaCliente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `CategoriaProductos`
--
ALTER TABLE `CategoriaProductos`
  MODIFY `idCategoriaProducto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `Clientes`
--
ALTER TABLE `Clientes`
  MODIFY `idCliente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `Compras`
--
ALTER TABLE `Compras`
  MODIFY `idCompra` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `Departamentos`
--
ALTER TABLE `Departamentos`
  MODIFY `idDepartamento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `DevolucionesCancelaciones`
--
ALTER TABLE `DevolucionesCancelaciones`
  MODIFY `idCaso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `HistorialAtencion`
--
ALTER TABLE `HistorialAtencion`
  MODIFY `idAtencion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `Opiniones`
--
ALTER TABLE `Opiniones`
  MODIFY `idOpinion` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `Productos`
--
ALTER TABLE `Productos`
  MODIFY `idProducto` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT de la tabla `TarjetasClientes`
--
ALTER TABLE `TarjetasClientes`
  MODIFY `idTarjeta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Clientes`
--
ALTER TABLE `Clientes`
  ADD CONSTRAINT `ID Categoria Clientes` FOREIGN KEY (`idCategoriaCliente`) REFERENCES `CategoriaClientes` (`idCategoriaCliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Compras`
--
ALTER TABLE `Compras`
  ADD CONSTRAINT `idCliente Compras` FOREIGN KEY (`idCliente`) REFERENCES `Clientes` (`idCliente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `ComprasProductos`
--
ALTER TABLE `ComprasProductos`
  ADD CONSTRAINT `ID Compra ComprasProductos` FOREIGN KEY (`idCompra`) REFERENCES `Compras` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ID Producto ComprasProductos` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `DevolucionesCancelaciones`
--
ALTER TABLE `DevolucionesCancelaciones`
  ADD CONSTRAINT `ID Compra DevolucionesCancelaciones` FOREIGN KEY (`idCompra`) REFERENCES `Compras` (`idCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ID Producto DevolucionesCancelaciones` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `HistorialAtencion`
--
ALTER TABLE `HistorialAtencion`
  ADD CONSTRAINT `ID Asesor HistorialAtencion` FOREIGN KEY (`idAsesor`) REFERENCES `Asesores` (`idAsesor`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ID Cliente HistorialAtencion` FOREIGN KEY (`idCliente`) REFERENCES `Clientes` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Opiniones`
--
ALTER TABLE `Opiniones`
  ADD CONSTRAINT `ID Cliente Opiniones` FOREIGN KEY (`idCliente`) REFERENCES `Clientes` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ID Producto Opiniones` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `Productos`
--
ALTER TABLE `Productos`
  ADD CONSTRAINT `ID CategoriaProducto Productos` FOREIGN KEY (`idCategoriaProducto`) REFERENCES `CategoriaProductos` (`idCategoriaProducto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ID Departamento Productos` FOREIGN KEY (`idDepartamento`) REFERENCES `Departamentos` (`idDepartamento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `TarjetasClientes`
--
ALTER TABLE `TarjetasClientes`
  ADD CONSTRAINT `ID Cliente TarjetasClientes` FOREIGN KEY (`idCliente`) REFERENCES `Clientes` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
