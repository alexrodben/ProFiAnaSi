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

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'ASUS', 'Guatemala', 'NIT002', '56956958', 'Asus2@example.com'),
('activo', 'Intel', 'Costa Rica', 'NIT001', '34567890', 'Intel1@example.com'),
('activo', 'INTEL', 'Peru', 'NIT003', '45968412', 'Intel3@example.com'),
('inactivo', 'AMD', 'Argentina', 'NIT004', '79256414', 'AMD4@example.com'),
('activo', 'Lenovo', 'Mexico', 'NIT005', '39502154', 'Lenov@example.com'),
('activo', 'Dell', 'Guatemala', 'NIT006', '16548214', 'Dell@example.com'),
('inactivo', 'HP', 'Ecuador', 'NIT007', '65412372', 'HP7@example.com'),
('activo', 'Intel', 'Costa Rica', 'NIT008', '45632147', 'Intel8@example.com'),
('inactivo', 'AMD', 'Mexico', 'NIT009', '56214874', 'AMD9@example.com'),
('activo', 'ASUS', 'Bolivia', 'NIT010', '45212541', 'ASUS@example.com');

select * from tbl_proveedor;

INSERT INTO tbl_categoria (Nombre)
VALUES ('Redes'),
('Desarrollo'),
('Mantenimiento'),
('Redes'),
('Desarrollo');

select * from tbl_categoria;

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (1, 1, 'RAM', 'SKU001', 'activo', 'Componente', 10, 100, 50, 'imagen1.jpg', 9.99),
(2, 1, 'CPU', 'SKU002', 'activo', 'Componente', 5, 50, 20, 'imagen2.jpg', 19.99),
(3, 2, 'Procesador', 'SKU003', 'inactivo', 'Componente', 8, 80, 30, 'imagen3.jpg', 14.99),
(4, 2, 'Mouse', 'SKU004', 'activo', 'Componente', 12, 120, 60, 'imagen4.jpg', 7.99),
(5, 3, 'Teclado', 'SKU005', 'inactivo', 'Componente', 15, 150, 75, 'imagen5.jpg', 11.99),
(6, 3, 'Cámara', 'SKU006', 'activo', 'Componente', 6, 60, 25, 'imagen6.jpg', 8.99),
(7, 3, 'Disco duro', 'SKU007', 'inactivo', 'Componente', 9, 90, 40, 'imagen7.jpg', 17.99);

select * from tbl_producto;

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Alison Blanco', 'Sanarate', '1052', '25413521', 'alisonb1@gmail.com'),
('activo', 'Pedro Perez', 'Guastatoya', '1254', '45142412', 'pedrop2@hotmail.com'),
('activo', 'Karla Orellana', 'Sansare', '6574', '55231421', 'karlao@outlook.com'),
('inactivo', 'María Gomez', 'Ciudad de Guatemala', '5241', '45142414', 'mariag@gmail.com'),
('activo', 'Jose Fuentes', 'Sanarate', '23417', '52361424', 'josef@hotmail.com'),
('inactivo', 'Alicia González', 'Guastatoya', '56142', '42143525', 'alicia@outlook.com'),
('inactivo', 'Luis Prado', 'Sanarate', '26415', '36241354', 'luispr@gmail.com');

select * from tbl_cliente;

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (1, '2023-05-01'),
(2, '2023-05-02'),
(3, '2023-05-03'),
(4, '2023-05-04'),
(5, '2023-05-05');

select * from tbl_compra;

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (1, 1, 5, 9.99, 49.95, 49.95),
(1, 2, 3, 19.99, 59.97, 59.97),
(2, 1, 10, 9.99, 99.90, 99.90),
(2, 3, 8, 14.99, 119.92, 119.92),
(3, 2, 2, 19.99, 39.98, 39.98),
(3, 3, 5, 14.99, 74.95, 74.95);

select * from tbl_detalle_compra;

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (1, '2021-04-01'),
(2, '2022-05-12'),
(3, '2022-02-22'),
(4, '2019-01-04'),
(5, '2023-02-05');

select * from tbl_venta;

INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2022-12-01', 'Compra de producto A', 'compra', 50, 9.99, 499.50, 50),
('2021-05-15', 'Venta de producto A', 'venta', 10, 12.99, 129.90, 40),
('2018-03-03', 'Compra de producto B', 'compra', 30, 19.99, 599.70, 70),
('2022-05-04', 'Venta de producto B', 'venta', 15, 22.99, 344.85, 55),
('2020-10-05', 'Compra de producto C', 'compra', 20, 14.99, 299.80, 75),
('2019-05-06', 'Venta de producto C', 'venta', 8, 17.99, 143.92, 67),
('2023-11-07', 'Compra de producto D', 'compra', 25, 24.99, 624.75, 92),
('2020-12-13', 'Venta de producto D', 'venta', 12, 29.99, 359.88, 80),
('2019-01-12', 'Compra de producto E', 'compra', 35, 16.99, 594.65, 115),
('2020-05-10', 'Venta de producto E', 'venta', 18, 19.99, 359.82, 97);

select * from tbl_ctbl_cardex;
