<?php
include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET': // getAll
    if (isset($_GET['id'])) {
      $clienteId = $_GET['id'];
      handleGetUsuarioItem($database, $clienteId);
    } else {
      handleGetUsuarios($database);
    }
    break;
  case 'POST': // add
    handlePostUsuario($database);
    break;
  case 'PUT': // update
    handleUpdateUsuario($database);
    break;
  case 'DELETE': // delete
    handleDeleteUsuario($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "usuarios: Método no permitido"));
    break;
}

function handleGetUsuarios($database)
{
  // Ejecutar la consulta para obtener todos los usuarios
  $result = $database->query("SELECT * FROM tbl_usuarios");

  if ($result->num_rows > 0) {
    $usuarios = array();
    while ($row = $result->fetch_assoc()) {
      $usuarios[] = $row;
    }
    http_response_code(200);
    echo json_encode($usuarios);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron usuarios."));
  }
}

function handleGetUsuarioItem($database, $clienteId)
{
  // Ejecutar la consulta para obtener un usuario específico
  $stmt = $database->prepare("SELECT * FROM tbl_usuarios WHERE id_usuario = ?");
  $stmt->bind_param("i", $clienteId);
  $stmt->execute();
  $result = $stmt->get_result();

  if ($result->num_rows > 0) {
    $usuario = $result->fetch_assoc();
    http_response_code(200);
    echo json_encode($usuario);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "Usuario no encontrado."));
  }
}

function handlePostUsuario($database)
{
  // Obtener los datos enviados en la solicitud POST y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $username = $data['username'];
  $password = $data['password'];
  $firstname = $data['firstname'];
  $lastname = $data['lastname'];

  // Insertar un nuevo usuario en la base de datos
  $stmt = $database->prepare("INSERT INTO tbl_usuarios (username, password, firstname, lastname) VALUES (?, ?, ?, ?)");
  $stmt->bind_param("ssss", $username, $password, $firstname, $lastname);
  if ($stmt->execute()) {
    $userId = $stmt->insert_id;
    $usuario = array(
      "id_usuario" => $userId,
      "username" => $username,
      "password" => $password,
      "firstname" => $firstname,
      "lastname" => $lastname
    );
    http_response_code(201);
    echo json_encode($usuario);
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear el usuario."));
  }
}

function handleUpdateUsuario($database)
{
  // Obtener los datos enviados en la solicitud PUT y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $userId = $data['id_usuario'];
  $username = $data['username'];
  $password = $data['password'];
  $firstname = $data['firstname'];
  $lastname = $data['lastname'];

  // Actualizar un usuario existente en la base de datos
  $stmt = $database->prepare("UPDATE tbl_usuarios SET username = ?, password = ?, firstname = ?, lastname = ? WHERE id_usuario = ?");
  $stmt->bind_param("ssssi", $username, $password, $firstname, $lastname, $userId);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Usuario actualizado correctamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo actualizar el usuario."));
  }
}

function handleDeleteUsuario($database)
{
  // Obtener el ID del usuario a eliminar
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $userId = $data['id_usuario'];

  // Actualizar el estado del usuario a 'inactivo'
  $stmt = $database->prepare("UPDATE tbl_usuarios SET Estatus = 'inactivo' WHERE id_usuario = ?");
  $stmt->bind_param("i", $userId);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Usuario eliminado correctamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo eliminar el usuario."));
  }
}
