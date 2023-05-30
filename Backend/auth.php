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
  case 'POST':
    handlePostAuth($database);
    break;
  case 'PUT':
    handlePutAuth($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "Auth: Método no permitido."));
    break;
}

function handlePutAuth($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"));
    $token = $data->token;
    $query = "SELECT tbl_tokens.id_usuario, tbl_tokens.expiracion, tbl_usuarios.firstname, tbl_usuarios.lastname FROM `tbl_usuarios` INNER JOIN `tbl_tokens`ON tbl_usuarios.id_usuario = tbl_tokens.id_usuario WHERE tbl_tokens.token=?";
    $stmt = mysqli_prepare($database, $query);
    mysqli_stmt_bind_param($stmt, 's', $token);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_store_result($stmt);
    if (mysqli_stmt_num_rows($stmt) == 1) {
      mysqli_stmt_bind_result($stmt, $id_usuario, $expiracion, $firstname, $lastname);
      while (mysqli_stmt_fetch($stmt)) {
        $userData = array(
          "id_usuario" => $id_usuario,
          "expiracion" => $expiracion,
          "firstname" => $firstname,
          "lastname" => $lastname,
          "token" => $token
        );
      }
      http_response_code(200);
      echo json_encode($userData);
    } else {
      http_response_code(404);
      echo json_encode(array("message" => "Credenciales incorrectas"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "Auth", "message" => $e->getMessage()]);
  }
}


function handlePostAuth($database)
{
  try {
    $data = json_decode(file_get_contents("php://input"));
    $username = $data->username;
    $password = $data->password;
    $query = "SELECT id_usuario FROM tbl_usuarios WHERE username=? AND password=?";
    $stmt = mysqli_prepare($database, $query);
    mysqli_stmt_bind_param($stmt, 'ss', $username, $password);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_store_result($stmt);
    if (mysqli_stmt_num_rows($stmt) == 1) {
      mysqli_stmt_bind_result($stmt, $id_usuario);
      mysqli_stmt_fetch($stmt);
        generateToken($database, $id_usuario);
    } else {
      http_response_code(401);
      echo json_encode(array("message" => "Credenciales incorrectas"));
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "Auth", "message" => $e->getMessage()]);
  }
}

function generateToken($database, $id_usuario)
{
  try {

    $token = bin2hex(random_bytes(64));
    $expiracion = date('Y-m-d H:i:s', time() + (60 * 60 * 2));
    $query = "INSERT INTO tbl_tokens (id_usuario, token, expiracion) VALUES ($id_usuario, '$token', '$expiracion')";
    $result = mysqli_query($database, $query);
    if ($result) {
      $response = [
        'token' => $token,
      ];
      http_response_code(200);
      echo json_encode($response);
    } else {
      http_response_code(404);
      echo json_encode(["controller" => "Auth", "message" => "No se ha podido crear el token"]);
    }
  } catch (Exception $e) {
    http_response_code(403);
    echo json_encode(["controller" => "Auth", "message" => $e->getMessage()]);
  }
}

$database->close();