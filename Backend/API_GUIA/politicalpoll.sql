-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-05-2023 a las 06:14:59
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `politicalpoll`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_encuestas`
--

CREATE TABLE `tbl_encuestas` (
  `id_encuesta` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `estado` tinyint(4) NOT NULL,
  `mostrar` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_encuestas`
--

INSERT INTO `tbl_encuestas` (`id_encuesta`, `nombre`, `descripcion`, `estado`, `mostrar`) VALUES
(1, 'Ejemplo', 'Esta es la encuesta de ejemplo', 1, 1),
(2, 'Encuesta 2', 'Detalle de encuesta 2', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_preguntas`
--

CREATE TABLE `tbl_preguntas` (
  `id_pregunta` int(11) NOT NULL,
  `id_encuesta` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_preguntas`
--

INSERT INTO `tbl_preguntas` (`id_pregunta`, `id_encuesta`, `nombre`, `estado`) VALUES
(3, 1, 'Pregunta de ejemplo', 1),
(4, 1, 'Otra pregunta', 1),
(6, 1, 'Preguntas seriasdf', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_respuestas`
--

CREATE TABLE `tbl_respuestas` (
  `id_respuesta` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_respuestas`
--

INSERT INTO `tbl_respuestas` (`id_respuesta`, `id_pregunta`, `nombre`, `estado`) VALUES
(9, 3, 'Respuesta A', 1),
(11, 4, 'Respueta C', 1),
(12, 4, 'Respuesta D', 0),
(13, 6, 'fsdfsad', 1),
(18, 6, ' jhjh jhj', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_respuestas_usuarios`
--

CREATE TABLE `tbl_respuestas_usuarios` (
  `id_respuesta_usuario` int(11) NOT NULL,
  `id_encuesta` int(11) NOT NULL,
  `userInfo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`userInfo`)),
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_respuestas_usuarios`
--

INSERT INTO `tbl_respuestas_usuarios` (`id_respuesta_usuario`, `id_encuesta`, `userInfo`, `timestamp`) VALUES
(7, 1, '', '2023-02-03 06:55:29'),
(8, 1, '', '2023-02-03 06:55:29'),
(9, 1, '', '2023-02-03 06:55:29'),
(10, 1, '', '2023-02-03 06:55:29'),
(11, 1, '', '2023-02-03 06:55:29'),
(12, 1, '', '2023-02-03 07:03:25'),
(13, 1, '', '2023-02-06 02:42:00'),
(14, 1, '{\"ip\":\"200.119.173.161\",\"latitude\":14.810186605560817,\"longitude\":-90.15702793623026,\"oscpu\":\"Windows NT 10.0; Win64; x64\",\"appName\":\"Netscape\",\"buildID\":\"20181001000000\",\"plugins\":[[[],[]],[[],[]],[[],[]],[[],[]],[[],[]]],\"language\":\"es-ES\",\"mimeTypes\":[[],[]],\"languages\":[\"es-ES\",\"es\",\"en-US\",\"en\"],\"appVersion\":\"5.0 (Windows)\",\"browserName\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko\\/20100101 Firefox\\/110.0\",\"productSub\":\"20100101\",\"permissions\":[],\"appCodeName\":\"Mozilla\",\"pdfViewerEnabled\":\"1\",\"cookieEnabled\":true,\"maxTouchPoints\":0,\"top\":0,\"left\":0,\"width\":1366,\"height\":768,\"availTop\":0,\"availLeft\":0,\"pixelDepth\":24,\"availWidth\":1366,\"colorDepth\":24,\"availHeight\":720,\"orientation\":[],\"mozOrientation\":\"landscape-primary\",\"screenResolution\":\"1366x768\"}', '2023-02-09 06:05:05'),
(15, 1, '{\"ip\":{\"ip\":\"200.119.173.161\",\"network\":\"200.119.172.0\\/22\",\"version\":\"IPv4\",\"city\":\"Guatemala City\",\"region\":\"Guatemala Department\",\"region_code\":\"GU\",\"country\":\"GT\",\"country_name\":\"Guatemala\",\"country_code\":\"GT\",\"country_code_iso3\":\"GTM\",\"country_capital\":\"Guatemala City\",\"country_tld\":\".gt\",\"continent_code\":\"NA\",\"in_eu\":false,\"postal\":\"01010\",\"latitude\":14.6343,\"longitude\":-90.5155,\"timezone\":\"America\\/Guatemala\",\"utc_offset\":\"-0600\",\"country_calling_code\":\"+502\",\"currency\":\"GTQ\",\"currency_name\":\"Quetzal\",\"languages\":\"es-GT\",\"country_area\":108890,\"country_population\":17247807,\"asn\":\"AS14754\",\"org\":\"Telgua\"},\"latitude\":14.810175366261777,\"longitude\":-90.15702541330647,\"oscpu\":\"Windows NT 10.0; Win64; x64\",\"appName\":\"Netscape\",\"buildID\":\"20181001000000\",\"plugins\":[[[],[]],[[],[]],[[],[]],[[],[]],[[],[]]],\"language\":\"es-ES\",\"mimeTypes\":[[],[]],\"languages\":[\"es-ES\",\"es\",\"en-US\",\"en\"],\"appVersion\":\"5.0 (Windows)\",\"browserName\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko\\/20100101 Firefox\\/110.0\",\"productSub\":\"20100101\",\"permissions\":[],\"appCodeName\":\"Mozilla\",\"pdfViewerEnabled\":\"1\",\"cookieEnabled\":true,\"maxTouchPoints\":0,\"top\":0,\"left\":0,\"width\":1366,\"height\":768,\"availTop\":0,\"availLeft\":0,\"pixelDepth\":24,\"availWidth\":1366,\"colorDepth\":24,\"availHeight\":720,\"orientation\":[],\"mozOrientation\":\"landscape-primary\",\"screenResolution\":\"1366x768\"}', '2023-02-09 06:18:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_respuestas_usuarios_detalle`
--

CREATE TABLE `tbl_respuestas_usuarios_detalle` (
  `id_respuestas_usuarios_detalle` int(11) NOT NULL,
  `id_respuestas_usuarios` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `id_respuesta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_respuestas_usuarios_detalle`
--

INSERT INTO `tbl_respuestas_usuarios_detalle` (`id_respuestas_usuarios_detalle`, `id_respuestas_usuarios`, `id_pregunta`, `id_respuesta`) VALUES
(1, 7, 6, 13),
(2, 7, 4, 11),
(3, 8, 6, 13),
(4, 8, 4, 11),
(5, 9, 6, 13),
(6, 9, 4, 11),
(7, 10, 6, 13),
(8, 10, 4, 11),
(9, 11, 6, 13),
(10, 11, 4, 11),
(11, 12, 6, 13),
(12, 12, 4, 11),
(13, 12, 3, 9),
(14, 13, 6, 13),
(15, 13, 4, 12),
(16, 13, 3, 9),
(17, 14, 6, 13),
(18, 14, 4, 12),
(19, 14, 3, 9),
(20, 15, 6, 18),
(21, 15, 4, 11),
(22, 15, 3, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tokens`
--

CREATE TABLE `tbl_tokens` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `expiracion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_tokens`
--

INSERT INTO `tbl_tokens` (`id`, `id_usuario`, `token`, `expiracion`) VALUES
(1, 1, 'aca630e3f8e62c155a76284d443046b6f955bb0dc44519da37c584fe94d1478064bad17ff349aa0b899872a9bc01360abd538bafc30af541fab33f4e971423a6', '2023-02-03 23:42:55'),
(2, 1, '5feaa5d31b383f6e7bcc01a0c0b546c3fa0d8f2b5f62e52798241605c82bebd14a889d545f17b03c40ea012fb373b477c72792886378504d4ea3510de4d03427', '2023-02-04 00:15:26'),
(3, 1, '5844fdcd255182343fcd3ce95a855e583d126d3537b2e0524db1bdd2e1dd54b357b0ca7eccba76ac575cc3ec992867946db17af865111378ea17041bfad016c8', '2023-02-04 00:17:13'),
(4, 1, 'c97da369a9f61bb41058cd9deb521672a7aa4f7aa7c01dc686c8f0b89c6ccbb217483b72e377b328d47d984a23f9754fc55a30c0e9b5ba11a2425f5a557b46be', '2023-02-04 00:18:16'),
(5, 1, 'cbaea4aaff793965bdf58bc15de80b3ac6fee33d2d6b8e1966e2590c251d8602e7b9d7d9a5d8bbcdb51f5499bd7bc28ca5be414c6cc303330ef4e38293e0dc79', '2023-02-04 00:18:57'),
(6, 1, '31054182c6349e464b96527e2c488f4a362a0e4dca4b2b5040998232c49234da59c4299712216989011a3cf51957f6b4fecce16d5bfde59be2af16dd34089f5a', '2023-02-04 00:33:11'),
(7, 1, 'dde612a49a29f68ca34867d225eed6e42af39d8388292c26f4313d796344ebc17b897f718e12ffb82b2fec56fbdb7a15ab278f633873360f0c901e0d967ddc37', '2023-02-04 00:40:09'),
(8, 1, 'e174f7bc822f370404ff2526632167dbb99948964e51165a9ce5cc8fa6af34357e7a57fc17028cf7c45a8a106b74ae4b683b333bf0085454ccd1752bd94b790d', '2023-02-04 00:40:47'),
(9, 1, '9f84c40fc8da09cfc8ed4b995c140c2b5fc7e8b3cae880660b5e83e56fb8fa5c7f3e82949f62eb570634414ce8487cb70daef04e71df9c234878cd2c2bc09c25', '2023-02-04 00:42:28'),
(10, 1, 'ca64f074c73ea871ac6344c2d560adff5c9a63ec95475c7d4eab79eb31ff6d23b13b86e91a6e26dcc4a711af2511b071e45382e2756febcf0b5395a2008afc62', '2023-02-05 05:46:23'),
(11, 1, '1a83877d2004a87ed45dedd309b4e4ad97392322ffbf316f30e2829f247ca3f8b356d2eeb78c831f9c292b20b757c7759e4510c7af7bdb6025e775ee944a6678', '2023-02-05 06:44:47'),
(12, 1, '1af480c02d4ef32724ba9fb701bacd7fd39ca36b99c1211343170a0c1fd60ad8d34519fcb78c785e37e45a437910e7118e9161ddf4f22d6fb5baa966bb536eb3', '2023-02-05 06:45:07'),
(13, 1, 'ac1490e2d459b1cebcfa1632995730b74263fb3337ae2552def66169589bee3df9d63c27f98ae4ce508dc087f448df236c02c1f68f24675baa2dec622505673d', '2023-02-05 16:24:51'),
(14, 1, '1a6811c16dab2d3fa40591bbe63437ccf050f95aed98d9014b37d85ee52f81d9aba8fdab7b9de874865fb1c75a28921b36c489784c5c5d62e011e3821aa82358', '2023-02-05 18:38:57'),
(15, 1, '89999aa0b421ce1caba678ef7a3d1807991157233840d57bb17a015e2796c4d48e87e9bc4e11f69b2419072c416ca005f9f1b63f5904cbff75d7a7eee9d4e707', '2023-02-05 20:48:42'),
(16, 1, 'e3db1aca68088fb4bc19de5ed7883d3fab590b4c82213b08b937e45cc0c3731992c18ba9657794534ec56807729ad1c1927e193b3ef8f7bcccf2372635ca4614', '2023-02-06 00:45:32'),
(17, 1, 'd5c6aa8dd6dca72e951b9b7a239aa4793539a5e21a062b00b76e9e808704107e4a9f12a15f6c3127467bf9fb0d20e6c66a55adbebe11399f249a99b87675cfb6', '2023-02-06 02:47:12'),
(18, 1, '3d5af51f36963ed494e13178f1e330a16d9799f9153d32e091a0912434e2d9b86e7913ec87c8370873e822e09128c0f2c220e50ed4d431a6f49bb7d5b560e3cb', '2023-02-06 04:47:51'),
(19, 1, '5b60ab78889e664643cf1552b23191393375a9f4771ea35881853006757eb433b557fd02a64b09326b5e6c0505bf6a9dc3bd67f9982982084187752be9479a43', '2023-02-06 05:46:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`id_usuario`, `username`, `password`, `firstname`, `lastname`) VALUES
(1, 'admin', '123', 'Usuario', 'Administrador');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_encuestas`
--
ALTER TABLE `tbl_encuestas`
  ADD PRIMARY KEY (`id_encuesta`);

--
-- Indices de la tabla `tbl_preguntas`
--
ALTER TABLE `tbl_preguntas`
  ADD PRIMARY KEY (`id_pregunta`),
  ADD KEY `encuesta_pregunta` (`id_encuesta`);

--
-- Indices de la tabla `tbl_respuestas`
--
ALTER TABLE `tbl_respuestas`
  ADD PRIMARY KEY (`id_respuesta`),
  ADD KEY `respuesta_pregunta` (`id_pregunta`);

--
-- Indices de la tabla `tbl_respuestas_usuarios`
--
ALTER TABLE `tbl_respuestas_usuarios`
  ADD PRIMARY KEY (`id_respuesta_usuario`),
  ADD KEY `respuesta_pregunta_encuesta` (`id_encuesta`);

--
-- Indices de la tabla `tbl_respuestas_usuarios_detalle`
--
ALTER TABLE `tbl_respuestas_usuarios_detalle`
  ADD PRIMARY KEY (`id_respuestas_usuarios_detalle`),
  ADD KEY `id_pregunta_usuario` (`id_pregunta`),
  ADD KEY `id_respuesta_usuario_detalle` (`id_respuestas_usuarios`),
  ADD KEY `id_respuesta_usuario` (`id_respuesta`);

--
-- Indices de la tabla `tbl_tokens`
--
ALTER TABLE `tbl_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_encuestas`
--
ALTER TABLE `tbl_encuestas`
  MODIFY `id_encuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbl_preguntas`
--
ALTER TABLE `tbl_preguntas`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tbl_respuestas`
--
ALTER TABLE `tbl_respuestas`
  MODIFY `id_respuesta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `tbl_respuestas_usuarios`
--
ALTER TABLE `tbl_respuestas_usuarios`
  MODIFY `id_respuesta_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tbl_respuestas_usuarios_detalle`
--
ALTER TABLE `tbl_respuestas_usuarios_detalle`
  MODIFY `id_respuestas_usuarios_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `tbl_tokens`
--
ALTER TABLE `tbl_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_preguntas`
--
ALTER TABLE `tbl_preguntas`
  ADD CONSTRAINT `encuesta_pregunta` FOREIGN KEY (`id_encuesta`) REFERENCES `tbl_encuestas` (`id_encuesta`);

--
-- Filtros para la tabla `tbl_respuestas`
--
ALTER TABLE `tbl_respuestas`
  ADD CONSTRAINT `respuesta_pregunta` FOREIGN KEY (`id_pregunta`) REFERENCES `tbl_preguntas` (`id_pregunta`);

--
-- Filtros para la tabla `tbl_respuestas_usuarios`
--
ALTER TABLE `tbl_respuestas_usuarios`
  ADD CONSTRAINT `respuesta_pregunta_encuesta` FOREIGN KEY (`id_encuesta`) REFERENCES `tbl_encuestas` (`id_encuesta`);

--
-- Filtros para la tabla `tbl_respuestas_usuarios_detalle`
--
ALTER TABLE `tbl_respuestas_usuarios_detalle`
  ADD CONSTRAINT `id_pregunta_usuario` FOREIGN KEY (`id_pregunta`) REFERENCES `tbl_preguntas` (`id_pregunta`),
  ADD CONSTRAINT `id_respuesta_usuario` FOREIGN KEY (`id_respuesta`) REFERENCES `tbl_respuestas` (`id_respuesta`),
  ADD CONSTRAINT `id_respuesta_usuario_detalle` FOREIGN KEY (`id_respuestas_usuarios`) REFERENCES `tbl_respuestas_usuarios` (`id_respuesta_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
