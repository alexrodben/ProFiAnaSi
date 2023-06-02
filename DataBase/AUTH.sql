DROP DATABASE IF EXISTS inventory_control;
CREATE DATABASE inventory_control; 
USE inventory_control;

CREATE TABLE `tbl_tokens` ( `id` int(11) NOT NULL AUTO_INCREMENT, `id_usuario` int(11) NOT NULL, `token` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL, `expiracion` datetime NOT NULL, PRIMARY KEY (`id`) ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;
INSERT INTO `tbl_tokens` (`id`, `id_usuario`, `token`, `expiracion`) VALUES (1, 1, 'aca630e3f8e62c155a76284d443046b6f955bb0dc44519da37c584fe94d1478064bad17ff349aa0b899872a9bc01360abd538bafc30af541fab33f4e971423a6', '2023-02-03 23:42:55');

CREATE TABLE `tbl_usuarios` ( `id_usuario` int(11) NOT NULL AUTO_INCREMENT, `username` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL, `password` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL, `firstname` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL, `lastname` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL, PRIMARY KEY (`id_usuario`) ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;
INSERT INTO `tbl_usuarios` (`id_usuario`, `username`, `password`, `firstname`, `lastname`) VALUES (1, 'admin', '123', 'Usuario', 'Administrador');