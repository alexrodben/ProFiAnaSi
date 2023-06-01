<?php

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
  case 'POST':
    handlePostAuth($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Auth: Método no permitido."));
    break;
}

function handlePostAuth($database)
{
  try {
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);
    $token = $data['token'];

    $query = "SELECT id_usuario, expiracion FROM tbl_tokens WHERE token = '$token'";
    $result = mysqli_query($database, $query);
    if (mysqli_num_rows($result) == 1) {
      $token_data = mysqli_fetch_assoc($result);
      if (strtotime($token_data['expiracion']) < time()) {
        http_response_code(403);
        echo json_encode(["controller" => "Auth", "message" => "El token ha expirado"]);
      } else {
        http_response_code(200);
        echo json_encode(["controller" => "Auth", "message" => "Token válido"]);
      }
    } else {
      http_response_code(403);
      echo json_encode(["controller" => "Auth", "message" => "Token no válido"]);
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "Auth", "message" => $e->getMessage()]);
  }
}

$database->close();
?>
