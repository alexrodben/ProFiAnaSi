<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetDetalleVenta($database);
    break;
  case 'POST':
    handleCreateDetalleVenta($database);
    break;
  case 'PUT':
    handleUpdateDetalleVenta($database);
    break;
  case 'DELETE':
    handleDeleteDetalleVenta($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Detalle Venta: Método no permitido"));
    break;
}

function handleGetDetalleVenta($database)
{
  try {
    $query = "SELECT * FROM tbl_detalle_venta";
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
      echo json_encode(array("message" => "Detalle Venta: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleCreateDetalleVenta($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_venta = $data["id_venta"];
    $producto = $data["producto"];
    $cantidad = $data["cantidad"];
    $precio_unitario = $data["precio_unitario"];

    $query = "INSERT INTO `tbl_detalle_venta` (`id_detalle_venta`, `id_venta`, `producto`, `cantidad`, `precio_unitario`) 
              VALUES (NULL, '$id_venta', '$producto', '$cantidad', '$precio_unitario')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "detalle_venta", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(201);
        echo json_encode(array("message" => "Se ha creado el detalle de venta correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo crear el detalle de venta"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "detalle_venta", "message" => $e->getMessage()]);
  }
}

function handleUpdateDetalleVenta($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_detalle_venta = $data["id_detalle_venta"];
    $id_venta = $data["id_venta"];
    $producto = $data["producto"];
    $cantidad = $data["cantidad"];
    $precio_unitario = $data["precio_unitario"];

    $query = "UPDATE `tbl_detalle_venta` 
              SET `id_venta` = '$id_venta', `producto` = '$producto', `cantidad` = '$cantidad', `precio_unitario` = '$precio_unitario' 
              WHERE `tbl_detalle_venta`.`id_detalle_venta` = '$id_detalle_venta'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "detalle_venta", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "Se ha actualizado el detalle de venta correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo actualizar el detalle de venta"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "detalle_venta", "message" => $e->getMessage()]);
  }
}

function handleDeleteDetalleVenta($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_detalle_venta = $data["id_detalle_venta"];

    $query = "DELETE FROM `tbl_detalle_venta` WHERE `tbl_detalle_venta`.`id_detalle_venta` = '$id_detalle_venta'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "detalle_venta", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "Se ha eliminado el detalle de venta correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo eliminar el detalle de venta"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "detalle_venta", "message" => $e->getMessage()]);
  }
}

$database->close();
?>
