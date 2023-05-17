create database inventarios;

use inventarios;

CREATE TABLE tbl_productos (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  descripcion VARCHAR(255),
  precio DECIMAL(10, 2)
);
-- agregar estado activo/inactivo

CREATE TABLE tbl_transacciones (
  id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
  id_producto INT,
  tipo_transaccion ENUM('Entrada', 'Salida'),
  cantidad INT,
  fecha_transaccion DATE,
  FOREIGN KEY (id_producto) REFERENCES tbl_productos(id_producto)
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

CREATE TABLE tbl_proveedor_producto (
  id_proveedor INT,
  id_producto INT,
  PRIMARY KEY (id_proveedor, id_producto),
  FOREIGN KEY (id_proveedor) REFERENCES tbl_proveedores(id_proveedor),
  FOREIGN KEY (id_producto) REFERENCES tbl_productos(id_producto)
);

CREATE TABLE tbl_kardex (
  id_producto INT,
  fecha DATE,
  entradas INT,
  salidas INT,
  cantidad_actual INT,
  PRIMARY KEY (id_producto, fecha),
  FOREIGN KEY (id_producto) REFERENCES tbl_productos(id_producto)
);

CREATE TABLE tbl_bitacora (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fecha TIMESTAMP,
  descripcion VARCHAR(255),
  tipo_transaccion ENUM('Entrada', 'Salida')
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

  UPDATE tbl_stock
  SET cantidad_actual = cantidad_actual + NEW.cantidad
  WHERE id_producto = NEW.id_producto
  ORDER BY fecha_actualizacion DESC
  LIMIT 1;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER bitacora_transacciones
AFTER INSERT ON tbl_transacciones
FOR EACH ROW
BEGIN
  INSERT INTO tbl_bitacora (fecha, descripcion)
  VALUES (NOW(), CONCAT('Se insertó una nueva transacción con ID ', NEW.id_transaccion));
END$$
DELIMITER ;
