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
      $clienteId = $_GET['id'];
      handleGetCliente($database, $clienteId);
    } else {
      handleGetClientes($database);
    }
    break;
  case 'POST': // add
    handlePostClientes($database);
    break;
  case 'PUT': // update
    handleUpdateClientes($database);
    break;
  case 'DELETE': // delete
    handleDeleteClientes($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "clientes: Método no permitido"));
    break;
}

function handleGetClientes($database)
{
  // Ejecutar el procedimiento almacenado para obtener todos los clientes
  $result = $database->query("CALL sp_mostrar_cliente()");

  if ($result->num_rows > 0) {
    $clientes = array();
    while ($row = $result->fetch_assoc()) {
      $clientes[] = $row;
    }
    http_response_code(200);
    echo json_encode($clientes);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron clientes."));
  }
}

function handleGetCliente($database, $clienteId)
{
  // Ejecutar el procedimiento almacenado para obtener un cliente específico
  $stmt = $database->prepare("CALL sp_item_cliente(?)");
  $stmt->bind_param("i", $clienteId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $cliente = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($cliente);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Cliente no encontrado."));
  }
}

function handlePostClientes($database)
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

  // Ejecutar el procedimiento almacenado para insertar un nuevo cliente
  $stmt = $database->prepare("CALL sp_insertar_cliente(?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("ssssss", $estatus, $nombre, $direccion, $nit, $telefono, $email);
  if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Cliente creado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear el cliente."));
  }
}

function handleUpdateClientes($database)
{
  // Obtener los datos enviados en la solicitud PUT y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $clienteId = $data['id_cliente'];
  $estatus = $data['estatus'];
  $nombre = $data['nombre'];
  $direccion = $data['direccion'];
  $nit = $data['nit'];
  $telefono = $data['telefono'];
  $email = $data['email'];

  // Ejecutar el procedimiento almacenado para actualizar un cliente existente
  $stmt = $database->prepare("CALL sp_editar_cliente(?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("issssss", $clienteId, $estatus, $nombre, $direccion, $nit, $telefono, $email);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Cliente actualizado exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo actualizar el cliente."));
  }
}

function handleDeleteClientes($database)
{
  // Obtener los datos enviados en la solicitud DELETE y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $clienteId = $data['id'];

  // Ejecutar el procedimiento almacenado para actualizar un cliente como inactivo
  $stmt = $database->prepare("CALL sp_actualizar_cliente_inactivo(?)");
  $stmt->bind_param("i", $clienteId);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Cliente actualizado como inactivo exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo actualizar el cliente."));
  }
}
$database->close();

?>