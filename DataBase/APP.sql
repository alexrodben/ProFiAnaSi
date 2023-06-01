DROP DATABASE IF EXISTS inventory_control;
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
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Proveedor 1', 'Dirección 1', '1234567890', '1234567890', 'proveedor1@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Proveedor 2', 'Dirección 2', '0987654321', '0987654321', 'proveedor2@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('inactivo', 'Proveedor 3', 'Dirección 3', '9876543210', '9876543210', 'proveedor3@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Proveedor 4', 'Dirección 4', '0123456789', '0123456789', 'proveedor4@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('inactivo', 'Proveedor 5', 'Dirección 5', '5678901234', '5678901234', 'proveedor5@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Proveedor 6', 'Dirección 6', '3456789012', '3456789012', 'proveedor6@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Proveedor 7', 'Dirección 7', '9012345678', '9012345678', 'proveedor7@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('inactivo', 'Proveedor 8', 'Dirección 8', '4567890123', '4567890123', 'proveedor8@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Proveedor 9', 'Dirección 9', '2345678901', '2345678901', 'proveedor9@example.com');

INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('inactivo', 'Proveedor 10', 'Dirección 10', '7890123456', '7890123456', 'proveedor10@example.com');

-- Tabla: tbl_categoria
CREATE TABLE tbl_categoria (
  Id_Categoria INT PRIMARY KEY AUTO_INCREMENT,
  Nombre VARCHAR(255) NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 1');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 2');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 3');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 4');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 5');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 6');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 7');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 8');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 9');

INSERT INTO tbl_categoria (Nombre)
VALUES ('Categoría 10');


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

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (1, 1, 'Producto 1', 'SKU001', 'activo', 'Descripción del Producto 1', 10, 100, 50, 'imagen1.jpg', 19.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (2, 1, 'Producto 2', 'SKU002', 'activo', 'Descripción del Producto 2', 5, 50, 30, 'imagen2.jpg', 9.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (3, 2, 'Producto 3', 'SKU003', 'activo', 'Descripción del Producto 3', 8, 80, 20, 'imagen3.jpg', 14.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (4, 2, 'Producto 4', 'SKU004', 'activo', 'Descripción del Producto 4', 10, 100, 70, 'imagen4.jpg', 24.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (5, 3, 'Producto 5', 'SKU005', 'activo', 'Descripción del Producto 5', 15, 150, 100, 'imagen5.jpg', 29.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (6, 3, 'Producto 6', 'SKU006', 'activo', 'Descripción del Producto 6', 5, 50, 40, 'imagen6.jpg', 12.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (7, 4, 'Producto 7', 'SKU007', 'activo', 'Descripción del Producto 7', 20, 200, 150, 'imagen7.jpg', 39.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (8, 4, 'Producto 8', 'SKU008', 'activo', 'Descripción del Producto 8', 5, 50, 10, 'imagen8.jpg', 17.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (9, 5, 'Producto 9', 'SKU009', 'activo', 'Descripción del Producto 9', 10, 100, 80, 'imagen9.jpg', 21.99);

INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario)
VALUES (10, 5, 'Producto 10', 'SKU010', 'activo', 'Descripción del Producto 10', 5, 50, 25, 'imagen10.jpg', 16.99);

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

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Cliente 1', 'Dirección 1', '1234567890', '1234567890', 'cliente1@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Cliente 2', 'Dirección 2', '0987654321', '0987654321', 'cliente2@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('inactivo', 'Cliente 3', 'Dirección 3', '9876543210', '9876543210', 'cliente3@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Cliente 4', 'Dirección 4', '0123456789', '0123456789', 'cliente4@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('inactivo', 'Cliente 5', 'Dirección 5', '5678901234', '5678901234', 'cliente5@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Cliente 6', 'Dirección 6', '3456789012', '3456789012', 'cliente6@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Cliente 7', 'Dirección 7', '9012345678', '9012345678', 'cliente7@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('inactivo', 'Cliente 8', 'Dirección 8', '4567890123', '4567890123', 'cliente8@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('activo', 'Cliente 9', 'Dirección 9', '2345678901', '2345678901', 'cliente9@example.com');

INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email)
VALUES ('inactivo', 'Cliente 10', 'Dirección 10', '7890123456', '7890123456', 'cliente10@example.com');

-- Tabla: tbl_compra
CREATE TABLE tbl_compra (
  Id_Compra INT PRIMARY KEY AUTO_INCREMENT,
  Id_Proveedor INT NOT NULL,
  Fecha DATE NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Proveedor) REFERENCES tbl_proveedor (Id_Proveedor)
);

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (1, '2023-05-01');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (2, '2023-05-02');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (3, '2023-05-03');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (4, '2023-05-04');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (5, '2023-05-05');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (6, '2023-05-06');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (7, '2023-05-07');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (8, '2023-05-08');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (9, '2023-05-09');

INSERT INTO tbl_compra (Id_Proveedor, Fecha)
VALUES (10, '2023-05-10');

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

-- Detalles de compra para la Compra con Id_Compra = 1
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (1, 1, 3, 9.99, 8.50, 29.97);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (1, 2, 2, 14.99, 12.50, 29.98);

-- Detalles de compra para la Compra con Id_Compra = 2
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (2, 3, 1, 19.99, 17.50, 19.99);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (2, 4, 4, 24.99, 22.50, 99.96);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (2, 5, 2, 29.99, 27.50, 59.98);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (2, 6, 3, 12.99, 10.50, 38.97);

-- Detalles de compra para la Compra con Id_Compra = 3
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (3, 7, 2, 39.99, 37.50, 79.98);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (3, 8, 3, 17.99, 15.50, 53.97);

-- Detalles de compra para la Compra con Id_Compra = 4
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (4, 9, 4, 21.99, 19.50, 87.96);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (4, 10, 2, 16.99, 14.50, 33.98);

-- Detalles de compra para la Compra con Id_Compra = 5
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (5, 1, 3, 9.99, 8.50, 29.97);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (5, 2, 2, 14.99, 12.50, 29.98);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (5, 3, 1, 19.99, 17.50, 19.99);

-- Detalles de compra para la Compra con Id_Compra = 6
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (6, 4, 4, 24.99, 22.50, 99.96);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (6, 5, 2, 29.99, 27.50, 59.98);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (6, 6, 3, 12.99, 10.50, 38.97);

-- Detalles de compra para la Compra con Id_Compra = 7
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (7, 7, 2, 39.99, 37.50, 79.98);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (7, 8, 3, 17.99, 15.50, 53.97);

-- Detalles de compra para la Compra con Id_Compra = 8
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (8, 9, 4, 21.99, 19.50, 87.96);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (8, 10, 2, 16.99, 14.50, 33.98);

-- Detalles de compra para la Compra con Id_Compra = 9
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (9, 1, 3, 9.99, 8.50, 29.97);

-- Detalles de compra para la Compra con Id_Compra = 10
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (10, 2, 2, 14.99, 12.50, 29.98);

INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total)
VALUES (10, 3, 1, 19.99, 17.50, 19.99);



-- Tabla: tbl_venta
CREATE TABLE tbl_venta (
  Id_Venta INT PRIMARY KEY AUTO_INCREMENT,
  Id_Cliente INT NOT NULL,
  Fecha DATE NOT NULL,
  CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (Id_Cliente) REFERENCES tbl_cliente (Id_Cliente)
);

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (1, '2023-05-01');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (2, '2023-05-02');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (3, '2023-05-03');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (4, '2023-05-04');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (5, '2023-05-05');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (6, '2023-05-06');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (7, '2023-05-07');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (8, '2023-05-08');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (9, '2023-05-09');

INSERT INTO tbl_venta (Id_Cliente, Fecha)
VALUES (10, '2023-05-10');


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
-- Detalles de venta para la Venta con Id_Venta = 1
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (1, 1, 3, 19.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (1, 2, 2, 24.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (1, 3, 1, 29.99);

-- Detalles de venta para la Venta con Id_Venta = 2
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (2, 4, 4, 34.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (2, 5, 2, 39.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (2, 6, 3, 44.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (2, 7, 1, 49.99);

-- Detalles de venta para la Venta con Id_Venta = 3
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (3, 8, 3, 54.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (3, 9, 4, 59.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (3, 10, 5, 64.99);

-- Detalles de venta para la Venta con Id_Venta = 4
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (4, 1, 2, 19.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (4, 3, 3, 29.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (4, 5, 4, 39.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (4, 7, 5, 49.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (4, 9, 1, 59.99);

-- Detalles de venta para la Venta con Id_Venta = 5
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (5, 2, 3, 24.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (5, 4, 2, 34.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (5, 6, 4, 44.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (5, 8, 1, 54.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (5, 10, 2, 64.99);

-- Detalles de venta para la Venta con Id_Venta = 6
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (6, 3, 4, 29.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (6, 5, 3, 39.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (6, 7, 2, 49.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (6, 9, 1, 59.99);

-- Detalles de venta para la Venta con Id_Venta = 7
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (7, 2, 2, 24.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (7, 4, 3, 34.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (7, 6, 4, 44.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (7, 8, 5, 54.99);

-- Detalles de venta para la Venta con Id_Venta = 8
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (8, 1, 3, 19.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (8, 3, 4, 29.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (8, 5, 2, 39.99);

-- Detalles de venta para la Venta con Id_Venta = 9
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (9, 6, 3, 44.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (9, 8, 4, 54.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (9, 10, 5, 64.99);

-- Detalles de venta para la Venta con Id_Venta = 10
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (10, 1, 2, 19.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (10, 3, 3, 29.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (10, 5, 4, 39.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (10, 7, 5, 49.99);

INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario)
VALUES (10, 9, 1, 59.99);

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

-- Transacción 1: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-01', '1 - Producto A usado', 'compra', 10, 9.99, 99.90, 10);

-- Transacción 2: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-02', '2 - Producto B usado', 'venta', 5, 19.99, 99.95, 5);

-- Transacción 3: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-03', '3 - Producto C usado', 'compra', 8, 14.99, 119.92, 13);

-- Transacción 4: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-04', '4 - Producto D usado', 'venta', 3, 24.99, 74.97, 10);

-- Transacción 5: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-05', '5 - Producto E usado', 'compra', 12, 9.99, 119.88, 22);

-- Transacción 6: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-06', '6 - Producto F usado', 'venta', 7, 14.99, 104.93, 15);

-- Transacción 7: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-07', '7 - Producto G usado', 'compra', 6, 19.99, 119.94, 21);

-- Transacción 8: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-08', '8 - Producto H usado', 'venta', 4, 24.99, 99.96, 17);

-- Transacción 9: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-09', '9 - Producto I usado', 'compra', 9, 14.99, 134.91, 26);

-- Transacción 10: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-10', '10 - Producto J usado', 'venta', 2, 19.99, 39.98, 24);

-- Transacción 11: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-11', '11 - Producto A usado', 'compra', 7, 9.99, 69.93, 31);

-- Transacción 12: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-12', '12 - Producto B usado', 'venta', 3, 19.99, 59.97, 28);

-- Transacción 13: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-13', '13 - Producto C usado', 'compra', 5, 14.99, 74.95, 33);

-- Transacción 14: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-14', '14 - Producto D usado', 'venta', 2, 24.99, 49.98, 31);

-- Transacción 15: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-15', '15 - Producto E usado', 'compra', 10, 9.99, 99.90, 41);

-- Transacción 16: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-16', '16 - Producto F usado', 'venta', 4, 14.99, 59.96, 37);

-- Transacción 17: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-17', '17 - Producto G usado', 'compra', 8, 19.99, 159.92, 45);

-- Transacción 18: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-18', '18 - Producto H usado', 'venta', 5, 24.99, 124.95, 40);

-- Transacción 19: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-19', '19 - Producto I usado', 'compra', 6, 14.99, 89.94, 46);

-- Transacción 20: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-20', '20 - Producto J usado', 'venta', 3, 19.99, 59.97, 43);

-- Transacción 21: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-21', '21 - Producto A usado', 'compra', 6, 9.99, 59.94, 49);

-- Transacción 22: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-22', '22 - Producto B usado', 'venta', 2, 19.99, 39.98, 47);

-- Transacción 23: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-23', '23 - Producto C usado', 'compra', 4, 14.99, 59.96, 51);

-- Transacción 24: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-24', '24 - Producto D usado', 'venta', 3, 24.99, 74.97, 48);

-- Transacción 25: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-25', '25 - Producto E usado', 'compra', 5, 9.99, 49.95, 53);

-- Transacción 26: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-26', '26 - Producto F usado', 'venta', 2, 14.99, 29.98, 51);

-- Transacción 27: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-27', '27 - Producto G usado', 'compra', 3, 19.99, 59.97, 54);

-- Transacción 28: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-28', '28 - Producto H usado', 'venta', 4, 24.99, 99.96, 50);

-- Transacción 29: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-29', '29 - Producto I usado', 'compra', 2, 14.99, 29.98, 52);

-- Transacción 30: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-01-30', '30 - Producto J usado', 'venta', 3, 19.99, 59.97, 49);

-- Transacción 31: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-01', '31 - Producto A usado', 'compra', 4, 9.99, 39.96, 53);

-- Transacción 32: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-02', '32 - Producto B usado', 'venta', 1, 19.99, 19.99, 52);

-- Transacción 33: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-03', '33 - Producto C usado', 'compra', 6, 14.99, 89.94, 58);

-- Transacción 34: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-04', '34 - Producto D usado', 'venta', 3, 24.99, 74.97, 55);

-- Transacción 35: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-05', '35 - Producto E usado', 'compra', 4, 9.99, 39.96, 59);

-- Transacción 36: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-06', '36 - Producto F usado', 'venta', 2, 14.99, 29.98, 57);

-- Transacción 37: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-07', '37 - Producto G usado', 'compra', 5, 19.99, 99.95, 62);

-- Transacción 38: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-08', '38 - Producto H usado', 'venta', 3, 24.99, 74.97, 59);

-- Transacción 39: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-09', '39 - Producto I usado', 'compra', 2, 14.99, 29.98, 61);

-- Transacción 40: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock)
VALUES ('2023-02-10', '40 - Producto J usado', 'venta', 4, 19.99, 79.96, 57);


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


