create database inventarios;

use inventarios;

CREATE TABLE tbl_productos (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  descripcion VARCHAR(255),
  precio DECIMAL(10, 2),
  estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo'
);



CREATE TABLE tbl_stock (
  id_producto INT,
  fecha_actualizacion DATE,
  cantidad_actual INT,
  PRIMARY KEY (id_producto, fecha_actualizacion),
  FOREIGN KEY (id_producto) REFERENCES tbl_productos(id_producto)
);

CREATE TABLE tbl_proveedores (
  id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  direccion VARCHAR(255),
  telefono VARCHAR(20)
);

CREATE TABLE tbl_transacciones (
  id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
  id_producto INT,
  id_proveedor INT,
  tipo_transaccion ENUM('Entrada', 'Salida'),
  cantidad INT,
  fecha_transaccion DATE,
  FOREIGN KEY (id_producto) REFERENCES tbl_productos(id_producto),
  FOREIGN KEY (id_proveedor) REFERENCES tbl_proveedores(id_proveedor)
);

CREATE TABLE tbl_proveedor_producto (
  id_proveedor INT,
  id_producto INT,
  PRIMARY KEY (id_proveedor, id_producto),
  FOREIGN KEY (id_proveedor) REFERENCES tbl_proveedores(id_proveedor),
  FOREIGN KEY (id_producto) REFERENCES tbl_productos(id_producto)
);

CREATE TABLE tbl_kardex (
  id_kardex INT AUTO_INCREMENT PRIMARY KEY,
  id_producto INT,
  fecha DATE,
  entradas INT,
  salidas INT,
  cantidad_actual INT,
  FOREIGN KEY (id_producto) REFERENCES tbl_productos(id_producto)
);

CREATE TABLE tbl_bitacora (
  id_bitacora INT AUTO_INCREMENT PRIMARY KEY,
  fecha TIMESTAMP,
  descripcion VARCHAR(255),
  tipo_transaccion ENUM('Entrada', 'Salida'),
  id_producto INT,
  FOREIGN KEY (id_producto) REFERENCES tbl_productos(id_producto)
);



DELIMITER $$
CREATE TRIGGER actualizar_kardex_stock AFTER INSERT ON tbl_transacciones 
FOR EACH ROW
BEGIN
  DECLARE cantidad_entradas INT;
  DECLARE cantidad_salidas INT;
  DECLARE cantidad_actual INT;

  SELECT SUM(CASE WHEN tipo_transaccion = 'Entrada' THEN cantidad ELSE 0 END) INTO cantidad_entradas
  FROM tbl_transacciones
  WHERE id_producto = NEW.id_producto;

  SELECT SUM(CASE WHEN tipo_transaccion = 'Salida' THEN cantidad ELSE 0 END) INTO cantidad_salidas
  FROM tbl_transacciones
  WHERE id_producto = NEW.id_producto;

  SET cantidad_actual = IFNULL(cantidad_entradas, 0) - IFNULL(cantidad_salidas, 0);

  INSERT INTO tbl_kardex (id_producto, fecha, entradas, salidas, cantidad_actual)
  VALUES (NEW.id_producto, NEW.fecha_transaccion, IFNULL(cantidad_entradas, 0), IFNULL(cantidad_salidas, 0), cantidad_actual)
  ON DUPLICATE KEY UPDATE
    entradas = IFNULL(cantidad_entradas, 0),
    salidas = IFNULL(cantidad_salidas, 0),
    cantidad_actual = cantidad_actual;

  INSERT INTO tbl_stock (id_producto, fecha_actualizacion, cantidad_actual)
  VALUES (NEW.id_producto, NEW.fecha_transaccion, cantidad_actual)
  ON DUPLICATE KEY UPDATE
    cantidad_actual = cantidad_actual + NEW.cantidad;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER bitacora_transacciones
AFTER INSERT ON tbl_transacciones
FOR EACH ROW
BEGIN
  DECLARE proveedor_id INT;

  -- Obtener el ID del proveedor asociado a la transacción
  SELECT id_proveedor INTO proveedor_id
  FROM tbl_transacciones
  WHERE id_transaccion = NEW.id_transaccion;

  -- Insertar el registro en tbl_bitacora incluyendo el ID del proveedor
  INSERT INTO tbl_bitacora (id_transaccion, fecha, descripcion, tipo_transaccion, id_producto, id_proveedor)
  VALUES (NEW.id_transaccion, NOW(), CONCAT('Se insertó una nueva transacción con ID ', NEW.id_transaccion), NEW.tipo_transaccion, NEW.id_producto, proveedor_id);
END$$
DELIMITER ;

INSERT INTO tbl_productos (nombre, descripcion, precio)
VALUES
  ('Mouse', 'Marca: Argom', 11.50),
  ('Monitor', 'Marca: Dell', 17.75),
  ('CPU', 'Marca: HP', 22.00),
  ('Procesador', 'Marca: AMD', 16.99),
  ('Teclado', 'Marca: Argom', 18.50);
  
INSERT INTO tbl_transacciones (id_producto, id_proveedor, tipo_transaccion, cantidad, fecha_transaccion)
VALUES (1, 1, 'Entrada', 10, '2023-05-01'),
       (2, 1, 'Entrada', 5, '2023-05-02'),
       (1, 2, 'Salida', 3, '2023-05-03'),
       (3, 2, 'Entrada', 8, '2023-05-04'),
       (4, 3, 'Entrada', 2, '2023-05-05'),
       (2, 3, 'Salida', 4, '2023-05-06'),
       (3, 1, 'Salida', 6, '2023-05-07'),
       (1, 2, 'Entrada', 7, '2023-05-08'),
       (4, 3, 'Salida', 1, '2023-05-09'),
       (5, 1, 'Entrada', 9, '2023-05-10');

-- Insertar datos en tbl_proveedores
INSERT INTO tbl_proveedores (nombre, direccion, telefono)
VALUES
  ('Intel', 'Ciudad: Guatemala', '1234567894'),
  ('AMD', 'Ciudad: Lima', '9876543212'),
  ('Snapdragon', 'Ciudad: Lima', '5555555557');

-- Insertar datos en tbl_proveedor_producto
INSERT INTO tbl_proveedor_producto (id_proveedor, id_producto) VALUES
  (1, 5),
  (1, 3),
  (2, 1),
  (2, 2),
  (3, 1);

SELECT * FROM tbl_kardex;
SELECT * FROM tbl_bitacora;
SELECT * FROM tbl_transacciones;
SELECT * FROM tbl_proveedor_producto;



