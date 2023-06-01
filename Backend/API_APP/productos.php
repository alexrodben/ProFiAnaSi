<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetProductos($database);
    break;
  case 'POST':
    handlePostProductos($database);
    break;
  case 'PUT':
    handleUpdateProductos($database);
    break;
  case 'DELETE':
    handleDeleteProductos($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "productos: Método no permitido"));
    break;
}

function handleGetProductosItem($database, $id)
{
  $query = "SELECT * FROM tbl_producto WHERE Id_Producto =$id";
  $result = $database->query($query);
  $data = array();
  if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
      $data[] = $row;
    }
  }
  return $data;
}


function handleGetProductos($database)
{
  try {
    $query = "SELECT * FROM tbl_producto ";
    $result = $database->query($query);
    if ($result->num_rows > 0) {
      $data = array();
      while ($row = $result->fetch_assoc()) {
        $row["productos"] = handleGetProductosItem($database, $row["Id_Producto"]);
        $data[] = $row;
      }
      http_response_code(200);
      echo json_encode($data);
    } else {
      http_response_code(404);
      echo json_encode(array("message" => "productos: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleUpdateProductos($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Categoria = !$data["Id_Categoria"];
    $Nombre = $data["Nombre"];
    $SKU = $data["SKU"];
    $Estado = $data["Estado"];
    $Descripcion = $data["Descripcion"];
    $Existencia_minima = $data["Existencia_minima"];
    $Existencia_maxima = $data["Existencia_maxima"];
    $Stock = $data["Stock"];
    $Imagen = $data["Imagen"];
    $Valor_Unitario = $data["Valor_Unitario"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
    $Id_Producto = $data["Id_Producto"];
    $query = "CALL sp_editar_producto('$Id_Producto','$Id_Categoria','$Nombre','$SKU','$Estado','$Descripcion', '$Existencia_minima', '$Existencia_maxima','$Stock', '$Imagen','$Valor_Unitario', '$CreatedAt', '$UpdatedAt' )";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "productos", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "productos", "message" => $e->getMessage()]);
  }
}

function handleDeleteProductos($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Producto = $data["Id_Producto"];
    $query = "CALL sp_actualizar_producto_inactivo('$Id_Producto')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "productos", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "productoss", "message" => $e->getMessage()]);
  }
}

function handlePostProductos($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $Id_Producto = $data["Id_Producto"];
    $Id_Categoria = !$data["Id_Categoria"];
    $Nombre = $data["Nombre"];
    $SKU = $data["SKU"];
    $Estado = $data["Estado"];
    $Descripcion = $data["Descripcion"];
    $Existencia_minima = $data["Existencia_minima"];
    $Existencia_maxima = $data["Existencia_maxima"];
    $Stock = $data["Stock"];
    $Imagen = $data["Imagen"];
    $Valor_Unitario = $data["Valor_Unitario"];
    $CreatedAt = $data["CreatedAt"];
    $UpdatedAt = $data["UpdatedAt"];
    $query = "CALL sp_insertar_producto('$Id_Producto','$Id_Categoria', '$Nombre', '$SKU','$Estado','$Descripcion','$Existencia_minima','$Existencia_maxima','$Stock','$Imagen','$Valor_Unitario','$CreatedAt','$UpdatedAt')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(404);
      echo json_encode(["controller" => "productos", "message" => mysqli_error($database)]);
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
    echo json_encode(["controller" => "productos", "message" => $e->getMessage()]);
  }
}

$database->close();