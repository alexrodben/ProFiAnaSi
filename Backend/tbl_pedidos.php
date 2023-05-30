<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET':
    handleGetPedidos($database);
    break;
  case 'POST':
    handleCreatePedido($database);
    break;
  case 'PUT':
    handleUpdatePedido($database);
    break;
  case 'DELETE':
    handleDeletePedido($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Pedidos: Método no permitido"));
    break;
}

function handleGetPedidos($database)
{
  try {
    $query = "SELECT * FROM tbl_pedidos";
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
      echo json_encode(array("message" => "Pedidos: No se encontraron datos"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["message" => $e->getMessage()]);
  }
}

function handleCreatePedido($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $cliente = $data["cliente"];
    $producto = $data["producto"];
    $cantidad = $data["cantidad"];
    $precio_unitario = $data["precio_unitario"];

    $query = "INSERT INTO `tbl_pedidos` (`id_pedido`, `cliente`, `producto`, `cantidad`, `precio_unitario`) 
              VALUES (NULL, '$cliente', '$producto', '$cantidad', '$precio_unitario')";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "pedidos", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(201);
        echo json_encode(array("message" => "Se ha creado el pedido correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo crear el pedido"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "pedidos", "message" => $e->getMessage()]);
  }
}

function handleUpdatePedido($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_pedido = $data["id_pedido"];
    $cliente = $data["cliente"];
    $producto = $data["producto"];
    $cantidad = $data["cantidad"];
    $precio_unitario = $data["precio_unitario"];

    $query = "UPDATE `tbl_pedidos` 
              SET `cliente` = '$cliente', `producto` = '$producto', `cantidad` = '$cantidad', `precio_unitario` = '$precio_unitario' 
              WHERE `tbl_pedidos`.`id_pedido` = '$id_pedido'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "pedidos", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "Se ha actualizado el pedido correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo actualizar el pedido"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "pedidos", "message" => $e->getMessage()]);
  }
}

function handleDeletePedido($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"), true);
    $id_pedido = $data["id_pedido"];

    $query = "DELETE FROM `tbl_pedidos` WHERE `tbl_pedidos`.`id_pedido` = '$id_pedido'";
    $result = $database->query($query);
    if (!$result) {
      http_response_code(400);
      echo json_encode(["controller" => "pedidos", "message" => mysqli_error($database)]);
    } else {
      $affectedRows = mysqli_affected_rows($database);
      if ($affectedRows > 0) {
        http_response_code(200);
        echo json_encode(array("message" => "Se ha eliminado el pedido correctamente"));
      } else {
        http_response_code(500);
        echo json_encode(array("message" => "No se pudo eliminar el pedido"));
      }
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "pedidos", "message" => $e->getMessage()]);
  }
}

$database->close();
?>
