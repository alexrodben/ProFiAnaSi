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
      $ventaId = $_GET['id'];
      handleGetVentaItem($database, $ventaId);
    } else {
      handleGetVenta($database);
    }
    break;
  case 'POST': // add
    handlePostVenta($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "venta: Método no permitido"));
    break;
}

function handleGetVenta($database)
{
  // Ejecutar el procedimiento almacenado para obtener todas las ventas
  $result = $database->query("CALL sp_mostrar_venta()");

  if ($result->num_rows > 0) {
    $ventas = array();
    while ($row = $result->fetch_assoc()) {
      $ventas[] = $row;
    }
    http_response_code(200);
    echo json_encode($ventas);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron ventas."));
  }
}

function handleGetVentaItem($database, $ventaId)
{
  // Ejecutar el procedimiento almacenado para obtener una venta específica
  $stmt = $database->prepare("CALL sp_item_venta(?)");
  $stmt->bind_param("i", $ventaId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $venta = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($venta);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Venta no encontrada."));
  }
}

function handlePostVenta($database)
{
  // Obtener los datos enviados en la solicitud POST y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $clienteId = $data['id_cliente'];
  $fecha = $data['fecha'];

  // Ejecutar el procedimiento almacenado para insertar una nueva venta
  $stmt = $database->prepare("CALL sp_insertar_venta(?, ?)");
  $stmt->bind_param("is", $clienteId, $fecha);
  if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Venta creada exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear la venta."));
  }
}

$database->close();
?>
