<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetCategorias($database);
    break;
  case 'POST':
    handlePostCategorias($database);
    break;
  case 'PUT':
    handleUpdateCategorias($database);
    break;
  case 'DELETE':
    handleDeleteCategorias($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Categorias: Método no permitido"));
    break;
}

function handleGetCategoriasItem($database, $id)
{
  $query = "SELECT * FROM tbl_categoria WHERE Id_Categoria =$id";
  $result = $database->query($query);
  $data = array();
  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $data[] = $row;
    }
  }
  return $data;
}


function handleGetCategorias($database)
{
  try {
    $query = "SELECT * FROM tbl_categoria WHERE Id_Categoria =" . $_GET["Id_Categoria"];
    $result = $database->query($query);
    if ($result->num_rows > 0) {
      $data = array();
      while ($row = $result->fetch_assoc()) {
        $row["categorias"] = handleGetCategoriasItem($database, $row["Id_Categoria"]);
        $data[] = $row;
      }
      http_response_code(200);
      echo json_encode($data);
    } else {
      http_response_code(404);
      echo json_encode(array("message" => "Categorias: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleUpdateCategorias($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Nombre = $data["Nombre"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
    $Id_Categoria = $data["Id_Categoria"];
    $query = "CALL sp_editar_categoria('$Id_Categoria', '$Nombre', '$CreatedAt', '$UpdatedAt')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "categorias", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "categorias", "message" => $e->getMessage()]);
  }
}

function handleDeleteCategorias($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Categoria = $data["Id_Categoria"];
    $query = "DELETE FROM tbl_categoria WHERE tbl_categoria.Id_Categoria='$Id_Categoria'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "categorias", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "categorias", "message" => $e->getMessage()]);
  }
}

function handlePostCategorias($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Categoria = $data["Id_Categoria"];
    $Nombre=$data["Nombre"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
        $query = "CALL sp_insertar_categoria('$Id_Categoria', '$Nombre', '$CreatedAt', '$UpdatedAt')";
        $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "categorias", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "categorias", "message" => $e->getMessage()]);
  }
}

$database->close();