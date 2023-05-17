<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetPreguntas($database);
    break;
  case 'POST':
    handlePostPreguntas($database);
    break;
  case 'PUT':
    handleUpdatePreguntas($database);
    break;
  case 'DELETE':
    handleDeletePreguntas($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Preguntas: Método no permitido"));
    break;
}

function handleGetPreguntasItem($database, $id)
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


function handleGetPreguntas($database)
{
  try {
    $query = "SELECT * FROM tbl_preguntas WHERE id_encuesta =" . $_GET["id_encuesta"];
    $result = $database->query($query);
    if ($result->num_rows > 0) {
      $data = array();
      while ($row = $result->fetch_assoc()) {
        $row["respuestas"] = handleGetPreguntasItem($database, $row["id_pregunta"]);
        $data[] = $row;
      }
      http_response_code(200);
      echo json_encode($data);
    } else {
      http_response_code(404);
      echo json_encode(array("message" => "Respuestas: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleUpdatePreguntas($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $estado = !$data["estado"];
    $id_pregunta = $data["id_pregunta"];
    $query = "UPDATE tbl_preguntas SET `estado` = '$estado' WHERE tbl_preguntas.id_pregunta= '$id_pregunta'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "preguntas", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(201);
        echo json_encode(array("message" => "Se han actualizado correctamete: " . $affectedRows . " fila(s)"));
      } else {
        http_response_code(204);
        echo json_encode(array("message" => "No se han encontrado filas para borrar"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "preguntas", "message" => $e->getMessage()]);
  }
}

function handleDeletePreguntas($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_pregunta = $data["id_pregunta"];
    $query = "DELETE FROM tbl_preguntas WHERE tbl_preguntas.id_pregunta='$id_pregunta'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "preguntas", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(201);
        echo json_encode(array("message" => "Se han borrado " . $affectedRows . " fila(s)"));
      } else {
        http_response_code(204);
        echo json_encode(array("message" => "No se han encontrado filas para borrar"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "preguntas", "message" => $e->getMessage()]);
  }
}

function handlePostPreguntas($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_encuesta = $data["id_encuesta"];
    $nombre = $data["nombre"];
    $estado = $data["estado"];

    $query = "INSERT INTO `tbl_preguntas` ( `id_pregunta`, `id_encuesta`, `nombre`, `estado`) VALUES (NULL, '$id_encuesta', '$nombre', '$estado')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "preguntas", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(201);
        echo json_encode(array("message" => "Se han borrado " . $affectedRows . " fila(s)"));
      } else {
        http_response_code(204);
        echo json_encode(array("message" => "No se han encontrado filas para borrar"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "preguntas", "message" => $e->getMessage()]);
  }
}

$database->close();