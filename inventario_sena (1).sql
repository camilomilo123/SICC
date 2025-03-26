-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 25-03-2025 a las 22:37:59
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
  `dependencia` enum('bienestar','deporte','hospedaje','laboratorio') NOT NULL,
  `responsable` tinytext NOT NULL,
  `insumo` text NOT NULL,
  `fecha` datetime NOT NULL,
  `unidad_medida` enum('unidad','litro','libra','mililitros','kilogramos','gramos','miligramos') NOT NULL,
  `cantidad_anterior` decimal(11,2) DEFAULT NULL,
  `cantidad_ingresada` decimal(11,2) DEFAULT NULL,
  `cantidad_total` decimal(11,2) GENERATED ALWAYS AS (`cantidad_anterior` + `cantidad_ingresada`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entradas`
--

INSERT INTO `entradas` (`id`, `dependencia`, `responsable`, `insumo`, `fecha`, `unidad_medida`, `cantidad_anterior`, `cantidad_ingresada`) VALUES
(14, 'laboratorio', 'samanta', 'Acido Nitrico', '2025-03-25 18:04:43', 'mililitros', 4900.00, 200.00),
(15, 'laboratorio', 'samanta', 'Acido Nitrico', '2025-03-25 18:11:14', 'mililitros', 5100.00, 200.00),
(16, 'laboratorio', 'samanta', 'Acido Nitrico', '2025-03-25 18:14:19', 'mililitros', 5300.00, 200.00),
(17, 'laboratorio', 'samanta', 'Acido Nitrico', '2025-03-25 18:15:03', 'mililitros', 5500.00, 200.00),
(18, 'laboratorio', 'samanta', 'Acido Nitrico', '2025-03-25 18:17:42', 'mililitros', 5700.00, 200.00),
(19, 'laboratorio', 'samanta', 'Cloroformo', '2025-03-25 18:17:54', 'mililitros', 1050.00, 200.00),
(20, 'laboratorio', 'samanta', 'Cloroformo', '2025-03-25 22:14:47', 'mililitros', 1250.00, 200.00);

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
(14, 'Acido Nitrico', 'HNO3', 'Liquido', '2027-11-01', '141222', 'mililitros', 'E2-M5-F1', 'Corrosivo', 5900),
(15, 'Cloroformo', 'CHCI2', 'Liquido', '2024-02-29', 'K53200845110', 'mililitros', 'E2-M3-F2', 'Tóxico', 1450),
(16, 'Acido Acetico', 'C2H4O6', 'Liquido', '2027-01-09', '2053864', 'mililitros', 'E2-M5-F1', 'Corrosivo', 500);

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
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'administrador'),
(2, 'laboratorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salidas`
--

CREATE TABLE `salidas` (
  `dependencia` enum('bienestar','deporte','hospedaje','laboratorio') NOT NULL,
  `responsable` tinytext NOT NULL,
  `id` int(250) NOT NULL,
  `insumo` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `descripcion` text DEFAULT NULL,
  `unidad_medida` enum('unidad','litros','libras','mililitros','kilogramos','gramos','miligramos') NOT NULL,
  `cantidad_salida` decimal(11,2) NOT NULL,
  `cantidad_total` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `salidas`
--

INSERT INTO `salidas` (`dependencia`, `responsable`, `id`, `insumo`, `fecha`, `descripcion`, `unidad_medida`, `cantidad_salida`, `cantidad_total`) VALUES
('laboratorio', 'Arturo', 14, 'Cloroformo', '2025-03-19 04:36:07', 'xqx', 'libras', 0.20, 723.91),
('laboratorio', 'Arturo', 15, 'Acido Nitrico', '2025-03-19 04:36:33', 'xqx', 'litros', 0.20, 99.80),
('laboratorio', 'carlos', 18, 'Acido Nitrico', '2025-03-24 19:45:36', 'xxx', 'mililitros', 200.00, 4700.00),
('laboratorio', 'carlos', 20, 'Acido Nitrico', '2025-03-24 20:01:12', 'practica para el dia de la ciencia', 'mililitros', 200.00, 4500.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `role_id` int(11) NOT NULL,
  `contraseña` varchar(150) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expiration` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `telefono`, `correo`, `role_id`, `contraseña`, `reset_token`, `reset_expiration`) VALUES
(22, 'samanta', '3214127016', 'samata23@gmail.com', 1, '$2y$10$Nld4dHFnvnanBKEX1Hn1h.A06kCMBp5rUMwCD3zPiyyCrpSxly5w2', NULL, NULL),
(25, 'carlos', '3214127016', 'carlos1234@gmail.com', 2, '$2y$10$ojXOr8AlzUnXXqSDx4EPeeDWWFcHOkoXHulyshAPHawPDw1vyTZAW', NULL, NULL),
(81, 'David', '3123021995', 'hayderpalacios@gmail.com', 1, '$2y$10$h0p/eJHIWQuqfzhyVam1g.CHVjD1hqTpDW9s5h10jA4aswCav.Uky', NULL, NULL),
(89, 'Palacios', '3123021995', 'palacios@gmail.com', 2, '$2y$10$m8RjSToamFerZULNRS4EhOwOVwueTZkHmCjAUtD6yqPfH6XgePfYu', NULL, NULL),
(90, 'Carlos A', '3208908754', 'andress040406@gmail.com', 1, '$2y$10$K/rEZRVG/fwRcBHANoy6kO3wTSSVKk991CNQX2dFpZCvN5iy/RnlK', NULL, NULL),
(92, 'Arturo', '3208908755', 'carlosarturog@gmail.com', 2, '$2y$10$NUqhJqITN58XTQOaYUNJAOVtQym6A.EpFS81VoktVAyiVyNGVcZaa', NULL, NULL),
(93, 'emilio', '3214127016', 'emilio123@gmail.com', 1, '$2y$10$4.yULtOlhbrTPAiKq9/EcO2YEGet1wTPHJDq/zDxd42DgegcO4o86', NULL, NULL),
(94, 'cordoba', '3214127016', 'cordoba123@gmail.com', 1, '$2y$10$O3cPHEfYntrdfYa9.vhUauoZyBuZVSiCKcH70JM5TSgqd2jRpcnwu', NULL, NULL),
(95, 'hhh', '3214127016', 'hhhh123@gmail.com', 1, '$2y$10$fD/IOV39w4WL0.L313dOY.No8pesW95IdytGpFXff8bDmn1COu/kG', NULL, NULL),
(96, 'rrr', '3218099115', 'rrr13@gmail.com', 1, '$2y$10$a3.TIfd8Vsd3T0raUGGrTeIC5J0hhGfMOJzPsrAqVDverkQWYiSIK', NULL, NULL),
(97, 'fff', '3158980511', 'fff123@gmail.com', 1, '$2y$10$l0jFmg4gnIiz3uIPXaz1G.ybsUxCqZczZ71m/tl8sAeQFDLFPDwIG', NULL, NULL);

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
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `salidas`
--
ALTER TABLE `salidas`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `salidas`
--
ALTER TABLE `salidas`
  MODIFY `id` int(250) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
