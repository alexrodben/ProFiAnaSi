<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetCompras($database);
    break;
  case 'POST':
    handlePostCompras($database);
    break;
  case 'PUT':
    handleUpdateCompras($database);
    break;
  case 'DELETE':
    handleDeleteCompras($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "compras: Método no permitido"));
    break;
}

function handleGetComprasItem($database, $id)
{
  $query = "SELECT * FROM tbl_compra WHERE Id_Compra =$id";
  $result = $database->query($query);
  $data = array();
  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $data[] = $row;
    }
  }
  return $data;
}


function handleGetCompras($database)
{
  try {
    $query = "SELECT * FROM tbl_compra WHERE Id_Compra=" . $_GET["Id_Compra"];
    $result = $database->query($query);
    if ($result->num_rows > 0) {
      $data = array();
      while ($row = $result->fetch_assoc()) {
        $row["compras"] = handleGetComprasItem($database, $row["Id_Compra"]);
        $data[] = $row;
      }
      http_response_code(200);
      echo json_encode($data);
    } else {
      http_response_code(404);
      echo json_encode(array("message" => "compras: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleUpdateCompras($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Proveedor = !$data["Id_Proveedor"];
    $Fecha= $data["Fecha"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
    $Id_Compra = $data["Id_Compra"];
    $query = "UPDATE tbl_compra SET `Id_Compra` = '$Id_Compra',`Fecha` = '$Fecha',`CreatedAt` = '$CreatedAt',`UpdatedAt` = '$UpdatedAt' WHERE tbl_compra.Id_Compra= '$Id_Compra'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "compras", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "compras", "message" => $e->getMessage()]);
  }
}

function handleDeleteCompras($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Compra = $data["Id_Compra"];
    $query = "DELETE FROM tbl_compra WHERE tbl_compra.Id_Compra='$Id_Compra'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "compras", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "compras", "message" => $e->getMessage()]);
  }
}

function handlePostCompras($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Compra = $data["Id_Compra"];
    $Id_Proveedor = !$data["Id_Proveedor"];
    $Fecha= $data["Fecha"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
    
    $query =  "CALL sp_insertar_compra('$Id_Compra', '$Id_Proveedor', '$Fecha','$CreatedAt','$UpdatedAt')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "compras", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "compras", "message" => $e->getMessage()]);
  }
}

$database->close();