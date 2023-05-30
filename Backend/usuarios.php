<?php

$method = $_SERVER['REQUEST_METHOD'];

// Incluir archivo de conexión a la base de datos
include_once 'dbconfig.php';

// Crear conexión a la base de datos
$database = new mysqli($host, $username, $password, $dbname);

// Comprobar conexión
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

// Leer petición
$method = $_SERVER['REQUEST_METHOD'];

// Manejar petición según método
switch ($method) {
  case 'GET':
    handleGetRequest($database);
    break;
  case 'POST':
    $data = json_decode(file_get_contents("php://input"));
    http_response_code(200);
    echo json_encode($data);
    //        handlePostRequest($database);
    break;
  case 'PUT':
    //       handlePutRequest($database);
    break;
  case 'DELETE':
    //      handleDeleteRequest($database);
    break;
  default:
    // Responder con error si el método no es válido
    http_response_code(405);
    echo json_encode(array("message" => "Usuarios: Método no permitido."));
    break;
}

function handleGetRequest($database)
{
  // Leer ID de usuario de la petición
  $user_id = isset($_GET['id']) ? intval($_GET['id']) : 0;

  // Consultar usuario por ID o todos los usuarios si el ID es 0
  $query = "SELECT * FROM tbl_usuarios";
  if ($user_id != 0) {
    $query .= " WHERE id = $user_id LIMIT 1";
  }
  $result = $database->query($query);

  // Comprobar si se encontró algún usuario
  if ($result->num_rows > 0) {
    // Crear array de usuarios
    $users = array();
    while ($row = $result->fetch_assoc()) {
      $users[] = $row;
    }

    // Responder con éxito y los usuarios encontrados
    http_response_code(200);
    echo json_encode($users);
  } else {
    // Responder con error si no se encontraron usuarios
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron usuarios."));
  }
}

$database->close();
