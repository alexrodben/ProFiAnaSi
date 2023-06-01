<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetClientes($database);
    break;
  case 'POST':
    handlePostClientes($database);
    break;
  case 'PUT':
    handleUpdateClientes($database);
    break;
  case 'DELETE':
    handleDeleteClientes($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "clientes: Método no permitido"));
    break;
}

function handleGetClientesItem($database, $id)
{
  $query = "SELECT * FROM tbl_cliente WHERE Id_Cliente =$id";
  $result = $database->query($query);
  $data = array();
  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $data[] = $row;
    }
  }
  return $data;
}


function handleGetClientes($database)
{
  try {
    $query = "SELECT * FROM tbl_cliente";
    $result = $database->query($query);
    if ($result->num_rows > 0) {
      $data = array();
      while ($row = $result->fetch_assoc()) {
        $row["clientes"] = handleGetClientesItem($database, $row["Id_Cliente"]);
        $data[] = $row;
      }
      http_response_code(200);
      echo json_encode($data);
    } else {
      http_response_code(404);
      echo json_encode(array("message" => "clientes: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleUpdateClientes($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Estatus = !$data["Estatus"];
    $Nombre = $data["Nombre"];
    $Direccion = $data["Direccion"];
    $Nit = $data["Nit"];
    $Telefono = $data["Telefono"];
    $Email = $data["Email"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
    $Id_Cliente = $data["Id_Cliente"];
    $query ="CALL sp_editar_cliente('$Id_Cliente','$Estatus','$Nombre','$Direccion','$Nit','$Telefono','$Email','$CreatedAt','$UpdatedAt' )";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "clientes", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "clientes", "message" => $e->getMessage()]);
  }
}

function handleDeleteClientes($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Cliente = $data["Id_Cliente"];
    $query ="CALL sp_actualizar_cliente_inactivo('$Id_Cliente')"; 
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "clientes", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "clientes", "message" => $e->getMessage()]);
  }
}

function handlePostClientes($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Cliente = $data["Id_Cliente"];
    $Estatus = !$data["Estatus"];
    $Nombre = $data["Nombre"];
    $Direccion = $data["Direccion"];
    $Nit = $data["Nit"];
    $Telefono = $data["Telefono"];
    $Email = $data["Email"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
    
    $query =  "CALL sp_insertar_cliente('$Id_Cliente','$Estatus', '$Nombre', '$Direccion','$Nit','$Telefono','$Email','$CreatedAt','$UpdatedAt')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "clientes", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "clientes", "message" => $e->getMessage()]);
  }
}

$database->close();