-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-05-2025 a las 20:20:18
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
-- Base de datos: `registro_forestal`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conservation_activities`
--

CREATE TABLE `conservation_activities` (
  `id` int(11) NOT NULL,
  `nombre_actividad` varchar(150) NOT NULL,
  `fecha_actividad` date NOT NULL,
  `responsable` varchar(150) DEFAULT NULL,
  `tipo_actividad` enum('Reforestación','Monitoreo','Control de especies invasoras','Educación ambiental','Otro') DEFAULT 'Otro',
  `descripcion` text DEFAULT NULL,
  `zona_id` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `conservation_activities`
--

INSERT INTO `conservation_activities` (`id`, `nombre_actividad`, `fecha_actividad`, `responsable`, `tipo_actividad`, `descripcion`, `zona_id`, `activo`) VALUES
(1, 'Reforestación con especies autóctonas', '2025-03-15', 'Equipo Yasuni', 'Reforestación', 'Plantación de árboles nativos para recuperar áreas degradadas.', 1, 1),
(2, 'Monitoreo de aves migratorias', '2025-01-18', 'Ornitólogos Cajas', 'Monitoreo', 'Seguimiento de especies migratorias para evaluar cambios poblacionales.', 2, 1),
(3, 'Taller de educación ambiental para escuelas', '2025-04-22', 'Educadores Zona 3', 'Educación ambiental', 'Capacitación a estudiantes sobre conservación y biodiversidad.', 3, 1),
(4, 'Control manual de plantas invasoras', '2025-03-27', 'Voluntarios Zona 4', 'Control de especies invasoras', 'Eliminación de plantas exóticas en senderos turísticos.', 4, 1),
(5, 'Estudio de calidad del suelo', '2025-02-05', 'Laboratorio Forestal', 'Monitoreo', 'Análisis de nutrientes y contaminación en el suelo.', 5, 1),
(6, 'Reforestación en áreas riparias', '2025-03-30', 'Biólogos Yasuni', 'Reforestación', 'Plantación de árboles a lo largo de ríos para protección ambiental.', 1, 1),
(7, 'Monitoreo de fauna terrestre', '2025-01-12', 'Conservacionistas Cajas', 'Monitoreo', 'Seguimiento de mamíferos para evaluar impacto humano.', 2, 1),
(8, 'Campaña de sensibilización comunitaria', '2025-03-15', 'Equipo de Educación Zona 3', 'Educación ambiental', 'Charlas sobre reducción de residuos y uso sostenible.', 3, 1),
(9, 'Uso de herbicidas para control de invasoras', '2025-04-20', 'Técnicos Zona 4', 'Control de especies invasoras', 'Aplicación controlada para erradicación de especies nocivas.', 4, 1),
(10, 'Monitoreo hidrológico', '2025-02-18', 'Ingenieros Ambientales', 'Monitoreo', 'Medición de caudales y calidad del agua en cuencas.', 5, 1),
(11, 'Reforestación con especies maderables', '2025-03-08', 'Forestal Yasuni', 'Reforestación', 'Plantación de árboles con alto valor comercial sostenible.', 1, 1),
(12, 'Monitoreo de insectos polinizadores', '2025-04-27', 'Entomólogos Cajas', 'Monitoreo', 'Estudio de la población de abejas y otros polinizadores.', 2, 1),
(13, 'Programa escolar de reciclaje', '2025-03-25', 'Educadores Zona 3', 'Educación ambiental', 'Implementación de estaciones de reciclaje en colegios.', 3, 1),
(14, 'Retiro manual de especies acuáticas invasoras', '2025-03-01', 'Voluntarios Zona 4', 'Control de especies invasoras', 'Extracción de plantas invasoras en lagunas.', 4, 1),
(15, 'Monitoreo de microclima', '2025-03-05', 'Climatólogos', 'Monitoreo', 'Registro de temperatura y humedad en diferentes microhábitats.', 5, 1),
(16, 'Reforestación para corredores biológicos', '2025-04-10', 'Biólogos Yasuni', 'Reforestación', 'Conectar fragmentos de bosque con plantaciones estratégicas.', 1, 1),
(17, 'Monitoreo de reptiles y anfibios', '2025-03-05', 'Herpetólogos Cajas', 'Monitoreo', 'Registro y evaluación de especies en peligro.', 2, 1),
(18, 'Capacitación en manejo sostenible de bosques', '2025-03-28', 'Equipo Educativo Zona 3', 'Educación ambiental', 'Talleres para comunidades sobre uso responsable de recursos.', 3, 1),
(19, 'Aplicación de barreras físicas contra invasoras', '2025-05-25', 'Técnicos Zona 4', 'Control de especies invasoras', 'Instalación de barreras para prevenir expansión de plantas invasoras.', 4, 1),
(20, 'Monitoreo de regeneración natural', '2025-03-22', 'Ecólogos', 'Monitoreo', 'Seguimiento del crecimiento de árboles jóvenes en áreas protegidas.', 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tree_species`
--

CREATE TABLE `tree_species` (
  `id` int(11) NOT NULL,
  `nombre_comun` varchar(100) NOT NULL,
  `nombre_cientifico` varchar(150) DEFAULT NULL,
  `familia_botanica` varchar(100) DEFAULT NULL,
  `estado_conservacion` enum('No Evaluado','Preocupación Menor','Vulnerable','En Peligro','En Peligro Crítico','Extinto') DEFAULT 'No Evaluado',
  `uso_principal` varchar(100) DEFAULT NULL COMMENT 'Ej: Madera, Medicina, Ornamental',
  `altura_maxima_m` decimal(5,2) DEFAULT NULL,
  `zona_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tree_species`
--

INSERT INTO `tree_species` (`id`, `nombre_comun`, `nombre_cientifico`, `familia_botanica`, `estado_conservacion`, `uso_principal`, `altura_maxima_m`, `zona_id`) VALUES
(1, 'Cinchona', 'Cinchona pubescens', 'Rubiaceae', 'No Evaluado', 'Medicina', 15.00, 1),
(2, 'Cedro', 'Cedrela odorata', 'Meliaceae', 'Vulnerable', 'Madera', 40.00, 1),
(3, 'Guayusa', 'Ilex guayusa', 'Aquifoliaceae', 'No Evaluado', 'Bebida', 18.00, 1),
(4, 'Polylepis', 'Polylepis pauta', 'Rosaceae', 'En Peligro', 'Ornamental', 7.00, 2),
(5, 'Aliso', 'Alnus acuminata', 'Betulaceae', 'No Evaluado', 'Madera', 25.00, 2),
(6, 'Yagual', 'Juglans neotropica', 'Juglandaceae', 'Vulnerable', 'Madera', 35.00, 2),
(7, 'Guayacán', 'Tabebuia chrysantha', 'Bignoniaceae', 'Preocupación Menor', 'Ornamental', 20.00, 3),
(8, 'Ceibo', 'Erythrina fusca', 'Fabaceae', 'Preocupación Menor', 'Ornamental', 15.00, 3),
(9, 'Algodón de playa', 'Gossypium barbadense', 'Malvaceae', 'No Evaluado', 'Fibra', 3.50, 3),
(10, 'Mangle rojo', 'Rhizophora mangle', 'Rhizophoraceae', 'No Evaluado', 'Protección costera', 25.00, 4),
(11, 'Mangle negro', 'Avicennia germinans', 'Acanthaceae', 'No Evaluado', 'Protección costera', 20.00, 4),
(12, 'Mangle blanco', 'Laguncularia racemosa', 'Combretaceae', 'No Evaluado', 'Protección costera', 15.00, 4),
(13, 'Palo santo', 'Bursera graveolens', 'Burseraceae', 'Preocupación Menor', 'Madera aromática', 12.00, 4),
(14, 'Líquenes de Galápagos', 'Cladonia spp.', 'Burseraceae', 'No Evaluado', 'Ecológico', 5.10, 5),
(15, 'Scalesia', 'Scalesia pedunculata', 'Asteraceae', 'En Peligro', 'Endémico', 10.00, 5),
(16, 'Cactus de Galápagos', 'Opuntia echios', 'Cactaceae', 'Preocupación Menor', 'Ornamental', 5.00, 5),
(17, 'Guayabillo', 'Psidium guajava', 'Myrtaceae', 'No Evaluado', 'Fruta', 8.00, 1),
(18, 'Capirona', 'Calycophyllum spruceanum', 'Rubiaceae', 'No Evaluado', 'Madera', 30.00, 1),
(19, 'Cinchona calisaya', 'Cinchona calisaya', 'Rubiaceae', 'Vulnerable', 'Medicina', 15.00, 2),
(20, 'Cacao', 'Theobroma cacao', 'Malvaceae', 'No Evaluado', 'Alimento', 8.00, 1),
(21, 'Caoba', 'Swietenia macrophylla', 'Meliaceae', 'Vulnerable', 'Madera', 40.00, 1),
(22, 'Cedro rojo', 'Cedrela odorata', 'Meliaceae', 'Vulnerable', 'Madera', 30.00, 1),
(23, 'Palo de rosa', 'Aniba rosaeodora', 'Lauraceae', 'En Peligro', 'Aceite esencial', 25.00, 1),
(24, 'Árbol de Júpiter', 'Delonix regia', 'Fabaceae', 'No Evaluado', 'Ornamental', 12.00, 2),
(25, 'Ciprés calvo', 'Taxodium distichum', 'Cupressaceae', 'No Evaluado', 'Ornamental, Madera', 35.00, 2),
(26, 'Roble americano', 'Quercus rubra', 'Fagaceae', 'No Evaluado', 'Madera', 28.00, 2),
(27, 'Pino ponderosa', 'Pinus ponderosa', 'Pinaceae', 'No Evaluado', 'Madera', 50.00, 2),
(28, 'Álamo temblón', 'Populus tremuloides', 'Salicaceae', 'No Evaluado', 'Madera', 25.00, 2),
(29, 'Baobab', 'Adansonia digitata', 'Malvaceae', 'Vulnerable', 'Ornamental, Alimentos', 30.00, 1),
(30, 'Sequoia gigante', 'Sequoiadendron giganteum', 'Cupressaceae', 'No Evaluado', 'Turismo, Ornamental', 85.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `zones`
--

CREATE TABLE `zones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ubicacion` varchar(200) NOT NULL,
  `provincia` varchar(100) DEFAULT NULL,
  `tipo_bosque` enum('Seco','Húmedo Tropical','Montano','Manglar','Otro') DEFAULT 'Otro',
  `area_ha` decimal(10,2) NOT NULL COMMENT 'Área en hectáreas',
  `descripcion` text DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `zones`
--

INSERT INTO `zones` (`id`, `nombre`, `ubicacion`, `provincia`, `tipo_bosque`, `area_ha`, `descripcion`, `fecha_registro`) VALUES
(1, 'Reserva Yasuní', 'Amazonas, noreste de Ecuador', 'Orellana', 'Húmedo Tropical', 982000.00, 'Una de las áreas con mayor biodiversidad del planeta, ubicada en la Amazonía ecuatoriana.', '2025-05-18 00:00:00'),
(2, 'Parque Nacional Cajas', 'Sierra sur, cerca de Cuenca', 'Azuay', 'Montano', 28500.00, 'Área protegida con bosques montanos y páramos, importante por su biodiversidad y lagunas.', '2025-05-18 11:07:51'),
(3, 'Bosque Seco de la Costa', 'Costa ecuatoriana, región de Manabí', 'Manabí', 'Seco', 15000.00, 'Bosque seco tropical, hogar de especies adaptadas a condiciones áridas.', '2025-05-18 11:07:51'),
(4, 'Manglares de la Bahía de Chone', 'Costa, litoral del Pacífico', 'Manabí', 'Manglar', 12000.00, 'Zona protegida con manglares que sirven como hábitat de peces y crustáceos.', '2025-05-18 11:07:51'),
(5, 'Parque Nacional Galápagos', 'Archipiélago Galápagos', NULL, 'Otro', 80000.00, 'Área protegida que conserva ecosistemas únicos de islas volcánicas.', '2025-05-18 11:07:51');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `conservation_activities`
--
ALTER TABLE `conservation_activities`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tree_species`
--
ALTER TABLE `tree_species`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `conservation_activities`
--
ALTER TABLE `conservation_activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `tree_species`
--
ALTER TABLE `tree_species`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `zones`
--
ALTER TABLE `zones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
