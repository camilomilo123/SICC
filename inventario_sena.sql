-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 06-02-2025 a las 17:35:38
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario_sena`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `almacen`
--

CREATE TABLE `almacen` (
  `item` int(11) NOT NULL,
  `consecutivo` int(11) NOT NULL,
  `producto` text NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `unidad_medida` varchar(250) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `ubicacion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas`
--

CREATE TABLE `entradas` (
  `id` int(11) NOT NULL,
  `inventario_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `unidad_medida` varchar(50) NOT NULL,
  `cantidad_anterior` int(11) DEFAULT NULL,
  `cantidad_ingresada` int(11) DEFAULT NULL,
  `cantidad_total` int(11) GENERATED ALWAYS AS (`cantidad_anterior` + `cantidad_ingresada`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entradas`
--

INSERT INTO `entradas` (`id`, `inventario_id`, `nombre`, `fecha`, `unidad_medida`, `cantidad_anterior`, `cantidad_ingresada`) VALUES
(47, 1, 'Ácido Acético >99.8%', '2025-01-29', 'ml', 0, 2),
(56, 2, 'acetaminofen ', '2025-02-03', 'kg', 0, 200),
(58, 2, 'acetaminofen ', '2025-02-03', 'ml', 200, 200),
(59, 2, 'dolex', '2025-02-04', 'ml', 600, 200);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `item` int(11) NOT NULL,
  `producto` text NOT NULL,
  `descripcion` text NOT NULL,
  `consecutivo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `unidad_medida` text NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `item` int(11) NOT NULL,
  `producto` text NOT NULL,
  `categoria` enum('bienestar','deporte','hospedaje','laboratorio') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `unidad_medida` text NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_laboratorio`
--

CREATE TABLE `inventario_laboratorio` (
  `id` int(11) NOT NULL,
  `reactivo` varchar(100) NOT NULL,
  `formula` varchar(100) DEFAULT NULL,
  `estado` varchar(50) NOT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `lote` varchar(50) DEFAULT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `codigo_almacenamiento` varchar(50) DEFAULT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_laboratorio`
--

INSERT INTO `inventario_laboratorio` (`id`, `reactivo`, `formula`, `estado`, `fecha_vencimiento`, `lote`, `unidad_medida`, `ubicacion`, `codigo_almacenamiento`, `cantidad`) VALUES
(1, 'acido', 'ssas', 'sss', '2025-02-08', 'www', 'cm', 'sasaima', 'sdd', 2),
(2, 'dolex', 'ss', 'ss', '2025-02-14', 'sws', 'swsw', 'sss', 'sws', 800),
(3, 'speed', 'chontadurio', 'guarana', '2025-02-05', 'xxx', 'mililitros', 'chena', 'frio', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inven_bienestar`
--

CREATE TABLE `inven_bienestar` (
  `item` int(11) NOT NULL,
  `producto` text NOT NULL,
  `cantidad` int(11) NOT NULL,
  `unidad_medida` text NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inven_deporte`
--

CREATE TABLE `inven_deporte` (
  `item` int(11) NOT NULL,
  `producto` text NOT NULL,
  `cantidad` int(11) NOT NULL,
  `unidad_medida` text NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inven_hospedaje`
--

CREATE TABLE `inven_hospedaje` (
  `item` int(11) NOT NULL,
  `producto` text NOT NULL,
  `cantidad` int(11) NOT NULL,
  `unidad_medida` text NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `tipo_movimiento` enum('ingreso','salida') NOT NULL,
  `cantidad` int(11) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `movimientos`
--

INSERT INTO `movimientos` (`id`, `producto_id`, `tipo_movimiento`, `cantidad`, `fecha`) VALUES
(9, 65, 'salida', 200, '2025-02-05 05:05:13'),
(10, 65, 'salida', 1000, '2025-02-05 05:06:03'),
(11, 65, 'salida', 900, '2025-02-05 05:11:18'),
(12, 65, 'salida', 900, '2025-02-05 05:11:21'),
(13, 65, 'salida', 900, '2025-02-05 05:12:03'),
(14, 65, 'salida', 10, '2025-02-05 05:14:43'),
(15, 65, 'salida', 10, '2025-02-05 05:14:57'),
(16, 65, 'salida', 10, '2025-02-05 05:16:56'),
(17, 65, 'salida', 10, '2025-02-05 05:17:06'),
(18, 65, 'salida', 10, '2025-02-05 05:19:33'),
(19, 65, 'salida', 10, '2025-02-05 05:19:50'),
(20, 65, 'salida', 1, '2025-02-05 05:23:15'),
(21, 65, 'salida', 1, '2025-02-05 05:23:22'),
(22, 65, 'salida', 1, '2025-02-05 05:24:25'),
(23, 65, 'salida', 3, '2025-02-05 05:25:45'),
(24, 65, 'salida', 4, '2025-02-05 05:31:28'),
(25, 65, 'salida', 1, '2025-02-05 05:31:57'),
(26, 65, 'salida', 1, '2025-02-05 05:35:53'),
(27, 65, 'salida', 8, '2025-02-05 05:38:01'),
(28, 65, 'salida', 2, '2025-02-05 05:52:54'),
(29, 65, 'salida', 1, '2025-02-05 05:54:13'),
(30, 65, 'salida', 1, '2025-02-05 05:55:10'),
(31, 65, 'salida', 1, '2025-02-05 05:56:06'),
(32, 65, 'salida', 2, '2025-02-05 05:56:46'),
(33, 65, 'salida', 2, '2025-02-05 05:59:12'),
(34, 65, 'salida', 1, '2025-02-05 06:03:57'),
(35, 65, 'salida', 1, '2025-02-05 06:04:00'),
(36, 65, 'salida', 1, '2025-02-05 06:04:18'),
(37, 65, 'salida', 1, '2025-02-05 06:05:47'),
(38, 65, 'salida', 1, '2025-02-05 06:07:22'),
(39, 65, 'salida', 5, '2025-02-05 06:07:37'),
(40, 65, 'salida', 1, '2025-02-05 06:13:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida`
--

CREATE TABLE `salida` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `descripcion` text NOT NULL,
  `consecutivo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `unidad_medida` text NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `contraseña` varchar(150) NOT NULL,
  `cargo_id` varchar(11) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expiration` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `telefono`, `correo`, `contraseña`, `cargo_id`, `reset_token`, `reset_expiration`) VALUES
(3, 'andres', '3208908754', 'andress040406@gmail.com', '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', 'Lab5678', NULL, NULL),
(4, 'camilo', '3214127016', 'camiloguti1070@gmail.com', 'd19bace186ae9909f2ec15fbcb4f614051ee185e2584987bcf7cbff49f2a36be4805d513b8268b79e233cff398594efae504bfcde1bc7809ac13f75619e9d469', 'Lab5678', NULL, NULL),
(5, 'nicol', '3214127016', 'edwarnicolgixxwe@gmail.com', '196795a8134c7a17fa0a8532df4178273651b1d686dcdc5afd0adef93e72f7f3db442268b73d8091a5d585e6ac879eb2d883c68caa1c24102872b622cc35edbc', 'Lab5678', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD PRIMARY KEY (`item`);

--
-- Indices de la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventario_id` (`inventario_id`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`item`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`item`);

--
-- Indices de la tabla `inventario_laboratorio`
--
ALTER TABLE `inventario_laboratorio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inven_bienestar`
--
ALTER TABLE `inven_bienestar`
  ADD PRIMARY KEY (`item`);

--
-- Indices de la tabla `inven_deporte`
--
ALTER TABLE `inven_deporte`
  ADD PRIMARY KEY (`item`);

--
-- Indices de la tabla `inven_hospedaje`
--
ALTER TABLE `inven_hospedaje`
  ADD PRIMARY KEY (`item`);

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `salida`
--
ALTER TABLE `salida`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacen`
--
ALTER TABLE `almacen`
  MODIFY `item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `entradas`
--
ALTER TABLE `entradas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario_laboratorio`
--
ALTER TABLE `inventario_laboratorio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `inven_bienestar`
--
ALTER TABLE `inven_bienestar`
  MODIFY `item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inven_deporte`
--
ALTER TABLE `inven_deporte`
  MODIFY `item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inven_hospedaje`
--
ALTER TABLE `inven_hospedaje`
  MODIFY `item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `salida`
--
ALTER TABLE `salida`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD CONSTRAINT `entradas_ibfk_1` FOREIGN KEY (`inventario_id`) REFERENCES `inventario_laboratorio` (`id`);

--
-- Filtros para la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD CONSTRAINT `movimientos_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `inven_laboratorio` (`item`) ON DELETE CASCADE;

--
-- Filtros para la tabla `salida`
--
ALTER TABLE `salida`
  ADD CONSTRAINT `salida_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `inven_laboratorio` (`item`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
