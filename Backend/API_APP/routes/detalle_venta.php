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
      $detalleVentaId = $_GET['id'];
      handleGetDetalleVentaItem($database, $detalleVentaId);
    } else {
      handleGetDetalleVenta($database);
    }
    break;
  case 'POST': // add
    handlePostDetalleVenta($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "detalle_venta: Método no permitido"));
    break;
}

function handleGetDetalleVenta($database)
{
  // Ejecutar el procedimiento almacenado para obtener todos los detalles de venta
  $result = $database->query("CALL sp_mostrar_detalle_venta()");

  if ($result->num_rows > 0) {
    $detallesVenta = array();
    while ($row = $result->fetch_assoc()) {
      $detallesVenta[] = $row;
    }
    http_response_code(200);
    echo json_encode($detallesVenta);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron detalles de venta."));
  }
}

function handleGetDetalleVentaItem($database, $detalleVentaId)
{
  // Ejecutar el procedimiento almacenado para obtener un detalle de venta específico
  $stmt = $database->prepare("CALL sp_item_detalle_venta(?)");
  $stmt->bind_param("i", $detalleVentaId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $detalleVenta = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($detalleVenta);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Detalle de venta no encontrado."));
  }
}

function handlePostDetalleVenta($database)
{
  // Obtener los datos enviados en la solicitud POST y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $ventaId = $data['id_venta'];
  $productoId = $data['id_producto'];
  $cantidad = $data['cantidad'];
  $valorUnitario = $data['valor_unitario'];

  // Ejecutar el procedimiento almacenado para insertar un nuevo detalle de venta
  $stmt = $database->prepare("CALL sp_insertar_detalle_venta(?, ?, ?, ?)");
  $stmt->bind_param("iiid", $ventaId, $productoId, $cantidad, $valorUnitario);
  if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Detalle de venta creado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear el detalle de venta."));
  }
}

$database->close();
?>