<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetVenta($database);
    break;
  case 'POST':
    handleCreateVenta($database);
    break;
  case 'PUT':
    handleUpdateVenta($database);
    break;
  case 'DELETE':
    handleDeleteVenta($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Venta: Método no permitido"));
    break;
}

function handleGetVenta($database)
{
  try {
    $query = "SELECT * FROM tbl_venta";
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
      echo json_encode(array("message" => "Venta: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}


function handleCreateVenta($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_cliente = $data["id_cliente"];
    $fecha = $data["fecha"];

    // Verificar si la venta ya está registrada
    $query_check = "SELECT COUNT(*) as record_count FROM tbl_venta WHERE Id_Cliente = $id_cliente AND Fecha = '$fecha'";
    $result_check = $database->query($query_check);
    $row_check = $result_check->fetch_assoc();
    $record_count = $row_check["record_count"];

    if ($record_count > 0) {
      http_response_code(400);
      echo json_encode(["controller" => "venta", "message" => "Error: La venta ya está registrada."]);
    } else {
      // Llamada al procedimiento almacenado
      $query = "CALL sp_insertar_venta($id_cliente, '$fecha')";
      $result = $database->query($query);

      if (!$result) {
        http_response_code(400);
        echo json_encode(["controller" => "venta", "message" => mysqli_error($database)]);
      } else {
        http_response_code(201);
        echo json_encode(array("message" => "Se ha creado la venta correctamente"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "venta", "message" => $e->getMessage()]);
  }
}


function handleUpdateVenta($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_venta = $data["id_venta"];
    $id_cliente = $data["id_cliente"];
    $fecha_venta = $data["fecha_venta"];
    $total = $data["total"];

    $query = "UPDATE `tbl_venta` SET `id_cliente` = '$id_cliente', `fecha_venta` = '$fecha_venta', `total` = '$total' 
              WHERE `tbl_venta`.`id_venta` = '$id_venta'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "venta", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "Se ha actualizado la venta correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo actualizar la venta"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "venta", "message" => $e->getMessage()]);
  }
}

function handleDeleteVenta($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_venta = $data["id_venta"];

    $query = "DELETE FROM `tbl_venta` WHERE `tbl_venta`.`id_venta` = '$id_venta'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "venta", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "Se ha eliminado la venta correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo eliminar la venta"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "venta", "message" => $e->getMessage()]);
  }
}

$database->close();
?>
