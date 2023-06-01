<?php
include_once './dbconfig.php';

$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET': // getAll
    if (isset($_GET['id'])) {
      $proveedorId = $_GET['id'];
      handleGetProveedor($database, $proveedorId);
    } else {
      handleGetProveedores($database);
    }
    break;
  case 'POST': // add
    handlePostProveedor($database);
    break;
  case 'PUT': // update
    handleUpdateProveedor($database);
    break;
  case 'DELETE': // delete
    handleDeleteProveedor($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "proveedores: Método no permitido"));
    break;
}

function handleGetProveedores($database)
{
  // Ejecutar el procedimiento almacenado para obtener todos los proveedores
  $result = $database->query("CALL sp_mostrar_proveedor()");

  if ($result->num_rows > 0) {
    $proveedores = array();
    while ($row = $result->fetch_assoc()) {
      $proveedores[] = $row;
    }
    http_response_code(200);
    echo json_encode($proveedores);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron proveedores."));
  }
}

function handleGetProveedor($database, $proveedorId)
{
  // Ejecutar el procedimiento almacenado para obtener un proveedor específico
  $stmt = $database->prepare("CALL sp_item_proveedor(?)");
  $stmt->bind_param("i", $proveedorId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $proveedor = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($proveedor);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Proveedor no encontrado."));
  }
}

function handlePostProveedor($database)
{
  // Obtener los datos enviados en la solicitud POST y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $estatus = $data['estatus'];
  $nombre = $data['nombre'];
  $direccion = $data['direccion'];
  $nit = $data['nit'];
  $telefono = $data['telefono'];
  $email = $data['email'];

  // Ejecutar el procedimiento almacenado para insertar un nuevo proveedor
  $stmt = $database->prepare("CALL sp_insertar_proveedor(?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("ssssss", $estatus, $nombre, $direccion, $nit, $telefono, $email);
  if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Proveedor creado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear el proveedor."));
  }
}

function handleUpdateProveedor($database)
{
  // Obtener los datos enviados en la solicitud PUT y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $proveedorId = $data['id_proveedor'];
  $estatus = $data['estatus'];
  $nombre = $data['nombre'];
  $direccion = $data['direccion'];
  $nit = $data['nit'];
  $telefono = $data['telefono'];
  $email = $data['email'];

  // Ejecutar el procedimiento almacenado para actualizar un proveedor existente
  $stmt = $database->prepare("CALL sp_editar_proveedor(?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("issssss", $proveedorId, $estatus, $nombre, $direccion, $nit, $telefono, $email);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Proveedor actualizado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo actualizar el proveedor."));
  }
}

function handleDeleteProveedor($database)
{
  // Obtener los datos enviados en la solicitud DELETE y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $proveedorId = $data['id'];

  // Ejecutar el procedimiento almacenado para actualizar un proveedor como inactivo
  $stmt = $database->prepare("CALL sp_actualizar_proveedor_inactivo(?)");
  $stmt->bind_param("i", $proveedorId);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Proveedor actualizado como inactivo exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo actualizar el proveedor."));
  }
}
?>