<?php
include_once './dbconfig.php';

$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET': // getAll
    if (isset($_GET['id'])) {
      $productoId = $_GET['id'];
      handleGetProducto($database, $productoId);
    } else {
      handleGetProductos($database);
    }
    break;
  case 'POST': // add
    handlePostProductos($database);
    break;
  case 'PUT': // update
    handleUpdateProductos($database);
    break;
  case 'DELETE': // delete
    handleDeleteProductos($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "productos: Método no permitido"));
    break;
}

function handleGetProductos($database)
{
  // Ejecutar el procedimiento almacenado para obtener todos los productos
  $result = $database->query("CALL sp_mostrar_producto()");

  if ($result->num_rows > 0) {
    $productos = array();
    while ($row = $result->fetch_assoc()) {
      $productos[] = $row;
    }
    http_response_code(200);
    echo json_encode($productos);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron productos."));
  }
}

function handleGetProducto($database, $productoId)
{
  // Ejecutar el procedimiento almacenado para obtener un producto específico
  $stmt = $database->prepare("CALL sp_item_producto(?)");
  $stmt->bind_param("i", $productoId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $producto = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($producto);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Producto no encontrado."));
  }
}

function handlePostProductos($database)
{
  // Obtener los datos enviados en la solicitud POST y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $idCategoria = $data['id_categoria'];
  $nombre = $data['nombre'];
  $sku = $data['sku'];
  $estado = $data['estado'];
  $descripcion = $data['descripcion'];
  $existenciaMinima = $data['existencia_minima'];
  $existenciaMaxima = $data['existencia_maxima'];
  $stock = $data['stock'];
  $imagen = $data['imagen'];
  $valorUnitario = $data['valor_unitario'];

  // Ejecutar el procedimiento almacenado para insertar un nuevo producto
  $stmt = $database->prepare("CALL sp_insertar_producto(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("issisiiids", $idCategoria, $nombre, $sku, $estado, $descripcion, $existenciaMinima, $existenciaMaxima, $stock, $imagen, $valorUnitario);
  if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Producto creado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear el producto."));
  }
}

function handleUpdateProductos($database)
{
  // Obtener los datos enviados en la solicitud PUT y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $productoId = $data['id_producto'];
  $idCategoria = $data['id_categoria'];
  $nombre = $data['nombre'];
  $sku = $data['sku'];
  $estado = $data['estado'];
  $descripcion = $data['descripcion'];
  $existenciaMinima = $data['existencia_minima'];
  $existenciaMaxima = $data['existencia_maxima'];
  $stock = $data['stock'];
  $imagen = $data['imagen'];
  $valorUnitario = $data['valor_unitario'];

  // Ejecutar el procedimiento almacenado para actualizar un producto existente
  $stmt = $database->prepare("CALL sp_editar_producto(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("iissisiiids", $productoId, $idCategoria, $nombre, $sku, $estado, $descripcion, $existenciaMinima, $existenciaMaxima, $stock, $imagen, $valorUnitario);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Producto actualizado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo actualizar el producto."));
  }
}

function handleDeleteProductos($database)
{
  // Obtener los datos enviados en la solicitud DELETE y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $productoId = $data['id'];

  // Ejecutar el procedimiento almacenado para eliminar un producto
  $stmt = $database->prepare("CALL sp_eliminar_producto(?)");
  $stmt->bind_param("i", $productoId);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Producto eliminado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo eliminar el producto."));
  }
}
$database->close();
?>