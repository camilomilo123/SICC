-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 14-05-2025 a las 15:49:43
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
-- Base de datos: `u834726681_inventario_sen`
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
  `dependencia` enum('Laboratorio','Deportes','Bienestar','Hospedaje') NOT NULL,
  `responsable` tinytext NOT NULL,
  `insumo` varchar(100) NOT NULL,
  `fecha` datetime NOT NULL,
  `unidad_medida` varchar(50) DEFAULT NULL,
  `cantidad_anterior` decimal(11,2) DEFAULT NULL,
  `cantidad_ingresada` decimal(11,2) DEFAULT NULL,
  `cantidad_total` decimal(11,2) GENERATED ALWAYS AS (`cantidad_anterior` + `cantidad_ingresada`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_bienestar`
--

CREATE TABLE `inventario_bienestar` (
  `id` int(150) NOT NULL,
  `elemento` varchar(250) NOT NULL,
  `cantidad` int(250) NOT NULL,
  `unidad_medida` varchar(250) NOT NULL,
  `ubicacion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_deportes`
--

CREATE TABLE `inventario_deportes` (
  `id` int(11) NOT NULL,
  `elemento` varchar(100) NOT NULL,
  `cantidad` int(250) NOT NULL,
  `unidad_medida` varchar(50) DEFAULT NULL,
  `ubicacion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_hospedaje`
--

CREATE TABLE `inventario_hospedaje` (
  `id` int(250) NOT NULL,
  `insumo` varchar(250) NOT NULL,
  `cantidad` int(250) NOT NULL,
  `unidad_medida` varchar(250) NOT NULL,
  `ubicacion` varchar(250) NOT NULL
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
  `unidad_medida` varchar(50) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `codigo_almacenamiento` varchar(50) DEFAULT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `tipo` enum('entrada','salida') NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `leida` tinyint(1) DEFAULT 0,
  `categoria` varchar(50) NOT NULL DEFAULT 'general'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id` int(11) NOT NULL,
  `dependencia` varchar(50) NOT NULL,
  `insumo` varchar(100) NOT NULL,
  `unidad_medida` varchar(20) NOT NULL,
  `cantidad_prestada` decimal(11,0) NOT NULL,
  `prestado_a` text DEFAULT NULL,
  `fecha` date NOT NULL,
  `responsable` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes_errores`
--

CREATE TABLE `reportes_errores` (
  `id` int(11) NOT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `tipo_reporte` varchar(100) DEFAULT NULL,
  `mensaje` text DEFAULT NULL,
  `nivel` varchar(20) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `navegador` text DEFAULT NULL,
  `sistema` varchar(100) DEFAULT NULL,
  `resolucion` varchar(50) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `solucionado` tinyint(1) DEFAULT 0
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
(1, 'Administrador'),
(2, 'Laboratorio'),
(3, 'Deportes'),
(4, 'Bienestar'),
(5, 'Hospedaje');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salidas`
--

CREATE TABLE `salidas` (
  `dependencia` enum('Laboratorio','Deportes','Bienestar','Hospedaje') NOT NULL,
  `responsable` tinytext NOT NULL,
  `id` int(250) NOT NULL,
  `insumo` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `descripcion` text DEFAULT NULL,
  `unidad_medida` varchar(255) DEFAULT NULL,
  `cantidad_salida` decimal(11,2) NOT NULL,
  `cantidad_total` decimal(11,2) NOT NULL,
  `cantidad_anterior` decimal(10,2) NOT NULL
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
  `role_id` int(11) NOT NULL,
  `contraseña` varchar(150) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expiration` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `telefono`, `correo`, `role_id`, `contraseña`, `reset_token`, `reset_expiration`) VALUES
(1, 'David', '3123021995', 'hayderpalacios87@gmail.com', 1, '$2y$10$iq3lSLVVbU.Op5Th7Z22Hu8L0pSKl4/a27pOapp3aIqzDqP1ynGl2', NULL, NULL),
(2, 'Carlos A', '3208908754', 'andress040406@gmail.com', 1, '$2y$10$wN1j2qLf72joDgqyyFFwcuFSNNLR2pExbBAakf3CZCIbatpBJFE3a', '7cafc0b78962b7b259df902b215f233897d3a01dc0352c7badb894f11ecc099961ab60e2a41389d963f67cbb285c615015e6', '2025-05-05 23:12:31'),
(3, 'Enc. Laboratorio', '3245678976', 'laboratorio@gmail.com', 2, '$2y$10$bMoGFu1qp8vYAJk4fRDluee7PHW0.uBvTm0tQFfQexP2aYLTUuh0K', NULL, NULL),
(4, 'Enc. Deportes', '3214568791', 'deportes@gmail.com', 3, '$2y$10$pB3e2uOXb8FXth2lmKQux.gbLjMg.V4c4kBlMl.NM3F1uXrWc2UiK', NULL, NULL),
(5, 'Enc. Bienestar', '3108909591', 'bienestar@gmail.com', 4, '$2y$10$6F1vWWhBd9Ox9.qTcyyFr.VkOr0h0iPds.9oEYGoU/qOfdmK168mC', NULL, NULL),
(6, 'Enc. Hospedaje', '3203028754', 'hospedaje@gmail.com', 5, '$2y$10$cgM321g97yVxCa7f56VrmOh3OipSuSKbFDCWN.VuLu4wQ1HER4bG6', NULL, NULL),
(7, 'Camilo', '3214127016', 'camiloguti1070@gmail.com', 2, '$2y$10$Vn4GPVRUQ3YIIE.yh3I5cehiSZ.5cuWX38zK8/w2kG6n90Bi31rza', '21ba47bc156f5fae5bff50879ee0df0a7602eb2f208bb02e0ead487dbdde0603d94a6507a25803863f4252eafade5a418cff', '2025-05-06 14:17:56'),
(8, 'Administador', '3214127016', 'administrador@gmail.com', 1, '$2y$10$rGMSgb5/iQWS6jYMeVOQ.eNTlpZmVnYjqCTo0i.3lCn9W75m3VytS', NULL, NULL),
(10, 'Nicol', '3218099115', 'nicol123@gmail.com', 5, '$2y$10$B8v8B9UkRhJIx32cnjhwoutexIrxI06tTt.4fitUzk4XO11hSeRfm', NULL, NULL),
(11, 'SICC', '3156789223', 'siccsena@gmail.com', 1, '$2y$10$TaHbVmLIi9JwpY6MmX6x7epd6n8PQwXL3kGlxJ.r1vyTuMsBetZ4q', NULL, NULL),
(12, 'Pepito', '3156789223', 'pepito@gmail.com', 1, '$2y$10$M/.UXRGiQdDMiAO2WEHSfuq0EVwmsI5iz5E2jC.2n7xqHKxynCqdu', NULL, NULL),
(13, 'prueba', '3214127016', 'prueba@gmail.com', 1, '$2y$10$jpw6oG717.IJJUF4vonGAOYt/rjrIInHXEgupXPQQY6TBUIzzHcpC', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `almacen`
--
ALTER TABLE `almacen`
  ADD PRIMARY KEY (`item`);

--
-- Indices de la tabla `inventario_bienestar`
--
ALTER TABLE `inventario_bienestar`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inventario_deportes`
--
ALTER TABLE `inventario_deportes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inventario_hospedaje`
--
ALTER TABLE `inventario_hospedaje`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inventario_laboratorio`
--
ALTER TABLE `inventario_laboratorio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reportes_errores`
--
ALTER TABLE `reportes_errores`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `fk_usuario_role_idx` (`role_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `almacen`
--
ALTER TABLE `almacen`
  MODIFY `item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `inventario_bienestar`
--
ALTER TABLE `inventario_bienestar`
  MODIFY `id` int(150) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario_deportes`
--
ALTER TABLE `inventario_deportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario_hospedaje`
--
ALTER TABLE `inventario_hospedaje`
  MODIFY `id` int(250) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario_laboratorio`
--
ALTER TABLE `inventario_laboratorio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reportes_errores`
--
ALTER TABLE `reportes_errores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `salidas`
--
ALTER TABLE `salidas`
  MODIFY `id` int(250) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
