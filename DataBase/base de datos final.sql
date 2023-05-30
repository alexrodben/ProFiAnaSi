CREATE DATABASE inventory_control;
USE inventory_control;

-- Tabla: tbl_proveedor
CREATE TABLE tbl_proveedor (
  Id_Proveedor INT PRIMARY KEY AUTO_INCREMENT,
  Estatus ENUM('activo', 'inactivo') NOT NULL,
  Nombre VARCHAR(255) NOT NULL,
  Direccion VARCHAR(255) NOT NULL,
  Nit VARCHAR(20) NOT NULL,
  Telefono VARCHAR(20) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla: tbl_categoria
CREATE TABLE tbl_categoria (
  Id_Categoria INT PRIMARY KEY AUTO_INCREMENT,
  Nombre VARCHAR(255) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Tabla: tbl_producto
CREATE TABLE tbl_producto (
  Id_Producto INT PRIMARY KEY,
  Id_Categoria INT NOT NULL,
  Nombre VARCHAR(255) NOT NULL,
  SKU VARCHAR(50) NOT NULL,
  Estado ENUM('activo', 'inactivo') NOT NULL,
  Descripcion TEXT,
  Existencia_minima INT,
  Existencia_maxima INT,
  Stock INT,
  Imagen VARCHAR(255),
  Valor_Unitario DECIMAL(10, 2) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Categoria) REFERENCES tbl_categoria (Id_Categoria)
);

-- Tabla: tbl_cliente
CREATE TABLE tbl_cliente (
  Id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
  Estatus ENUM('activo', 'inactivo') NOT NULL,
  Nombre VARCHAR(255) NOT NULL,
  Direccion VARCHAR(255) NOT NULL,
  Nit VARCHAR(20) NOT NULL,
  Telefono VARCHAR(20) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla: tbl_compra
CREATE TABLE tbl_compra (
  Id_Compra INT PRIMARY KEY AUTO_INCREMENT,
  Id_Proveedor INT NOT NULL,
  Fecha DATE NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Proveedor) REFERENCES tbl_proveedor (Id_Proveedor)
);

-- Tabla: tbl_detalle_compra
CREATE TABLE tbl_detalle_compra (
  Id_Detalle_Compra INT PRIMARY KEY AUTO_INCREMENT,
  Id_Compra INT NOT NULL,
  Id_Producto INT NOT NULL,
  Cantidad INT DEFAULT NULL,
  Valor_Unitario DECIMAL(10, 2),
  Valor_Costo DECIMAL(10, 2) NOT NULL,
  Valor_Total DECIMAL(10, 2) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Compra) REFERENCES tbl_compra (Id_Compra),
  FOREIGN KEY (Id_Producto) REFERENCES tbl_producto (Id_Producto)
);


-- Tabla: tbl_venta
CREATE TABLE tbl_venta (
  Id_Venta INT PRIMARY KEY AUTO_INCREMENT,
  Id_Cliente INT NOT NULL,
  Fecha DATE NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Cliente) REFERENCES tbl_cliente (Id_Cliente)
);

-- Tabla: tbl_detalle_venta
CREATE TABLE tbl_detalle_venta (
  Id_Detalle_Venta INT PRIMARY KEY AUTO_INCREMENT,
  Id_Venta INT NOT NULL,
  Id_Producto INT NOT NULL,
  Cantidad INT,
  Valor_Unitario DECIMAL(10, 2),
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Venta) REFERENCES tbl_venta (Id_Venta),
  FOREIGN KEY (Id_Producto) REFERENCES tbl_producto (Id_Producto)
);

-- Tabla: tbl_cardex
CREATE TABLE tbl_cardex (
  Id_Cardex INT PRIMARY KEY AUTO_INCREMENT,
  Fecha DATE NOT NULL,
  Detalle VARCHAR(255) NOT NULL,
  Tipo_Transaccion ENUM('compra', 'venta') NOT NULL,
  Cantidad INT NOT NULL,
  Valor_Unitario DECIMAL(10, 2) NOT NULL,
  Valor_Total DECIMAL(10, 2) NOT NULL,
  Stock INT NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Tabla: tbl_pedidos
CREATE TABLE tbl_pedidos (
  Id_Pedido INT PRIMARY KEY AUTO_INCREMENT,
  Id_Venta INT NOT NULL,
  Id_Cliente INT NOT NULL,
  Monto_Total DECIMAL(10, 2) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Venta) REFERENCES tbl_venta (Id_Venta),
  FOREIGN KEY (Id_Cliente) REFERENCES tbl_cliente (Id_Cliente)
);


DELIMITER $$
CREATE TRIGGER trigger_compra AFTER INSERT ON tbl_detalle_compra FOR EACH ROW
BEGIN
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
END$$
DELIMITER ;



drop trigger trigger_venta;




DELIMITER $$
CREATE TRIGGER trigger_venta AFTER INSERT ON tbl_detalle_venta
FOR EACH ROW
BEGIN
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
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_insertar_proveedor(
    IN p_estatus ENUM('activo', 'inactivo'),
    IN p_nombre VARCHAR(255),
    IN p_direccion VARCHAR(255),
    IN p_nit VARCHAR(20),
    IN p_telefono VARCHAR(20),
    IN p_email VARCHAR(255)
)
BEGIN
    INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
    VALUES (p_estatus, p_nombre, p_direccion, p_nit, p_telefono, p_email);
END$$
DELIMITER ;

