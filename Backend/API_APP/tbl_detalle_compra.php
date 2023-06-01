<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetDetalleCompra($database);
    break;
  case 'POST':
    handleCreateDetalleCompra($database);
    break;
  case 'PUT':
    handleUpdateDetalleCompra($database);
    break;
  case 'DELETE':
    handleDeleteDetalleCompra($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Detalle Compra: Método no permitido"));
    break;
}

function handleGetDetalleCompra($database)
{
  try {
    $query = "SELECT * FROM tbl_detalle_compra";
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
      echo json_encode(array("message" => "Detalle Compra: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleCreateDetalleCompra($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_compra = $data["id_compra"];
    $id_producto = $data["id_producto"];
    $cantidad = $data["cantidad"];
    $valor_unitario = $data["valor_unitario"];
    $valor_costo = $data["valor_costo"];
    $valor_total = $data["valor_total"];

    // Llamada al procedimiento almacenado
    $query = "CALL sp_insertar_detalle_compra($id_compra, $id_producto, $cantidad, $valor_unitario, $valor_costo, $valor_total)";
    $result = $database->query($query);

    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "detalle_compra", "message" => mysqli_error($database)]);
    } else {
      http_response_code(201);
      echo json_encode(array("message" => "Se ha creado el detalle de compra correctamente"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "detalle_compra", "message" => $e->getMessage()]);
  }
}

function handleUpdateDetalleCompra($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_detalle_compra = $data["id_detalle_compra"];
    $producto = $data["producto"];
    $cantidad = $data["cantidad"];
    $precio_unitario = $data["precio_unitario"];

    $query = "UPDATE `tbl_detalle_compra` SET `producto` = '$producto', `cantidad` = '$cantidad', `precio_unitario` = '$precio_unitario' 
              WHERE `tbl_detalle_compra`.`id_detalle_compra` = '$id_detalle_compra'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "detalle_compra", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "Se ha actualizado el detalle de compra correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo actualizar el detalle de compra"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "detalle_compra", "message" => $e->getMessage()]);
  }
}

function handleDeleteDetalleCompra($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_detalle_compra = $data["id_detalle_compra"];

    $query = "DELETE FROM `tbl_detalle_compra` WHERE `tbl_detalle_compra`.`id_detalle_compra` = '$id_detalle_compra'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "detalle_compra", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "Se ha eliminado el detalle de compra correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo eliminar el detalle de compra"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "detalle_compra", "message" => $e->getMessage()]);
  }
}

$database->close();
?>
