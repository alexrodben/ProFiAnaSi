DROP DATABASE IF EXISTS inventory_control;
CREATE DATABASE inventory_control; USE inventory_control;
-- Tabla: tbl_proveedor

CREATE TABLE tbl_proveedor ( Id_Proveedor INT PRIMARY KEY AUTO_INCREMENT, Estatus ENUM('activo', 'inactivo') NOT NULL, Nombre VARCHAR(255) NOT NULL, Direccion VARCHAR(255) NOT NULL, Nit VARCHAR(20) NOT NULL, Telefono VARCHAR(20) NOT NULL, Email VARCHAR(255) NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP );
-- Tabla: tbl_categoria

CREATE TABLE tbl_categoria ( Id_Categoria INT PRIMARY KEY AUTO_INCREMENT, Nombre VARCHAR(255) NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP );
-- Tabla: tbl_producto

CREATE TABLE tbl_producto ( Id_Producto INT PRIMARY KEY, Id_Categoria INT NOT NULL, Nombre VARCHAR(255) NOT NULL, SKU VARCHAR(50) NOT NULL, Estado ENUM('activo', 'inactivo') NOT NULL, Descripcion TEXT, Existencia_minima INT, Existencia_maxima INT, Stock INT, Imagen VARCHAR(255), Valor_Unitario DECIMAL(10, 2) NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, FOREIGN KEY (Id_Categoria) REFERENCES tbl_categoria (Id_Categoria) );
-- Tabla: tbl_cliente

CREATE TABLE tbl_cliente ( Id_Cliente INT PRIMARY KEY AUTO_INCREMENT, Estatus ENUM('activo', 'inactivo') NOT NULL, Nombre VARCHAR(255) NOT NULL, Direccion VARCHAR(255) NOT NULL, Nit VARCHAR(20) NOT NULL, Telefono VARCHAR(20) NOT NULL, Email VARCHAR(255) NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP );
-- Tabla: tbl__compra

CREATE TABLE tbl_compra ( Id_Compra INT PRIMARY KEY AUTO_INCREMENT, Id_Proveedor INT NOT NULL, Fecha DATE NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, FOREIGN KEY (Id_Proveedor) REFERENCES tbl_proveedor (Id_Proveedor) );
-- Tabla: tbl_detalle_compra

CREATE TABLE tbl_detalle_compra ( Id_Detalle_Compra INT PRIMARY KEY AUTO_INCREMENT, Id_Compra INT NOT NULL, Id_Producto INT NOT NULL, Cantidad INT DEFAULT NULL, Valor_Unitario DECIMAL(10, 2), Valor_Costo DECIMAL(10, 2) NOT NULL, Valor_Total DECIMAL(10, 2) NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, FOREIGN KEY (Id_Compra) REFERENCES tbl_compra (Id_Compra), FOREIGN KEY (Id_Producto) REFERENCES tbl_producto (Id_Producto) );
-- Tabla: tbl_venta

CREATE TABLE tbl_venta ( Id_Venta INT PRIMARY KEY AUTO_INCREMENT, Id_Cliente INT NOT NULL, Fecha DATE NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, FOREIGN KEY (Id_Cliente) REFERENCES tbl_cliente (Id_Cliente) );
-- Tabla: tbl_detalle_venta

CREATE TABLE tbl_detalle_venta ( Id_Detalle_Venta INT PRIMARY KEY AUTO_INCREMENT, Id_Venta INT NOT NULL, Id_Producto INT NOT NULL, Cantidad INT, Valor_Unitario DECIMAL(10, 2), CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, FOREIGN KEY (Id_Venta) REFERENCES tbl_venta (Id_Venta), FOREIGN KEY (Id_Producto) REFERENCES tbl_producto (Id_Producto) );
-- Detalles de venta para la Venta con Id_Venta = 1

CREATE TABLE tbl_cardex ( Id_Cardex INT PRIMARY KEY AUTO_INCREMENT, Fecha DATE NOT NULL, Detalle VARCHAR(255) NOT NULL, Tipo_Transaccion ENUM('compra', 'venta') NOT NULL, Cantidad INT NOT NULL, Valor_Unitario DECIMAL(10, 2) NOT NULL, Valor_Total DECIMAL(10, 2) NOT NULL, Stock INT NOT NULL, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP, UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP );