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
    IN p_Estatus ENUM('activo', 'inactivo'),
    IN p_Nombre VARCHAR(255),
    IN p_Direccion VARCHAR(255),
    IN p_Nit VARCHAR(20),
    IN p_Telefono VARCHAR(20),
    IN p_Email VARCHAR(255)
)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_insertar_categoria(
    IN p_Nombre VARCHAR(255)
)
BEGIN
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
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_insertar_cliente(
    IN p_Estatus ENUM('activo', 'inactivo'),
    IN p_Nombre VARCHAR(255),
    IN p_Direccion VARCHAR(255),
    IN p_Nit VARCHAR(20),
    IN p_Telefono VARCHAR(20),
    IN p_Email VARCHAR(255)
)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_insertar_compra(
    IN p_Id_Proveedor INT,
    IN p_Fecha DATE
)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_insertar_detalle_compra(
    IN p_Id_Compra INT,
    IN p_Id_Producto INT,
    IN p_Cantidad INT,
    IN p_Valor_Unitario DECIMAL(10, 2),
    IN p_Valor_Costo DECIMAL(10, 2),
    IN p_Valor_Total DECIMAL(10, 2)
)
BEGIN
    INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total, CreatedAt)
    VALUES (p_Id_Compra, p_Id_Producto, p_Cantidad, p_Valor_Unitario, p_Valor_Costo, p_Valor_Total, CURRENT_TIMESTAMP);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_insertar_venta(
    IN p_Id_Cliente INT,
    IN p_Fecha DATE
)
BEGIN
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
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_insertar_detalle_venta(
    IN p_Id_Venta INT,
    IN p_Id_Producto INT,
    IN p_Cantidad INT,
    IN p_Valor_Unitario DECIMAL(10, 2)
)
BEGIN
    INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario, CreatedAt)
    VALUES (p_Id_Venta, p_Id_Producto, p_Cantidad, p_Valor_Unitario, CURRENT_TIMESTAMP);
END$$
DELIMITER ;
DELIMITER $$
CREATE PROCEDURE sp_insertar_producto(
    IN p_Id_Producto INT,
    IN p_Id_Categoria INT,
    IN p_Nombre VARCHAR(255),
    IN p_SKU VARCHAR(50),
    IN p_Estado ENUM('activo', 'inactivo'),
    IN p_Descripcion TEXT,
    IN p_Existencia_Minima INT,
    IN p_Existencia_Maxima INT,
    IN p_Stock INT,
    IN p_Imagen VARCHAR(255),
    IN p_Valor_Unitario DECIMAL(10, 2)
)
BEGIN
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
    
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_editar_proveedor(
    IN p_Id_Proveedor INT,
    IN p_Estatus ENUM('activo', 'inactivo'),
    IN p_Nombre VARCHAR(255),
    IN p_Direccion VARCHAR(255),
    IN p_Nit VARCHAR(20),
    IN p_Telefono VARCHAR(20),
    IN p_Email VARCHAR(255)
)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_editar_categoria(
    IN p_Id_Categoria INT,
    IN p_Nombre VARCHAR(255)
)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_editar_producto(
    IN p_Id_Producto INT,
    IN p_Id_Categoria INT,
    IN p_Nombre VARCHAR(255),
    IN p_SKU VARCHAR(50),
    IN p_Estado ENUM('activo', 'inactivo'),
    IN p_Descripcion TEXT,
    IN p_Existencia_Minima INT,
    IN p_Existencia_Maxima INT,
    IN p_Stock INT,
    IN p_Imagen VARCHAR(255),
    IN p_Valor_Unitario DECIMAL(10, 2)
)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_editar_cliente(
    IN p_Id_Cliente INT,
    IN p_Estatus ENUM('activo', 'inactivo'),
    IN p_Nombre VARCHAR(255),
    IN p_Direccion VARCHAR(255),
    IN p_Nit VARCHAR(20),
    IN p_Telefono VARCHAR(20),
    IN p_Email VARCHAR(255)
)
BEGIN
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
DELIMITER ;  

DELIMITER $$
CREATE PROCEDURE sp_actualizar_proveedor_inactivo(IN p_Id_Proveedor INT)
BEGIN
    IF EXISTS(SELECT * FROM tbl_proveedor WHERE Id_Proveedor = p_Id_Proveedor AND Estatus = 'activo') THEN
        UPDATE tbl_proveedor SET Estatus = 'inactivo' WHERE Id_Proveedor = p_Id_Proveedor;
        SELECT 'Proveedor actualizado a inactivo correctamente.' AS Message;
    ELSE
        SELECT 'El proveedor no existe o ya está inactivo.' AS Message;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_actualizar_cliente_inactivo(IN p_Id_Cliente INT)
BEGIN
    IF EXISTS(SELECT * FROM tbl_cliente WHERE Id_Cliente = p_Id_Cliente AND Estatus = 'activo') THEN
        UPDATE tbl_cliente SET Estatus = 'inactivo' WHERE Id_Cliente = p_Id_Cliente;
        SELECT 'Cliente actualizado a inactivo correctamente.' AS Message;
    ELSE
        SELECT 'El cliente no existe o ya está inactivo.' AS Message;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_actualizar_producto_inactivo(IN p_Id_Producto INT)
BEGIN
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
DELIMITER ;


