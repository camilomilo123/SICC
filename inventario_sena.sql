-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 19-01-2025 a las 22:30:38
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
-- Estructura de tabla para la tabla `entradas`
--

CREATE TABLE `entradas` (
  `id` int(11) NOT NULL,
  `inventario_id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `unidad_medida` varchar(50) NOT NULL,
  `cantidad_anterior` decimal(10,2) NOT NULL,
  `cantidad_ingresada` decimal(10,2) NOT NULL,
  `cantidad_total` decimal(10,2) GENERATED ALWAYS AS (`cantidad_anterior` + `cantidad_ingresada`) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `entradas`
--

INSERT INTO `entradas` (`id`, `inventario_id`, `nombre`, `fecha`, `unidad_medida`, `cantidad_anterior`, `cantidad_ingresada`) VALUES
(1, 1, 'Ácido Acético >99.8%', '2025-01-17', 'kg', 4778.00, 200.00),
(2, 1, 'Ácido Acético >99.8%', '2025-01-17', 'kg', 4978.00, 200.00),
(3, 1, 'Ácido Acético >99.8%', '2025-01-17', 'ml', 5178.00, 222.00),
(4, 1, 'Ácido Acético >99.8%', '2025-01-17', 'ml', 5400.00, 222.00),
(5, 2, 'acetaminofen ', '2025-01-17', 'kg', 900.00, 200.00);

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
  `cantidad` decimal(10,2) NOT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `codigo_almacenamiento` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_laboratorio`
--

INSERT INTO `inventario_laboratorio` (`id`, `reactivo`, `formula`, `estado`, `fecha_vencimiento`, `lote`, `cantidad`, `unidad_medida`, `ubicacion`, `codigo_almacenamiento`) VALUES
(1, 'Ácido Acético >99.8%', 'C2H4O2', 'líquido', '2027-09-01', '2053864', 5622.00, 'ml', 'E2-M5-F1', 'corrosivo'),
(2, 'acetaminofen ', 'xxxx', 'bien ', '2025-01-16', 'xxx', 1100.00, 'gramos', 'sasaima', 'bueno ');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventario_id` (`inventario_id`);

--
-- Indices de la tabla `inventario_laboratorio`
--
ALTER TABLE `inventario_laboratorio`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `entradas`
--
ALTER TABLE `entradas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `inventario_laboratorio`
--
ALTER TABLE `inventario_laboratorio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD CONSTRAINT `entradas_ibfk_1` FOREIGN KEY (`inventario_id`) REFERENCES `inventario_laboratorio` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
