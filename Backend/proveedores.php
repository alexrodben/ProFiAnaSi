<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetProveedores($database);
    break;
  case 'POST':
    handlePostProveedores($database);
    break;
  case 'PUT':
    handleUpdateProveedores($database);
    break;
  case 'DELETE':
    handleDeleteProveedores($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "proveedores: Método no permitido"));
    break;
}

function handleGetProveedoresItem($database, $id)
{
  $query = "SELECT * FROM tbl_proveedor WHERE Id_Proveedor =$id";
  $result = $database->query($query);
  $data = array();
  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $data[] = $row;
    }
  }
  return $data;
}


function handleGetProveedores($database)
{
  try {
    $query = "SELECT * FROM tbl_proveedor WHERE Id_Proveedor =" . $_GET["Id_Proveedor"];
    $result = $database->query($query);
    if ($result->num_rows > 0) {
      $data = array();
      while ($row = $result->fetch_assoc()) {
        $row["proveedores"] = handleGetProveedoresItem($database, $row["Id_Proveedor"]);
        $data[] = $row;
      }
      http_response_code(200);
      echo json_encode($data);
    } else {
      http_response_code(404);
      echo json_encode(array("message" => "proveedores: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleUpdateProveedores($database)
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
    $Id_Proveedor = $data["Id_Proveedor"];
    $query = "UPDATE tbl_proveedor SET `Estatus` = '$Estatus',`Nombre` = '$Nombre',`Direccion` = '$Direccion',`Nit` = '$Nit',`Telefono` = '$Telefono',`Email` = '$Email',`CreatedAt` = '$CreatedAt',`UpdatedAt` = '$UpdatedAt' WHERE tbl_proveedor.Id_Proveedor= '$Id_Proveedor'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "proveedores", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "proveedores", "message" => $e->getMessage()]);
  }
}

function handleDeleteProveedores($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Proveedor = $data["Id_Proveedor"];
    $query = "DELETE FROM tbl_proveedor WHERE tbl_proveedor.Id_Proveedor='$Id_Proveedor'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "proveedores", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "proveedores", "message" => $e->getMessage()]);
  }
}

function handlePostProveedores($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Proveedor = $data["Id_Proveedor"];
    $Estatus = !$data["Estatus"];
    $Nombre = $data["Nombre"];
    $Direccion = $data["Direccion"];
    $Nit = $data["Nit"];
    $Telefono = $data["Telefono"];
    $Email = $data["Email"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
    
    $query = "INSERT INTO `tbl_proveedor` ( `Id_Proveedor`, `Estatus`, `Nombre`, `Direccion`, 'Nit','Telefono','Email','CreatedAt','UpdatedAt') VALUES (NULL, '$Estatus', '$Nombre', '$Direccion','$Nit','$Telefono','$Email','$CreatedAt','$UpdatedAt')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "proveedores", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "proveedores", "message" => $e->getMessage()]);
  }
}

$database->close();