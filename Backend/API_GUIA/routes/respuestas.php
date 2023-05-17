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
    handleGetRespuestas($database);
    break;
  case 'POST':
    handlePostRespuestas($database);
    break;
  case 'PUT':
    handleUpdateRespuestas($database);
    break;
  case 'DELETE':
    handleDeleteRespuestas($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Respuestas: Método no permitido"));
    break;
}

function handleGetRespuestas($database)
{
  try {
    $query = "SELECT * FROM tbl_respuestas WHERE id_pregunta =" . $_GET["id_pregunta"];
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
      echo json_encode(array());
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleUpdateRespuestas($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $estado = !$data["estado"];
    $id_respuesta = $data["id_respuesta"];
    $query = "UPDATE tbl_respuestas SET `estado` = '$estado' WHERE tbl_respuestas.id_respuesta= '$id_respuesta'";
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

function handleDeleteRespuestas($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_respuesta = $data["id_respuesta"];
    $query = "DELETE FROM tbl_respuestas WHERE tbl_respuestas.id_respuesta=$id_respuesta";
    $result = $database->query($query);
    if ($result) {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(201);
        echo json_encode(array("message" => "Se han borrado " . $affectedRows . " fila(s)"));
      } else {
        http_response_code(204);
        echo json_encode(array("message" => "No se han encontrado filas para borrar"));
      }
    } else {
      http_response_code(404);
      echo json_encode(array());
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handlePostRespuestas($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_pregunta = $data["id_pregunta"];
    $nombre = $data["nombre"];
    $estado = $data["estado"];
    $query = "INSERT INTO `tbl_respuestas` (`id_respuesta`, `id_pregunta`, `nombre`, `estado`) VALUES (null,'$id_pregunta', '$nombre', '$estado')";
    $result = $database->query($query);
    if ($result) {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(201);
        echo json_encode(array("message" => "Se han borrado " . $affectedRows . " fila(s)"));
      } else {
        http_response_code(204);
        echo json_encode(array("message" => "No se han encontrado filas para borrar"));
      }
    } else {
      http_response_code(404);
      echo json_encode(array());
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}



$database->close();