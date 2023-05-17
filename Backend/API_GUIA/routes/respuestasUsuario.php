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
    handleGetRespuestasUsuario($database);
    break;
  case 'POST':
    handlePostRespuestasUsuario($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Respuestas: Método no permitido"));
    break;
}
function handlePostRespuestasUsuario($database)
{
  $data = json_decode(file_get_contents("php://input"), true);
  $id_encuesta = $data["id_encuesta"];
  $repuestas = $data["repuestas"];
  $userInfo = $data["userInfo"];

  $json = mysqli_real_escape_string($database, json_encode($userInfo));

  $sql = "SELECT * FROM tbl_respuestas_usuarios WHERE userInfo = '" . $json . "'";
  $result = $database->query($sql);
  if ($result->num_rows > 0) {
    http_response_code(404);
    echo json_encode(array("message" => "Ya has rellenado esta encuesta"));
  } else {
    $queryEncuesta = "INSERT INTO `tbl_respuestas_usuarios` (`id_respuesta_usuario`, `id_encuesta`, `userInfo`) VALUES (NULL, '$id_encuesta', '$json')";
    $result = $database->query($queryEncuesta);
    if ($result) {
      $affectedRows = mysqli_affected_rows($database);
      $id_respuestas_usuarios = mysqli_insert_id($database);
      if ($affectedRows > 0) {
        $total = 1;
        foreach ($repuestas as $respuesta) {
          $response = handlePostRespuestasUsuarioDetalle($database, $respuesta, $id_respuestas_usuarios);
          $total += $response;
        }
        http_response_code(201);
        echo json_encode(
          array(
            "status" => true,
            "message" => "Se han insertado un total de " . $total . " fila(s)"
          )
        );
      }
    } else {
      http_response_code(404);
      echo json_encode(array());
    }
  }
}

function handlePostRespuestasUsuarioDetalle($database, $item, $id_respuestas_usuarios)
{
  $id_pregunta = $item["id_pregunta"];
  $id_respuesta = $item["id_respuesta"];
  $queryDetalle = "INSERT INTO `tbl_respuestas_usuarios_detalle` (`id_respuestas_usuarios_detalle`, `id_respuestas_usuarios`, `id_pregunta`, `id_respuesta`)  VALUES (NULL, '$id_respuestas_usuarios', '$id_pregunta', '$id_respuesta')  ";
  $result = $database->query($queryDetalle);
  if ($result) {
    $affectedRows = mysqli_affected_rows($database);
    return $affectedRows;
  }
  return 0;
}

function handleGetRespuestasUsuario($database)
{
  $query = "SELECT * FROM tbl_encuestas WHERE mostrar=1";
  $result = $database->query($query);
  if ($result->num_rows > 0) {
    $data = array();
    while ($row = $result->fetch_assoc()) {
      $row["preguntas"] = handleGetPreguntasEncuestas($database, $row["id_encuesta"]);
      $data[] = $row;
    }
    http_response_code(200);
    echo json_encode($data);
  } else {
    http_response_code(404);
    echo json_encode(array());
  }
}

function handleGetPreguntasEncuestas($database, $id = 1)
{
  $query = "SELECT * FROM tbl_preguntas WHERE id_encuesta = $id";
  $result = $database->query($query);
  $data = array();
  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $row["respuestas"] = handleGetRespuestasPreguntasEncuestas($database, $row["id_pregunta"]);
      $data[] = $row;
    }
  }
  return $data;
}

function handleGetRespuestasPreguntasEncuestas($database, $id)
{
  $query = "SELECT * FROM tbl_respuestas WHERE id_pregunta =$id";
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