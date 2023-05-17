<?php

include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);

if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetEncuestas($database);
    break;
  case 'POST':
    handlePostEncuestas($database);
    break;
  case 'PUT':
    handleUpdateEncuestas($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Encuestas: Método no permitido"));
    break;
}

function handlePostEncuestas($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $descripcion = $data["descripcion"];
    $nombre = $data["nombre"];
    $estado = $data["estado"];

    $query = "INSERT INTO `tbl_encuestas` ( `id_encuesta`, `nombre`, `descripcion`, `estado`, `mostrar`) VALUES (NULL, '$nombre', '$descripcion', '$estado', '0')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "Encuestas", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "Encuestas", "message" => $e->getMessage()]);
  }
}

function handleGetEncuestas($database)
{
  try {
    $query = "SELECT * FROM tbl_encuestas";
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
      echo json_encode(array("message" => "Respuestas: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}


function handleUpdateEncuestasMostrar($database)
{
  try {
    $query = "UPDATE tbl_encuestas SET `mostrar` = '0'";
    $result = $database->query($query);
    if (!$result) {
      return json_encode(["controller" => "encuestas", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        return json_encode(array("message" => "Se han actualizado correctamete: " . $affectedRows . " fila(s)"));
      } else {
        return json_encode(array("message" => "No se han encontrado filas para borrar"));
      }
    }
  } catch (Exception $e) {
    return json_encode(["Encuestas" => "preguntas", "message" => $e->getMessage()]);
  }
}

function handleUpdateEncuestas($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $estado = !$data["estado"];
    $id_encuesta = $data["id_encuesta"];
    $extra = "`estado` = '$estado' ";
    if (isset($data["mostrar"])) {
      handleUpdateEncuestasMostrar($database);
      $extra = "`estado` = '1' , `mostrar` = '1'";
    }
    $query = "UPDATE tbl_encuestas SET $extra WHERE tbl_encuestas.id_encuesta= '$id_encuesta'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "encuestas", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "Encuestas", "message" => $e->getMessage()]);
  }
}

$database->close();