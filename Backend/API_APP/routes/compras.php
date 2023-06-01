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
      $compraId = $_GET['id'];
      handleGetCompraItem($database, $compraId);
    } else {
      handleGetCompra($database);
    }
    break;
  case 'POST': // add
    handlePostCompra($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "compra: Método no permitido"));
    break;
}

function handleGetCompra($database)
{
  // Ejecutar el procedimiento almacenado para obtener todas las compras
  $result = $database->query("CALL sp_mostrar_compra()");

  if ($result->num_rows > 0) {
    $compras = array();
    while ($row = $result->fetch_assoc()) {
      $compras[] = $row;
    }
    http_response_code(200);
    echo json_encode($compras);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron compras."));
  }
}

function handleGetCompraItem($database, $compraId)
{
  // Ejecutar el procedimiento almacenado para obtener una compra específica
  $stmt = $database->prepare("CALL sp_item_compra(?)");
  $stmt->bind_param("i", $compraId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $compra = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($compra);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Compra no encontrada."));
  }
}

function handlePostCompra($database)
{
  // Obtener los datos enviados en la solicitud POST y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $proveedorId = $data['id_proveedor'];
  $fecha = $data['fecha'];

  // Ejecutar el procedimiento almacenado para insertar una nueva compra
  $stmt = $database->prepare("CALL sp_insertar_compra(?, ?)");
  $stmt->bind_param("is", $proveedorId, $fecha);
  if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Compra creada exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear la compra."));
  }
}

$database->close();
?>