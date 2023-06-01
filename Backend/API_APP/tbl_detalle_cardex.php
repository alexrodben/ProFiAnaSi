<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetDetalleCardex($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Detalle Cardex: Método no permitido"));
    break;
}

function handleGetDetalleCardex($database)
{
  try {
    $query = "SELECT * FROM tbl_detalle_cardex";
    $result = $database->query($query);
    if ($result->num_rows > 0) {
      $data = array();
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      http_response_code(200);
      echo json_encode($data);
    } else {
      http_response_code(404);
      echo json_encode(array("message" => "Detalle Cardex: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

$database->close();
?>
