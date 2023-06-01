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
      $detalleCompraId = $_GET['id'];
      handleGetDetalleCompraItem($database, $detalleCompraId);
    } else {
      handleGetDetalleCompra($database);
    }
    break;
  case 'POST': // add
    handlePostDetalleCompra($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "detalle_compra: Método no permitido"));
    break;
}

function handleGetDetalleCompra($database)
{
  // Ejecutar el procedimiento almacenado para obtener todos los detalles de compra
  $result = $database->query("CALL sp_mostrar_detalle_compra()");

  if ($result->num_rows > 0) {
    $detallesCompra = array();
    while ($row = $result->fetch_assoc()) {
      $detallesCompra[] = $row;
    }
    http_response_code(200);
    echo json_encode($detallesCompra);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron detalles de compra."));
  }
}

function handleGetDetalleCompraItem($database, $detalleCompraId)
{
  // Ejecutar el procedimiento almacenado para obtener un detalle de compra específico
  $stmt = $database->prepare("CALL sp_item_detalle_compra(?)");
  $stmt->bind_param("i", $detalleCompraId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $detalleCompra = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($detalleCompra);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Detalle de compra no encontrado."));
  }
}

function handlePostDetalleCompra($database)
{
  // Obtener los datos enviados en la solicitud POST y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $compraId = $data['id_compra'];
  $productoId = $data['id_producto'];
  $cantidad = $data['cantidad'];
  $valorUnitario = $data['valor_unitario'];
  $valorCosto = $data['valor_costo'];
  $valorTotal = $data['valor_total'];

  // Ejecutar el procedimiento almacenado para insertar un nuevo detalle de compra
  $stmt = $database->prepare("CALL sp_insertar_detalle_compra(?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("iiidd", $compraId, $productoId, $cantidad, $valorUnitario, $valorCosto, $valorTotal);
  if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Detalle de compra creado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear el detalle de compra."));
  }
}

$database->close();
?>