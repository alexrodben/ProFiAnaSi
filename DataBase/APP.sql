-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-06-2023 a las 07:53:45
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
-- Base de datos: `inventory_control`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_cliente_inactivo` (IN `p_Id_Cliente` INT)   BEGIN
    IF EXISTS(SELECT * FROM tbl_cliente WHERE Id_Cliente = p_Id_Cliente AND Estatus = 'activo') THEN
        UPDATE tbl_cliente SET Estatus = 'inactivo' WHERE Id_Cliente = p_Id_Cliente;
        SELECT 'Cliente actualizado a inactivo correctamente.' AS Message;
    ELSE
        SELECT 'El cliente no existe o ya está inactivo.' AS Message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_producto_inactivo` (IN `p_Id_Producto` INT)   BEGIN
    DECLARE v_Stock INT;
    SELECT Stock INTO v_Stock FROM tbl_producto WHERE Id_Producto = p_Id_Producto;
    
    IF EXISTS(SELECT * FROM tbl_producto WHERE Id_Producto = p_Id_Producto AND Estado = 'activo') THEN
        IF v_Stock > 0 THEN
            SELECT 'No se puede actualizar a inactivo. El producto tiene stock disponible.' AS Message;
        ELSE
            UPDATE tbl_producto SET Estado = 'inactivo' WHERE Id_Producto = p_Id_Producto;
            SELECT 'Producto actualizado a inactivo correctamente.' AS Message;
        END IF;
    ELSE
        SELECT 'El producto no existe o ya está inactivo.' AS Message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_actualizar_proveedor_inactivo` (IN `p_Id_Proveedor` INT)   BEGIN
    IF EXISTS(SELECT * FROM tbl_proveedor WHERE Id_Proveedor = p_Id_Proveedor AND Estatus = 'activo') THEN
        UPDATE tbl_proveedor SET Estatus = 'inactivo' WHERE Id_Proveedor = p_Id_Proveedor;
        SELECT 'Proveedor actualizado a inactivo correctamente.' AS Message;
    ELSE
        SELECT 'El proveedor no existe o ya está inactivo.' AS Message;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_compra` (IN `compra_id` INT)   BEGIN
    SELECT * FROM tbl_detalle_compra WHERE Id_Compra = compra_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_detalle_venta` (IN `venta_id` INT)   BEGIN
    SELECT * FROM tbl_detalle_venta WHERE Id_Venta = venta_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_categoria` (IN `p_Id_Categoria` INT, IN `p_Nombre` VARCHAR(255))   BEGIN
    DECLARE v_Count INT;
    
    -- Verificar si la categoría existe
    SELECT COUNT(*) INTO v_Count
    FROM tbl_categoria
    WHERE Id_Categoria = p_Id_Categoria;
    
    -- Si la categoría no existe, mostrar mensaje de error
    IF v_Count = 0 THEN
        SELECT 'La categoría no existe' AS Error;
    ELSE
        -- Actualizar el nombre de la categoría
        UPDATE tbl_categoria
        SET Nombre = p_Nombre,
            UpdatedAt = CURRENT_TIMESTAMP
        WHERE Id_Categoria = p_Id_Categoria;
        
        SELECT 'Categoría actualizada correctamente' AS Result;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_cliente` (IN `p_Id_Cliente` INT, IN `p_Estatus` ENUM('activo','inactivo'), IN `p_Nombre` VARCHAR(255), IN `p_Direccion` VARCHAR(255), IN `p_Nit` VARCHAR(20), IN `p_Telefono` VARCHAR(20), IN `p_Email` VARCHAR(255))   BEGIN
    DECLARE v_Count INT;
    
    -- Verificar si el cliente existe
    SELECT COUNT(*) INTO v_Count
    FROM tbl_cliente
    WHERE Id_Cliente = p_Id_Cliente;
    
    -- Si el cliente no existe, mostrar mensaje de error
    IF v_Count = 0 THEN
        SELECT 'El cliente no existe' AS Error;
    ELSE
        -- Actualizar los datos del cliente
        UPDATE tbl_cliente
        SET Estatus = p_Estatus,
            Nombre = p_Nombre,
            Direccion = p_Direccion,
            Nit = p_Nit,
            Telefono = p_Telefono,
            Email = p_Email,
            UpdatedAt = CURRENT_TIMESTAMP
        WHERE Id_Cliente = p_Id_Cliente;
        
        SELECT 'Cliente actualizado correctamente' AS Result;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_producto` (IN `p_Id_Producto` INT, IN `p_Id_Categoria` INT, IN `p_Nombre` VARCHAR(255), IN `p_SKU` VARCHAR(50), IN `p_Estado` ENUM('activo','inactivo'), IN `p_Descripcion` TEXT, IN `p_Existencia_Minima` INT, IN `p_Existencia_Maxima` INT, IN `p_Stock` INT, IN `p_Imagen` VARCHAR(255), IN `p_Valor_Unitario` DECIMAL(10,2))   BEGIN
    DECLARE v_Count INT;
    
    -- Verificar si el producto existe
    SELECT COUNT(*) INTO v_Count
    FROM tbl_producto
    WHERE Id_Producto = p_Id_Producto;
    
    -- Si el producto no existe, mostrar mensaje de error
    IF v_Count = 0 THEN
        SELECT 'El producto no existe' AS Error;
    ELSE
        -- Verificar si la categoría existe
        SELECT COUNT(*) INTO v_Count
        FROM tbl_categoria
        WHERE Id_Categoria = p_Id_Categoria;
        
        -- Si la categoría no existe, mostrar mensaje de error
        IF v_Count = 0 THEN
            SELECT 'La categoría no existe' AS Error;
        ELSE
            -- Actualizar los datos del producto
            UPDATE tbl_producto
            SET Id_Categoria = p_Id_Categoria,
                Nombre = p_Nombre,
                SKU = p_SKU,
                Estado = p_Estado,
                Descripcion = p_Descripcion,
                Existencia_minima = p_Existencia_Minima,
                Existencia_maxima = p_Existencia_Maxima,
                Stock = p_Stock,
                Imagen = p_Imagen,
                Valor_Unitario = p_Valor_Unitario,
                UpdatedAt = CURRENT_TIMESTAMP
            WHERE Id_Producto = p_Id_Producto;
            
            SELECT 'Producto actualizado correctamente' AS Result;
        END IF;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_proveedor` (IN `p_Id_Proveedor` INT, IN `p_Estatus` ENUM('activo','inactivo'), IN `p_Nombre` VARCHAR(255), IN `p_Direccion` VARCHAR(255), IN `p_Nit` VARCHAR(20), IN `p_Telefono` VARCHAR(20), IN `p_Email` VARCHAR(255))   BEGIN
    DECLARE v_Count INT;
    
    -- Verificar si el proveedor existe
    SELECT COUNT(*) INTO v_Count
    FROM tbl_proveedor
    WHERE Id_Proveedor = p_Id_Proveedor;
    
    -- Si el proveedor no existe, mostrar mensaje de error
    IF v_Count = 0 THEN
        SELECT 'El proveedor no existe' AS Error;
    ELSE
        -- Actualizar los datos del proveedor
        UPDATE tbl_proveedor
        SET Estatus = p_Estatus,
            Nombre = p_Nombre,
            Direccion = p_Direccion,
            Nit = p_Nit,
            Telefono = p_Telefono,
            Email = p_Email,
            UpdatedAt = CURRENT_TIMESTAMP
        WHERE Id_Proveedor = p_Id_Proveedor;
        
        SELECT 'Proveedor actualizado correctamente' AS Result;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_categoria` (IN `p_Nombre` VARCHAR(255))   BEGIN
    DECLARE record_count INT;
    SET record_count = (SELECT COUNT(*) FROM tbl_categoria WHERE Nombre = p_Nombre);
    
    IF record_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: La categoría ya está registrada.';
    ELSE
        INSERT INTO tbl_categoria (Nombre, CreatedAt)
        VALUES (p_Nombre, CURDATE());
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_cliente` (IN `p_Estatus` ENUM('activo','inactivo'), IN `p_Nombre` VARCHAR(255), IN `p_Direccion` VARCHAR(255), IN `p_Nit` VARCHAR(20), IN `p_Telefono` VARCHAR(20), IN `p_Email` VARCHAR(255))   BEGIN
    DECLARE record_count INT;
    SET record_count = (SELECT COUNT(*) FROM tbl_cliente WHERE Nombre = p_Nombre);
    
    IF record_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: El cliente ya está registrado.';
    ELSE
        INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email, CreatedAt)
        VALUES (p_Estatus, p_Nombre, p_Direccion, p_Nit, p_Telefono, p_Email, CURDATE());
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_compra` (IN `p_Id_Proveedor` INT, IN `p_Fecha` DATE)   BEGIN
    DECLARE record_count INT;
    SET record_count = (SELECT COUNT(*) FROM tbl_compra WHERE Id_Proveedor = p_Id_Proveedor AND Fecha = p_Fecha);
    
    IF record_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: La compra ya está registrada.';
    ELSE
        INSERT INTO tbl_compra (Id_Proveedor, Fecha, CreatedAt)
        VALUES (p_Id_Proveedor, p_Fecha, CURRENT_TIMESTAMP);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_detalle_compra` (IN `p_Id_Compra` INT, IN `p_Id_Producto` INT, IN `p_Cantidad` INT, IN `p_Valor_Unitario` DECIMAL(10,2), IN `p_Valor_Costo` DECIMAL(10,2), IN `p_Valor_Total` DECIMAL(10,2))   BEGIN
    INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total, CreatedAt)
    VALUES (p_Id_Compra, p_Id_Producto, p_Cantidad, p_Valor_Unitario, p_Valor_Costo, p_Valor_Total, CURRENT_TIMESTAMP);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_detalle_venta` (IN `p_Id_Venta` INT, IN `p_Id_Producto` INT, IN `p_Cantidad` INT, IN `p_Valor_Unitario` DECIMAL(10,2))   BEGIN
    INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario, CreatedAt)
    VALUES (p_Id_Venta, p_Id_Producto, p_Cantidad, p_Valor_Unitario, CURRENT_TIMESTAMP);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_producto` (IN `p_Id_Producto` INT, IN `p_Id_Categoria` INT, IN `p_Nombre` VARCHAR(255), IN `p_SKU` VARCHAR(50), IN `p_Estado` ENUM('activo','inactivo'), IN `p_Descripcion` TEXT, IN `p_Existencia_Minima` INT, IN `p_Existencia_Maxima` INT, IN `p_Stock` INT, IN `p_Imagen` VARCHAR(255), IN `p_Valor_Unitario` DECIMAL(10,2))   BEGIN
    DECLARE product_count INT;
    
    -- Verificar si el producto ya existe
    SELECT COUNT(*) INTO product_count FROM tbl_producto WHERE Id_Producto = p_Id_Producto;
    
    IF product_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El producto ya existe.';
    ELSE
        -- Insertar el producto
        INSERT INTO tbl_producto (
            Id_Producto,
            Id_Categoria,
            Nombre,
            SKU,
            Estado,
            Descripcion,
            Existencia_Minima,
            Existencia_Maxima,
            Stock,
            Imagen,
            Valor_Unitario
        )
        VALUES (
            p_Id_Producto,
            p_Id_Categoria,
            p_Nombre,
            p_SKU,
            p_Estado,
            p_Descripcion,
            p_Existencia_Minima,
            p_Existencia_Maxima,
            p_Stock,
            p_Imagen,
            p_Valor_Unitario
        );
        
        SELECT 'Producto insertado correctamente.' AS Message;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_proveedor` (IN `p_Estatus` ENUM('activo','inactivo'), IN `p_Nombre` VARCHAR(255), IN `p_Direccion` VARCHAR(255), IN `p_Nit` VARCHAR(20), IN `p_Telefono` VARCHAR(20), IN `p_Email` VARCHAR(255))   BEGIN
    DECLARE record_count INT;
    SET record_count = (SELECT COUNT(*) FROM tbl_proveedor WHERE Nombre = p_Nombre);
    
    IF record_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: El proveedor ya está registrado.';
    ELSE
        INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email, CreatedAt)
        VALUES (p_Estatus, p_Nombre, p_Direccion, p_Nit, p_Telefono, p_Email, CURDATE());
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insertar_venta` (IN `p_Id_Cliente` INT, IN `p_Fecha` DATE)   BEGIN
    DECLARE record_count INT;
    SET record_count = (SELECT COUNT(*) FROM tbl_venta WHERE Id_Cliente = p_Id_Cliente AND Fecha = p_Fecha);
    
    IF record_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: La venta ya está registrada.';
    ELSE
        INSERT INTO tbl_venta (Id_Cliente, Fecha, CreatedAt)
        VALUES (p_Id_Cliente, p_Fecha, CURRENT_TIMESTAMP);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_cardex` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_cardex WHERE Id_Cardex = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_categoria` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_categoria WHERE Id_Categoria = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_cliente` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_cliente WHERE Id_Cliente = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_compra` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_compra WHERE Id_Compra = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_detalle_compra` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_detalle_compra WHERE Id_Detalle_Compra = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_detalle_venta` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_detalle_venta WHERE Id_Detalle_Venta = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_producto` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_producto WHERE Id_Producto = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_proveedor` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_proveedor WHERE Id_Proveedor = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_venta` (IN `item_id` INT)   BEGIN
    SELECT * FROM tbl_venta WHERE Id_Venta = item_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_cardex` ()   BEGIN
    SELECT * FROM tbl_cardex;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_categoria` ()   BEGIN
    SELECT * FROM tbl_categoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_cliente` ()   BEGIN
    SELECT * FROM tbl_cliente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_compra` ()   BEGIN
    SELECT * FROM tbl_compra;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_detalle_compra` ()   BEGIN
    SELECT * FROM tbl_detalle_compra;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_detalle_venta` ()   BEGIN
    SELECT * FROM tbl_detalle_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_producto` ()   BEGIN
    SELECT * FROM tbl_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_proveedor` ()   BEGIN
    SELECT * FROM tbl_proveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mostrar_venta` ()   BEGIN
    SELECT * FROM tbl_venta;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cardex`
--

CREATE TABLE `tbl_cardex` (
  `Id_Cardex` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Detalle` varchar(255) NOT NULL,
  `Tipo_Transaccion` enum('compra','venta') NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Valor_Unitario` decimal(10,2) NOT NULL,
  `Valor_Total` decimal(10,2) NOT NULL,
  `Stock` int(11) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_cardex`
--

INSERT INTO `tbl_cardex` (`Id_Cardex`, `Fecha`, `Detalle`, `Tipo_Transaccion`, `Cantidad`, `Valor_Unitario`, `Valor_Total`, `Stock`, `CreatedAt`, `UpdatedAt`) VALUES
(1, '2023-01-01', '1 - Producto A usado', 'compra', 10, '9.99', '99.90', 10, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, '2023-01-02', '2 - Producto B usado', 'venta', 5, '19.99', '99.95', 5, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, '2023-01-03', '3 - Producto C usado', 'compra', 8, '14.99', '119.92', 13, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, '2023-01-04', '4 - Producto D usado', 'venta', 3, '24.99', '74.97', 10, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, '2023-01-05', '5 - Producto E usado', 'compra', 12, '9.99', '119.88', 22, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, '2023-01-06', '6 - Producto F usado', 'venta', 7, '14.99', '104.93', 15, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, '2023-01-07', '7 - Producto G usado', 'compra', 6, '19.99', '119.94', 21, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, '2023-01-08', '8 - Producto H usado', 'venta', 4, '24.99', '99.96', 17, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, '2023-01-09', '9 - Producto I usado', 'compra', 9, '14.99', '134.91', 26, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, '2023-01-10', '10 - Producto J usado', 'venta', 2, '19.99', '39.98', 24, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(11, '2023-01-11', '11 - Producto A usado', 'compra', 7, '9.99', '69.93', 31, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(12, '2023-01-12', '12 - Producto B usado', 'venta', 3, '19.99', '59.97', 28, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(13, '2023-01-13', '13 - Producto C usado', 'compra', 5, '14.99', '74.95', 33, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(14, '2023-01-14', '14 - Producto D usado', 'venta', 2, '24.99', '49.98', 31, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(15, '2023-01-15', '15 - Producto E usado', 'compra', 10, '9.99', '99.90', 41, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(16, '2023-01-16', '16 - Producto F usado', 'venta', 4, '14.99', '59.96', 37, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(17, '2023-01-17', '17 - Producto G usado', 'compra', 8, '19.99', '159.92', 45, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(18, '2023-01-18', '18 - Producto H usado', 'venta', 5, '24.99', '124.95', 40, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(19, '2023-01-19', '19 - Producto I usado', 'compra', 6, '14.99', '89.94', 46, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(20, '2023-01-20', '20 - Producto J usado', 'venta', 3, '19.99', '59.97', 43, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(21, '2023-01-21', '21 - Producto A usado', 'compra', 6, '9.99', '59.94', 49, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(22, '2023-01-22', '22 - Producto B usado', 'venta', 2, '19.99', '39.98', 47, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(23, '2023-01-23', '23 - Producto C usado', 'compra', 4, '14.99', '59.96', 51, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(24, '2023-01-24', '24 - Producto D usado', 'venta', 3, '24.99', '74.97', 48, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(25, '2023-01-25', '25 - Producto E usado', 'compra', 5, '9.99', '49.95', 53, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(26, '2023-01-26', '26 - Producto F usado', 'venta', 2, '14.99', '29.98', 51, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(27, '2023-01-27', '27 - Producto G usado', 'compra', 3, '19.99', '59.97', 54, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(28, '2023-01-28', '28 - Producto H usado', 'venta', 4, '24.99', '99.96', 50, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(29, '2023-01-29', '29 - Producto I usado', 'compra', 2, '14.99', '29.98', 52, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(30, '2023-01-30', '30 - Producto J usado', 'venta', 3, '19.99', '59.97', 49, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(31, '2023-02-01', '31 - Producto A usado', 'compra', 4, '9.99', '39.96', 53, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(32, '2023-02-02', '32 - Producto B usado', 'venta', 1, '19.99', '19.99', 52, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(33, '2023-02-03', '33 - Producto C usado', 'compra', 6, '14.99', '89.94', 58, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(34, '2023-02-04', '34 - Producto D usado', 'venta', 3, '24.99', '74.97', 55, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(35, '2023-02-05', '35 - Producto E usado', 'compra', 4, '9.99', '39.96', 59, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(36, '2023-02-06', '36 - Producto F usado', 'venta', 2, '14.99', '29.98', 57, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(37, '2023-02-07', '37 - Producto G usado', 'compra', 5, '19.99', '99.95', 62, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(38, '2023-02-08', '38 - Producto H usado', 'venta', 3, '24.99', '74.97', 59, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(39, '2023-02-09', '39 - Producto I usado', 'compra', 2, '14.99', '29.98', 61, '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(40, '2023-02-10', '40 - Producto J usado', 'venta', 4, '19.99', '79.96', 57, '2023-06-01 05:53:04', '2023-06-01 05:53:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_categoria`
--

CREATE TABLE `tbl_categoria` (
  `Id_Categoria` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_categoria`
--

INSERT INTO `tbl_categoria` (`Id_Categoria`, `Nombre`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'Categoría 1', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, 'Categoría 2', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, 'Categoría 3', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, 'Categoría 4', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, 'Categoría 5', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, 'Categoría 6', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, 'Categoría 7', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, 'Categoría 8', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, 'Categoría 9', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, 'Categoría 10', '2023-06-01 05:53:04', '2023-06-01 05:53:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_cliente`
--

CREATE TABLE `tbl_cliente` (
  `Id_Cliente` int(11) NOT NULL,
  `Estatus` enum('activo','inactivo') NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Nit` varchar(20) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_cliente`
--

INSERT INTO `tbl_cliente` (`Id_Cliente`, `Estatus`, `Nombre`, `Direccion`, `Nit`, `Telefono`, `Email`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'activo', 'Cliente 1', 'Dirección 1', '1234567890', '1234567890', 'cliente1@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, 'activo', 'Cliente 2', 'Dirección 2', '0987654321', '0987654321', 'cliente2@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, 'inactivo', 'Cliente 3', 'Dirección 3', '9876543210', '9876543210', 'cliente3@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, 'activo', 'Cliente 4', 'Dirección 4', '0123456789', '0123456789', 'cliente4@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, 'inactivo', 'Cliente 5', 'Dirección 5', '5678901234', '5678901234', 'cliente5@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, 'activo', 'Cliente 6', 'Dirección 6', '3456789012', '3456789012', 'cliente6@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, 'activo', 'Cliente 7', 'Dirección 7', '9012345678', '9012345678', 'cliente7@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, 'inactivo', 'Cliente 8', 'Dirección 8', '4567890123', '4567890123', 'cliente8@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, 'activo', 'Cliente 9', 'Dirección 9', '2345678901', '2345678901', 'cliente9@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, 'inactivo', 'Cliente 10', 'Dirección 10', '7890123456', '7890123456', 'cliente10@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_compra`
--

CREATE TABLE `tbl_compra` (
  `Id_Compra` int(11) NOT NULL,
  `Id_Proveedor` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_compra`
--

INSERT INTO `tbl_compra` (`Id_Compra`, `Id_Proveedor`, `Fecha`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 1, '2023-05-01', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, 2, '2023-05-02', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, 3, '2023-05-03', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, 4, '2023-05-04', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, 5, '2023-05-05', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, 6, '2023-05-06', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, 7, '2023-05-07', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, 8, '2023-05-08', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, 9, '2023-05-09', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, 10, '2023-05-10', '2023-06-01 05:53:04', '2023-06-01 05:53:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detalle_compra`
--

CREATE TABLE `tbl_detalle_compra` (
  `Id_Detalle_Compra` int(11) NOT NULL,
  `Id_Compra` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Valor_Unitario` decimal(10,2) DEFAULT NULL,
  `Valor_Costo` decimal(10,2) NOT NULL,
  `Valor_Total` decimal(10,2) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_detalle_compra`
--

INSERT INTO `tbl_detalle_compra` (`Id_Detalle_Compra`, `Id_Compra`, `Id_Producto`, `Cantidad`, `Valor_Unitario`, `Valor_Costo`, `Valor_Total`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 1, 1, 3, '9.99', '8.50', '29.97', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, 1, 2, 2, '14.99', '12.50', '29.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, 2, 3, 1, '19.99', '17.50', '19.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, 2, 4, 4, '24.99', '22.50', '99.96', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, 2, 5, 2, '29.99', '27.50', '59.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, 2, 6, 3, '12.99', '10.50', '38.97', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, 3, 7, 2, '39.99', '37.50', '79.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, 3, 8, 3, '17.99', '15.50', '53.97', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, 4, 9, 4, '21.99', '19.50', '87.96', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, 4, 10, 2, '16.99', '14.50', '33.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(11, 5, 1, 3, '9.99', '8.50', '29.97', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(12, 5, 2, 2, '14.99', '12.50', '29.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(13, 5, 3, 1, '19.99', '17.50', '19.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(14, 6, 4, 4, '24.99', '22.50', '99.96', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(15, 6, 5, 2, '29.99', '27.50', '59.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(16, 6, 6, 3, '12.99', '10.50', '38.97', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(17, 7, 7, 2, '39.99', '37.50', '79.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(18, 7, 8, 3, '17.99', '15.50', '53.97', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(19, 8, 9, 4, '21.99', '19.50', '87.96', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(20, 8, 10, 2, '16.99', '14.50', '33.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(21, 9, 1, 3, '9.99', '8.50', '29.97', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(22, 10, 2, 2, '14.99', '12.50', '29.98', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(23, 10, 3, 1, '19.99', '17.50', '19.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04');

--
-- Disparadores `tbl_detalle_compra`
--
DELIMITER $$
CREATE TRIGGER `trigger_compra` AFTER INSERT ON `tbl_detalle_compra` FOR EACH ROW BEGIN
    -- Variables para almacenar los valores necesarios
    DECLARE cantidad INT;
    DECLARE tipo_transaccion VARCHAR(10);
    DECLARE nombre_producto VARCHAR(255);
    
    -- Obtener la cantidad y el nombre del producto
    SELECT NEW.Cantidad, p.Nombre INTO cantidad, nombre_producto
    FROM tbl_detalle_compra dc
    INNER JOIN tbl_producto p ON dc.Id_Producto = p.Id_Producto
    WHERE dc.Id_Detalle_Compra = NEW.Id_Detalle_Compra;
    
    -- Establecer el tipo de transacción como 'compra'
    SET tipo_transaccion = 'compra';
    
    -- Actualizar el stock en la tabla tbl_producto
    UPDATE tbl_producto
    SET Stock = Stock + cantidad
    WHERE Id_Producto = NEW.Id_Producto;
    
    -- Insertar registro en tbl_cardex
    INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
    VALUES (CURDATE(), nombre_producto, tipo_transaccion, cantidad, NEW.Valor_Unitario, cantidad * NEW.Valor_Unitario, (SELECT Stock FROM tbl_producto WHERE Id_Producto = NEW.Id_Producto));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_detalle_venta`
--

CREATE TABLE `tbl_detalle_venta` (
  `Id_Detalle_Venta` int(11) NOT NULL,
  `Id_Venta` int(11) NOT NULL,
  `Id_Producto` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Valor_Unitario` decimal(10,2) DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_detalle_venta`
--

INSERT INTO `tbl_detalle_venta` (`Id_Detalle_Venta`, `Id_Venta`, `Id_Producto`, `Cantidad`, `Valor_Unitario`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 1, 1, 3, '19.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, 1, 2, 2, '24.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, 1, 3, 1, '29.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, 2, 4, 4, '34.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, 2, 5, 2, '39.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, 2, 6, 3, '44.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, 2, 7, 1, '49.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, 3, 8, 3, '54.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, 3, 9, 4, '59.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, 3, 10, 5, '64.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(11, 4, 1, 2, '19.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(12, 4, 3, 3, '29.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(13, 4, 5, 4, '39.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(14, 4, 7, 5, '49.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(15, 4, 9, 1, '59.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(16, 5, 2, 3, '24.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(17, 5, 4, 2, '34.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(18, 5, 6, 4, '44.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(19, 5, 8, 1, '54.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(20, 5, 10, 2, '64.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(21, 6, 3, 4, '29.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(22, 6, 5, 3, '39.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(23, 6, 7, 2, '49.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(24, 6, 9, 1, '59.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(25, 7, 2, 2, '24.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(26, 7, 4, 3, '34.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(27, 7, 6, 4, '44.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(28, 7, 8, 5, '54.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(29, 8, 1, 3, '19.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(30, 8, 3, 4, '29.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(31, 8, 5, 2, '39.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(32, 9, 6, 3, '44.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(33, 9, 8, 4, '54.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(34, 9, 10, 5, '64.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(35, 10, 1, 2, '19.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(36, 10, 3, 3, '29.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(37, 10, 5, 4, '39.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(38, 10, 7, 5, '49.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(39, 10, 9, 1, '59.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04');

--
-- Disparadores `tbl_detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `trigger_venta` AFTER INSERT ON `tbl_detalle_venta` FOR EACH ROW BEGIN
    -- Variables para almacenar los valores necesarios
    DECLARE cantidad INT;
    DECLARE tipo_transaccion VARCHAR(10);
    
    -- Obtener la cantidad y el tipo de transacción
    SELECT NEW.Cantidad, 'venta' INTO cantidad, tipo_transaccion
    FROM tbl_detalle_venta
    WHERE Id_Detalle_Venta = NEW.Id_Detalle_Venta;
    
    -- Actualizar el stock en la tabla tbl_producto
    UPDATE tbl_producto
    SET Stock = Stock - cantidad
    WHERE Id_Producto = NEW.Id_Producto;
    
    -- Insertar registro en tbl_cardex
    INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
    VALUES (CURDATE(), (SELECT Nombre FROM tbl_producto WHERE Id_Producto = NEW.Id_Producto), tipo_transaccion, cantidad, NEW.Valor_Unitario, cantidad * NEW.Valor_Unitario, (SELECT Stock FROM tbl_producto WHERE Id_Producto = NEW.Id_Producto));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_producto`
--

CREATE TABLE `tbl_producto` (
  `Id_Producto` int(11) NOT NULL,
  `Id_Categoria` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `SKU` varchar(50) NOT NULL,
  `Estado` enum('activo','inactivo') NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Existencia_minima` int(11) DEFAULT NULL,
  `Existencia_maxima` int(11) DEFAULT NULL,
  `Stock` int(11) DEFAULT NULL,
  `Imagen` varchar(255) DEFAULT NULL,
  `Valor_Unitario` decimal(10,2) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_producto`
--

INSERT INTO `tbl_producto` (`Id_Producto`, `Id_Categoria`, `Nombre`, `SKU`, `Estado`, `Descripcion`, `Existencia_minima`, `Existencia_maxima`, `Stock`, `Imagen`, `Valor_Unitario`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 1, 'Producto 1', 'SKU001', 'activo', 'Descripción del Producto 1', 10, 100, 50, 'imagen1.jpg', '19.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, 1, 'Producto 2', 'SKU002', 'activo', 'Descripción del Producto 2', 5, 50, 30, 'imagen2.jpg', '9.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, 2, 'Producto 3', 'SKU003', 'activo', 'Descripción del Producto 3', 8, 80, 20, 'imagen3.jpg', '14.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, 2, 'Producto 4', 'SKU004', 'activo', 'Descripción del Producto 4', 10, 100, 70, 'imagen4.jpg', '24.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, 3, 'Producto 5', 'SKU005', 'activo', 'Descripción del Producto 5', 15, 150, 100, 'imagen5.jpg', '29.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, 3, 'Producto 6', 'SKU006', 'activo', 'Descripción del Producto 6', 5, 50, 40, 'imagen6.jpg', '12.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, 4, 'Producto 7', 'SKU007', 'activo', 'Descripción del Producto 7', 20, 200, 150, 'imagen7.jpg', '39.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, 4, 'Producto 8', 'SKU008', 'activo', 'Descripción del Producto 8', 5, 50, 10, 'imagen8.jpg', '17.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, 5, 'Producto 9', 'SKU009', 'activo', 'Descripción del Producto 9', 10, 100, 80, 'imagen9.jpg', '21.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, 5, 'Producto 10', 'SKU010', 'activo', 'Descripción del Producto 10', 5, 50, 25, 'imagen10.jpg', '16.99', '2023-06-01 05:53:04', '2023-06-01 05:53:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_proveedor`
--

CREATE TABLE `tbl_proveedor` (
  `Id_Proveedor` int(11) NOT NULL,
  `Estatus` enum('activo','inactivo') NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Nit` varchar(20) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_proveedor`
--

INSERT INTO `tbl_proveedor` (`Id_Proveedor`, `Estatus`, `Nombre`, `Direccion`, `Nit`, `Telefono`, `Email`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 'activo', 'Proveedor 1', 'Dirección 1', '1234567890', '1234567890', 'proveedor1@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, 'activo', 'Proveedor 2', 'Dirección 2', '0987654321', '0987654321', 'proveedor2@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, 'inactivo', 'Proveedor 3', 'Dirección 3', '9876543210', '9876543210', 'proveedor3@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, 'activo', 'Proveedor 4', 'Dirección 4', '0123456789', '0123456789', 'proveedor4@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, 'inactivo', 'Proveedor 5', 'Dirección 5', '5678901234', '5678901234', 'proveedor5@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, 'activo', 'Proveedor 6', 'Dirección 6', '3456789012', '3456789012', 'proveedor6@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, 'activo', 'Proveedor 7', 'Dirección 7', '9012345678', '9012345678', 'proveedor7@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, 'inactivo', 'Proveedor 8', 'Dirección 8', '4567890123', '4567890123', 'proveedor8@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, 'activo', 'Proveedor 9', 'Dirección 9', '2345678901', '2345678901', 'proveedor9@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, 'inactivo', 'Proveedor 10', 'Dirección 10', '7890123456', '7890123456', 'proveedor10@example.com', '2023-06-01 05:53:04', '2023-06-01 05:53:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_venta`
--

CREATE TABLE `tbl_venta` (
  `Id_Venta` int(11) NOT NULL,
  `Id_Cliente` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_venta`
--

INSERT INTO `tbl_venta` (`Id_Venta`, `Id_Cliente`, `Fecha`, `CreatedAt`, `UpdatedAt`) VALUES
(1, 1, '2023-05-01', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(2, 2, '2023-05-02', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(3, 3, '2023-05-03', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(4, 4, '2023-05-04', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(5, 5, '2023-05-05', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(6, 6, '2023-05-06', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(7, 7, '2023-05-07', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(8, 8, '2023-05-08', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(9, 9, '2023-05-09', '2023-06-01 05:53:04', '2023-06-01 05:53:04'),
(10, 10, '2023-05-10', '2023-06-01 05:53:04', '2023-06-01 05:53:04');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_cardex`
--
ALTER TABLE `tbl_cardex`
  ADD PRIMARY KEY (`Id_Cardex`);

--
-- Indices de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  ADD PRIMARY KEY (`Id_Categoria`);

--
-- Indices de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  ADD PRIMARY KEY (`Id_Cliente`);

--
-- Indices de la tabla `tbl_compra`
--
ALTER TABLE `tbl_compra`
  ADD PRIMARY KEY (`Id_Compra`),
  ADD KEY `Id_Proveedor` (`Id_Proveedor`);

--
-- Indices de la tabla `tbl_detalle_compra`
--
ALTER TABLE `tbl_detalle_compra`
  ADD PRIMARY KEY (`Id_Detalle_Compra`),
  ADD KEY `Id_Compra` (`Id_Compra`),
  ADD KEY `Id_Producto` (`Id_Producto`);

--
-- Indices de la tabla `tbl_detalle_venta`
--
ALTER TABLE `tbl_detalle_venta`
  ADD PRIMARY KEY (`Id_Detalle_Venta`),
  ADD KEY `Id_Venta` (`Id_Venta`),
  ADD KEY `Id_Producto` (`Id_Producto`);

--
-- Indices de la tabla `tbl_producto`
--
ALTER TABLE `tbl_producto`
  ADD PRIMARY KEY (`Id_Producto`),
  ADD KEY `Id_Categoria` (`Id_Categoria`);

--
-- Indices de la tabla `tbl_proveedor`
--
ALTER TABLE `tbl_proveedor`
  ADD PRIMARY KEY (`Id_Proveedor`);

--
-- Indices de la tabla `tbl_venta`
--
ALTER TABLE `tbl_venta`
  ADD PRIMARY KEY (`Id_Venta`),
  ADD KEY `Id_Cliente` (`Id_Cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_cardex`
--
ALTER TABLE `tbl_cardex`
  MODIFY `Id_Cardex` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  MODIFY `Id_Categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tbl_cliente`
--
ALTER TABLE `tbl_cliente`
  MODIFY `Id_Cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tbl_compra`
--
ALTER TABLE `tbl_compra`
  MODIFY `Id_Compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tbl_detalle_compra`
--
ALTER TABLE `tbl_detalle_compra`
  MODIFY `Id_Detalle_Compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `tbl_detalle_venta`
--
ALTER TABLE `tbl_detalle_venta`
  MODIFY `Id_Detalle_Venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `tbl_proveedor`
--
ALTER TABLE `tbl_proveedor`
  MODIFY `Id_Proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tbl_venta`
--
ALTER TABLE `tbl_venta`
  MODIFY `Id_Venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_compra`
--
ALTER TABLE `tbl_compra`
  ADD CONSTRAINT `tbl_compra_ibfk_1` FOREIGN KEY (`Id_Proveedor`) REFERENCES `tbl_proveedor` (`Id_Proveedor`);

--
-- Filtros para la tabla `tbl_detalle_compra`
--
ALTER TABLE `tbl_detalle_compra`
  ADD CONSTRAINT `tbl_detalle_compra_ibfk_1` FOREIGN KEY (`Id_Compra`) REFERENCES `tbl_compra` (`Id_Compra`),
  ADD CONSTRAINT `tbl_detalle_compra_ibfk_2` FOREIGN KEY (`Id_Producto`) REFERENCES `tbl_producto` (`Id_Producto`);

--
-- Filtros para la tabla `tbl_detalle_venta`
--
ALTER TABLE `tbl_detalle_venta`
  ADD CONSTRAINT `tbl_detalle_venta_ibfk_1` FOREIGN KEY (`Id_Venta`) REFERENCES `tbl_venta` (`Id_Venta`),
  ADD CONSTRAINT `tbl_detalle_venta_ibfk_2` FOREIGN KEY (`Id_Producto`) REFERENCES `tbl_producto` (`Id_Producto`);

--
-- Filtros para la tabla `tbl_producto`
--
ALTER TABLE `tbl_producto`
  ADD CONSTRAINT `tbl_producto_ibfk_1` FOREIGN KEY (`Id_Categoria`) REFERENCES `tbl_categoria` (`Id_Categoria`);

--
-- Filtros para la tabla `tbl_venta`
--
ALTER TABLE `tbl_venta`
  ADD CONSTRAINT `tbl_venta_ibfk_1` FOREIGN KEY (`Id_Cliente`) REFERENCES `tbl_cliente` (`Id_Cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
