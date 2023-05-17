<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);

if ($database->connect_error) {
  http_response_code(500);
  echo json_encode(array("message" => $database->connect_error));
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetRespuestasAdmin($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Respuestas: Método no permitido"));
    break;
}

function handleGetRespuestasAdmin($database)
{
  $id_encuesta = isset($_GET["id_encuesta"]) ? $_GET["id_encuesta"] : 0;
  $query = "SELECT * FROM tbl_respuestas_usuarios WHERE id_encuesta=$id_encuesta";
  $result = $database->query($query);
  if ($result->num_rows > 0) {
    $data = array();
    while ($row = $result->fetch_assoc()) {
      $row["respuestas"] = handleGetRespuestasAdminItem($database, $row["id_respuesta_usuario"]);
      $data[] = $row;
    }
    http_response_code(200);
    echo json_encode($data);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Respuestas: No se encontraron datos"));
  }
}

function handleGetRespuestasAdminItem($database, $id)
{
  $query = "SELECT * FROM tbl_respuestas_usuarios_detalle WHERE id_respuestas_usuarios =$id";
  $result = $database->query($query);
  $data = array();
  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $data[] = $row;
    }
  }
  return $data;
}


$database->close();