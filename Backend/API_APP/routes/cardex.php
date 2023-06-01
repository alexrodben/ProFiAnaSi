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
      $cardexId = $_GET['id'];
      handleGetCardexItem($database, $cardexId);
    } else {
      handleGetCardex($database);
    }
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "cardex: Método no permitido"));
    break;
}

function handleGetCardex($database)
{
  // Ejecutar el procedimiento almacenado para obtener todos los registros de cardex
  $result = $database->query("CALL sp_mostrar_cardex()");

  if ($result->num_rows > 0) {
    $cardex = array();
    while ($row = $result->fetch_assoc()) {
      $cardex[] = $row;
    }
    http_response_code(200);
    echo json_encode($cardex);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron registros de cardex."));
  }
}

function handleGetCardexItem($database, $cardexId)
{
  // Ejecutar el procedimiento almacenado para obtener un registro de cardex específico
  $stmt = $database->prepare("CALL sp_item_cardex(?)");
  $stmt->bind_param("i", $cardexId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $cardexItem = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($cardexItem);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Registro de cardex no encontrado."));
  }
}

$database->close();
?>