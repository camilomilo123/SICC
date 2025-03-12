-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-03-2025 a las 22:02:52
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

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
  `dependencia` enum('bienestar','deporte','hospedaje','laboratorio') NOT NULL,
  `responsable` tinytext NOT NULL,
  `id` int(250) NOT NULL,
  `insumo` text NOT NULL,
  `fecha` datetime NOT NULL,
  `unidad_medida` enum('unidad','litro','mililitros','kilogramos','gramos','miligramos') NOT NULL,
  `cantidad_anterior` int(11) DEFAULT NULL,
  `cantidad_ingresada` int(11) DEFAULT NULL,
  `cantidad_total` int(11) GENERATED ALWAYS AS (`cantidad_anterior` + `cantidad_ingresada`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entradas`
--

INSERT INTO `entradas` (`dependencia`, `responsable`, `id`, `insumo`, `fecha`, `unidad_medida`, `cantidad_anterior`, `cantidad_ingresada`) VALUES
('laboratorio', '', 1, 'Noxpirin', '2025-03-04 17:54:35', 'unidad', 1200, 100),
('laboratorio', '', 2, 'dolex', '2025-03-04 19:05:40', 'unidad', 1300, 100),
('laboratorio', '', 3, 'Noxpirin', '2025-03-04 19:10:36', 'unidad', 1300, 50),
('laboratorio', '', 4, 'Noxpirin', '2025-03-04 20:34:17', 'unidad', 1350, 50),
('laboratorio', '', 5, 'dolex', '2025-03-04 20:44:47', 'unidad', 1400, 50),
('laboratorio', '', 6, 'Cloroformo', '2025-03-04 21:26:18', 'unidad', 1000, 100),
('laboratorio', '', 8, 'Acido Nitrico', '2025-03-05 22:22:45', 'mililitros', 5000, 150),
('laboratorio', '', 9, 'Acido Nitrico', '2025-03-05 22:31:24', 'mililitros', 5150, 50),
('laboratorio', '', 10, 'Acido Nitrico', '2025-03-11 16:43:11', 'mililitros', 5200, 100),
('laboratorio', '', 11, 'Acido Acetico', '2025-03-11 21:02:56', 'mililitros', 2176, 24),
('laboratorio', '', 12, 'Acido Nitrico', '2025-03-11 21:22:14', 'mililitros', 5300, 50);

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
(8, 'Acido Nitrico', 'HNO3', 'Liquido', '2027-11-01', '141222', 'mililitro', 'E2-M5-F1', 'Corrosivo', 5350),
(9, 'Cloroformo', 'CHCI2', 'Liquido', '2024-02-29', 'K53200845110', 'mililitro', 'E2-M3-F2', 'Tóxico', 1000),
(10, 'Acido Acetico', 'C2H4O6', 'Liquido', '2027-09-01', '2053864', 'mililitro', 'E2-M5-F1', 'Corrosivo', 2200);

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
  `unidad_medida` enum('unidad','litro','mililitros','kilogramos','gramos','miligramos') NOT NULL,
  `cantidad_salida` int(11) NOT NULL,
  `cantidad_total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `salidas`
--

INSERT INTO `salidas` (`dependencia`, `responsable`, `id`, `insumo`, `fecha`, `descripcion`, `unidad_medida`, `cantidad_salida`, `cantidad_total`) VALUES
('laboratorio', '', 0, 'Cloroformo', '2025-03-05 20:54:43', 'Usoo', 'mililitros', 100, 1000);

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
(3, 'andres', '3208908754', 'andress040406@gmail.com', 0, '3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2', NULL, NULL),
(4, 'camilo', '3214127016', 'camiloguti1070@gmail.com', 0, 'd19bace186ae9909f2ec15fbcb4f614051ee185e2584987bcf7cbff49f2a36be4805d513b8268b79e233cff398594efae504bfcde1bc7809ac13f75619e9d469', NULL, NULL),
(5, 'nicol', '3214127016', 'edwarnicolgixxwe@gmail.com', 0, '196795a8134c7a17fa0a8532df4178273651b1d686dcdc5afd0adef93e72f7f3db442268b73d8091a5d585e6ac879eb2d883c68caa1c24102872b622cc35edbc', NULL, NULL),
(6, 'marisela', '3202467952', 'murriagamoreno@gmail.com', 0, 'f815f585b4d7344c728e342b2c8a2454e5e48cca8888f12decda9f116071a8efc8cbd7949dc4cb36135abcb6ce97fd9b873aa98f9d326732a6b46c3380f1d14d', NULL, NULL),
(8, 'lola', '3214127016', 'lola234@gmail.com', 1, '$2y$10$t7nB74SPclm9YULfLfzRWeMXd2PFjl6RbFiK20KYEnpTPOKPSmIuC', NULL, NULL),
(9, 'rufo', '3214127016', 'rufo345@gmail.com', 1, '$2y$10$EHTjotuB2Yr5VRHcGyNUc.62Y/0UrL91qjYM1/gD54xonJCag5lkW', NULL, NULL),
(12, 'ponho', '3214127016', 'poncho1234@gmail.com', 1, '$2y$10$b9477jHpo6khH5ePYJAvOehLtyL3VmZAPv2ckAslHzBMLiqrWlyR2', NULL, NULL),
(13, 'sasha', '3214127016', 'sasah1222@gmail.com', 2, '$2y$10$PGtJk3X0fwAbBB5HOiNeVeJiirzND9gkhxe7C2WmOo3RjKfIBgUXe', NULL, NULL),
(14, 'lab', '3214127016', 'lab123@gmail.com', 2, '$2y$10$4Oskd1tEr6lsk3aHQrL/zOO/y.6w3GDR/QuazX6H.M8IAEvpijQ8S', NULL, NULL),
(15, 'henry', '3214127016', 'henry234@gmail.com', 1, '$2y$10$yxhpiBzrXqPlMWx4OIDeuOE/AjTDel0eo2XE2q.fw9BZMxlueltte', NULL, NULL),
(16, 'karen', '3214127016', 'karen1234@gmail.com', 1, '$2y$10$Lh9v8leDZQrcZhHcLmo8wev.bUDut8JIBcCY9Xj/cC.v/L/PlMtsS', NULL, NULL),
(18, 'tia', '3214127016', 'tia123@gmail.com', 1, '$2y$10$TxEymztr5ghG27izD1jwxO60OnPmKVP8TaVUI9qkpJiTgkFJb8XRu', NULL, NULL),
(19, 'pepito', '3214127016', 'pepito9089@gmail.com', 1, '$2y$10$guvRgPUd1QAvYs.3OJOomOhW7tmlJa1PqTWZzO5SdYr/R/HUAsjIC', NULL, NULL),
(20, 'oscar', '3218099115', 'camiloguti@gmail.com', 2, '$2y$10$zJFiSHXDm0C2PcieqtYnmeJsMX4IPnmf6sL.ciPlZa0xg35yVHNQK', NULL, NULL),
(21, 'hayder', '3214127016', 'hayder4567@gmail.com', 1, '$2y$10$jumryFUjCLY2VM2sXxz78.Nh5jMEeVsa.8BHmoICnkSsAsFupLRKu', NULL, NULL),
(22, 'samanta', '3214127016', 'samata23@gmail.com', 1, '$2y$10$Nld4dHFnvnanBKEX1Hn1h.A06kCMBp5rUMwCD3zPiyyCrpSxly5w2', NULL, NULL),
(23, 'nicol', '3214127016', 'nicol123@gmail.com', 2, '$2y$10$tcRKPECN1PB.zSPMGp75Su0fB8LvONJFxaalPA5Y0cfvTJn75g7aW', NULL, NULL),
(25, 'carlos', '3214127016', 'carlos1234@gmail.com', 2, '$2y$10$ojXOr8AlzUnXXqSDx4EPeeDWWFcHOkoXHulyshAPHawPDw1vyTZAW', NULL, NULL),
(81, 'David', '3123021995', 'hayderpalacios@gmail.com', 1, '$2y$10$h0p/eJHIWQuqfzhyVam1g.CHVjD1hqTpDW9s5h10jA4aswCav.Uky', NULL, NULL),
(84, 'rogelio', '3124678995', 'rogelio@gmail.com', 1, '$2y$10$5aq7a4CTUOm.Gm0BZmk.JOFWs9LyM0JrZJllBKrHFX.1UzkfRAawS', NULL, NULL),
(85, 'anselmo', '34567897654', 'anselmo@gmail.com', 2, '$2y$10$8hMFi1CB1sM5no/7nQXTl.hr02LHPI807ZUACTVrW8FoqxiH.bdyW', NULL, NULL),
(86, 'Palacios', '39876567', 'palacios@gmail.com', 2, '$2y$10$oHlNy0GFReADpUqiEpmF5O2kG7RwlLK3bF.C3uYuP5AtNhJvwVsv6', NULL, NULL);

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
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
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
  MODIFY `id` int(250) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `inventario_laboratorio`
--
ALTER TABLE `inventario_laboratorio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
