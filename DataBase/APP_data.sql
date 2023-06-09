USE inventory_control;
-- Tabla: tbl_proveedor
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Proveedor 1', 'Dirección 1', '1234567890', '1234567890', 'proveedor1@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Proveedor 2', 'Dirección 2', '0987654321', '0987654321', 'proveedor2@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('inactivo', 'Proveedor 3', 'Dirección 3', '9876543210', '9876543210', 'proveedor3@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Proveedor 4', 'Dirección 4', '0123456789', '0123456789', 'proveedor4@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('inactivo', 'Proveedor 5', 'Dirección 5', '5678901234', '5678901234', 'proveedor5@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Proveedor 6', 'Dirección 6', '3456789012', '3456789012', 'proveedor6@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Proveedor 7', 'Dirección 7', '9012345678', '9012345678', 'proveedor7@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('inactivo', 'Proveedor 8', 'Dirección 8', '4567890123', '4567890123', 'proveedor8@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Proveedor 9', 'Dirección 9', '2345678901', '2345678901', 'proveedor9@example.com');
INSERT INTO tbl_proveedor (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('inactivo', 'Proveedor 10', 'Dirección 10', '7890123456', '7890123456', 'proveedor10@example.com');
-- Tabla: tbl_categoria
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 1');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 2');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 3');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 4');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 5');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 6');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 7');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 8');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 9');
INSERT INTO tbl_categoria (Nombre) VALUES ('Categoría 10');
-- Tabla: tbl_producto
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (1, 1, 'Producto 1', 'SKU001', 'activo', 'Descripción del Producto 1', 10, 100, 50, 'imagen1.jpg', 19.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (2, 1, 'Producto 2', 'SKU002', 'activo', 'Descripción del Producto 2', 5, 50, 30, 'imagen2.jpg', 9.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (3, 2, 'Producto 3', 'SKU003', 'activo', 'Descripción del Producto 3', 8, 80, 20, 'imagen3.jpg', 14.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (4, 2, 'Producto 4', 'SKU004', 'activo', 'Descripción del Producto 4', 10, 100, 70, 'imagen4.jpg', 24.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (5, 3, 'Producto 5', 'SKU005', 'activo', 'Descripción del Producto 5', 15, 150, 100, 'imagen5.jpg', 29.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (6, 3, 'Producto 6', 'SKU006', 'activo', 'Descripción del Producto 6', 5, 50, 40, 'imagen6.jpg', 12.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (7, 4, 'Producto 7', 'SKU007', 'activo', 'Descripción del Producto 7', 20, 200, 150, 'imagen7.jpg', 39.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (8, 4, 'Producto 8', 'SKU008', 'activo', 'Descripción del Producto 8', 5, 50, 10, 'imagen8.jpg', 17.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (9, 5, 'Producto 9', 'SKU009', 'activo', 'Descripción del Producto 9', 10, 100, 80, 'imagen9.jpg', 21.99);
INSERT INTO tbl_producto (Id_Producto, Id_Categoria, Nombre, SKU, Estado, Descripcion, Existencia_minima, Existencia_maxima, Stock, Imagen, Valor_Unitario) VALUES (10, 5, 'Producto 10', 'SKU010', 'activo', 'Descripción del Producto 10', 5, 50, 25, 'imagen10.jpg', 16.99);
-- Tabla: tbl_cliente
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Cliente 1', 'Dirección 1', '1234567890', '1234567890', 'cliente1@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Cliente 2', 'Dirección 2', '0987654321', '0987654321', 'cliente2@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('inactivo', 'Cliente 3', 'Dirección 3', '9876543210', '9876543210', 'cliente3@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Cliente 4', 'Dirección 4', '0123456789', '0123456789', 'cliente4@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('inactivo', 'Cliente 5', 'Dirección 5', '5678901234', '5678901234', 'cliente5@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Cliente 6', 'Dirección 6', '3456789012', '3456789012', 'cliente6@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Cliente 7', 'Dirección 7', '9012345678', '9012345678', 'cliente7@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('inactivo', 'Cliente 8', 'Dirección 8', '4567890123', '4567890123', 'cliente8@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('activo', 'Cliente 9', 'Dirección 9', '2345678901', '2345678901', 'cliente9@example.com');
INSERT INTO tbl_cliente (Estatus, Nombre, Direccion, Nit, Telefono, Email) VALUES ('inactivo', 'Cliente 10', 'Dirección 10', '7890123456', '7890123456', 'cliente10@example.com');
-- Tabla: tbl_compra
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (1, '2023-05-01');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (2, '2023-05-02');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (3, '2023-05-03');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (4, '2023-05-04');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (5, '2023-05-05');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (6, '2023-05-06');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (7, '2023-05-07');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (8, '2023-05-08');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (9, '2023-05-09');
INSERT INTO tbl_compra (Id_Proveedor, Fecha) VALUES (10, '2023-05-10');
-- Tabla: tbl_detalle_compra
-- Detalles de compra para la Compra con Id_Compra = 1
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (1, 1, 3, 9.99, 8.50, 29.97);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (1, 2, 2, 14.99, 12.50, 29.98);
-- Detalles de compra para la Compra con Id_Compra = 2
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (2, 3, 1, 19.99, 17.50, 19.99);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (2, 4, 4, 24.99, 22.50, 99.96);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (2, 5, 2, 29.99, 27.50, 59.98);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (2, 6, 3, 12.99, 10.50, 38.97);
-- Detalles de compra para la Compra con Id_Compra = 3
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (3, 7, 2, 39.99, 37.50, 79.98);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (3, 8, 3, 17.99, 15.50, 53.97);
-- Detalles de compra para la Compra con Id_Compra = 4
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (4, 9, 4, 21.99, 19.50, 87.96);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (4, 10, 2, 16.99, 14.50, 33.98);
-- Detalles de compra para la Compra con Id_Compra = 5
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (5, 1, 3, 9.99, 8.50, 29.97);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (5, 2, 2, 14.99, 12.50, 29.98);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (5, 3, 1, 19.99, 17.50, 19.99);
-- Detalles de compra para la Compra con Id_Compra = 6
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (6, 4, 4, 24.99, 22.50, 99.96);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (6, 5, 2, 29.99, 27.50, 59.98);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (6, 6, 3, 12.99, 10.50, 38.97);
-- Detalles de compra para la Compra con Id_Compra = 7
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (7, 7, 2, 39.99, 37.50, 79.98);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (7, 8, 3, 17.99, 15.50, 53.97);
-- Detalles de compra para la Compra con Id_Compra = 8
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (8, 9, 4, 21.99, 19.50, 87.96);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (8, 10, 2, 16.99, 14.50, 33.98);
-- Detalles de compra para la Compra con Id_Compra = 9
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (9, 1, 3, 9.99, 8.50, 29.97);
-- Detalles de compra para la Compra con Id_Compra = 10
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (10, 2, 2, 14.99, 12.50, 29.98);
INSERT INTO tbl_detalle_compra (Id_Compra, Id_Producto, Cantidad, Valor_Unitario, Valor_Costo, Valor_Total) VALUES (10, 3, 1, 19.99, 17.50, 19.99);
-- Tabla: tbl_venta
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (1, '2023-05-01');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (2, '2023-05-02');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (3, '2023-05-03');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (4, '2023-05-04');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (5, '2023-05-05');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (6, '2023-05-06');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (7, '2023-05-07');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (8, '2023-05-08');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (9, '2023-05-09');
INSERT INTO tbl_venta (Id_Cliente, Fecha) VALUES (10, '2023-05-10');
-- Tabla: tbl_detalle_venta
-- Detalles de venta para la Venta con Id_Venta = 1
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (1, 1, 3, 19.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (1, 2, 2, 24.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (1, 3, 1, 29.99);
-- Detalles de venta para la Venta con Id_Venta = 2
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (2, 4, 4, 34.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (2, 5, 2, 39.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (2, 6, 3, 44.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (2, 7, 1, 49.99);
-- Detalles de venta para la Venta con Id_Venta = 3
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (3, 8, 3, 54.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (3, 9, 4, 59.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (3, 10, 5, 64.99);
-- Detalles de venta para la Venta con Id_Venta = 4
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (4, 1, 2, 19.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (4, 3, 3, 29.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (4, 5, 4, 39.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (4, 7, 5, 49.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (4, 9, 1, 59.99);
-- Detalles de venta para la Venta con Id_Venta = 5
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (5, 2, 3, 24.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (5, 4, 2, 34.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (5, 6, 4, 44.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (5, 8, 1, 54.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (5, 10, 2, 64.99);
-- Detalles de venta para la Venta con Id_Venta = 6
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (6, 3, 4, 29.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (6, 5, 3, 39.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (6, 7, 2, 49.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (6, 9, 1, 59.99);
-- Detalles de venta para la Venta con Id_Venta = 7
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (7, 2, 2, 24.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (7, 4, 3, 34.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (7, 6, 4, 44.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (7, 8, 5, 54.99);
-- Detalles de venta para la Venta con Id_Venta = 8
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (8, 1, 3, 19.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (8, 3, 4, 29.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (8, 5, 2, 39.99);
-- Detalles de venta para la Venta con Id_Venta = 9
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (9, 6, 3, 44.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (9, 8, 4, 54.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (9, 10, 5, 64.99);
-- Detalles de venta para la Venta con Id_Venta = 10
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (10, 1, 2, 19.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (10, 3, 3, 29.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (10, 5, 4, 39.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (10, 7, 5, 49.99);
INSERT INTO tbl_detalle_venta (Id_Venta, Id_Producto, Cantidad, Valor_Unitario) VALUES (10, 9, 1, 59.99);
-- Tabla: tbl_cardex
-- Transacción 1: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-01', '1 - Producto A usado', 'compra', 10, 9.99, 99.90, 10);
-- Transacción 2: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-02', '2 - Producto B usado', 'venta', 5, 19.99, 99.95, 5);
-- Transacción 3: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-03', '3 - Producto C usado', 'compra', 8, 14.99, 119.92, 13);
-- Transacción 4: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-04', '4 - Producto D usado', 'venta', 3, 24.99, 74.97, 10);
-- Transacción 5: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-05', '5 - Producto E usado', 'compra', 12, 9.99, 119.88, 22);
-- Transacción 6: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-06', '6 - Producto F usado', 'venta', 7, 14.99, 104.93, 15);
-- Transacción 7: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-07', '7 - Producto G usado', 'compra', 6, 19.99, 119.94, 21);
-- Transacción 8: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-08', '8 - Producto H usado', 'venta', 4, 24.99, 99.96, 17);
-- Transacción 9: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-09', '9 - Producto I usado', 'compra', 9, 14.99, 134.91, 26);
-- Transacción 10: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-10', '10 - Producto J usado', 'venta', 2, 19.99, 39.98, 24);
-- Transacción 11: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-11', '11 - Producto A usado', 'compra', 7, 9.99, 69.93, 31);
-- Transacción 12: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-12', '12 - Producto B usado', 'venta', 3, 19.99, 59.97, 28);
-- Transacción 13: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-13', '13 - Producto C usado', 'compra', 5, 14.99, 74.95, 33);
-- Transacción 14: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-14', '14 - Producto D usado', 'venta', 2, 24.99, 49.98, 31);
-- Transacción 15: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-15', '15 - Producto E usado', 'compra', 10, 9.99, 99.90, 41);
-- Transacción 16: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-16', '16 - Producto F usado', 'venta', 4, 14.99, 59.96, 37);
-- Transacción 17: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-17', '17 - Producto G usado', 'compra', 8, 19.99, 159.92, 45);
-- Transacción 18: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-18', '18 - Producto H usado', 'venta', 5, 24.99, 124.95, 40);
-- Transacción 19: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-19', '19 - Producto I usado', 'compra', 6, 14.99, 89.94, 46);
-- Transacción 20: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-20', '20 - Producto J usado', 'venta', 3, 19.99, 59.97, 43);
-- Transacción 21: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-21', '21 - Producto A usado', 'compra', 6, 9.99, 59.94, 49);
-- Transacción 22: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-22', '22 - Producto B usado', 'venta', 2, 19.99, 39.98, 47);
-- Transacción 23: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-23', '23 - Producto C usado', 'compra', 4, 14.99, 59.96, 51);
-- Transacción 24: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-24', '24 - Producto D usado', 'venta', 3, 24.99, 74.97, 48);
-- Transacción 25: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-25', '25 - Producto E usado', 'compra', 5, 9.99, 49.95, 53);
-- Transacción 26: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-26', '26 - Producto F usado', 'venta', 2, 14.99, 29.98, 51);
-- Transacción 27: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-27', '27 - Producto G usado', 'compra', 3, 19.99, 59.97, 54);
-- Transacción 28: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-28', '28 - Producto H usado', 'venta', 4, 24.99, 99.96, 50);
-- Transacción 29: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-29', '29 - Producto I usado', 'compra', 2, 14.99, 29.98, 52);
-- Transacción 30: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-01-30', '30 - Producto J usado', 'venta', 3, 19.99, 59.97, 49);
-- Transacción 31: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-01', '31 - Producto A usado', 'compra', 4, 9.99, 39.96, 53);
-- Transacción 32: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-02', '32 - Producto B usado', 'venta', 1, 19.99, 19.99, 52);
-- Transacción 33: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-03', '33 - Producto C usado', 'compra', 6, 14.99, 89.94, 58);
-- Transacción 34: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-04', '34 - Producto D usado', 'venta', 3, 24.99, 74.97, 55);
-- Transacción 35: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-05', '35 - Producto E usado', 'compra', 4, 9.99, 39.96, 59);
-- Transacción 36: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-06', '36 - Producto F usado', 'venta', 2, 14.99, 29.98, 57);
-- Transacción 37: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-07', '37 - Producto G usado', 'compra', 5, 19.99, 99.95, 62);
-- Transacción 38: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-08', '38 - Producto H usado', 'venta', 3, 24.99, 74.97, 59);
-- Transacción 39: Compra
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-09', '39 - Producto I usado', 'compra', 2, 14.99, 29.98, 61);
-- Transacción 40: Venta
INSERT INTO tbl_cardex (Fecha, Detalle, Tipo_Transaccion, Cantidad, Valor_Unitario, Valor_Total, Stock) VALUES ('2023-02-10', '40 - Producto J usado', 'venta', 4, 19.99, 79.96, 57); DELIMITER $$