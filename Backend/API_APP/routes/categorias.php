<?php
include_once './../dbconfig.php';

$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
  die("Conexión fallida: " . $database->connect_error);
}

$method = $_SERVER['REQUEST_METHOD'];
switch ($method) {
  case 'GET': // getAll
    handleGetCategorias($database);
    break;
  case 'POST': // add
    handlePostCategoria($database);
    break;
  case 'PUT': // update
    handleUpdateCategoria($database);
    break;
  default:
    http_response_code(405);
    echo json_encode(array("message" => "categorias: Método no permitido"));
    break;
}

function handleGetCategorias($database)
{
  // Ejecutar el procedimiento almacenado para obtener todas las categorías
  $result = $database->query("CALL sp_mostrar_categoria()");

  if ($result->num_rows > 0) {
    $categorias = array();
    while ($row = $result->fetch_assoc()) {
      $categorias[] = $row;
    }
    http_response_code(200);
    echo json_encode($categorias);
  } else {
    http_response_code(404);
    echo json_encode(array("message" => "No se encontraron categorías."));
  }
}

function handlePostCategoria($database)
{
  // Obtener los datos enviados en la solicitud POST y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $nombre = $data['nombre'];

  // Ejecutar el procedimiento almacenado para insertar una nueva categoría
  $stmt = $database->prepare("CALL sp_insertar_categoria(?)");
  $stmt->bind_param("s", $nombre);
  if ($stmt->execute()) {
    http_response_code(201);
    echo json_encode(array("message" => "Categoría creada exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo crear la categoría."));
  }
}

function handleUpdateCategoria($database)
{
  // Obtener los datos enviados en la solicitud PUT y asignarlos a variables
  $json = file_get_contents('php://input');
  $data = json_decode($json, true);

  $categoriaId = $data['id_categoria'];
  $nombre = $data['nombre'];

  // Ejecutar el procedimiento almacenado para actualizar una categoría existente
  $stmt = $database->prepare("CALL sp_editar_categoria(?, ?)");
  $stmt->bind_param("is", $categoriaId, $nombre);
  if ($stmt->execute()) {
    http_response_code(200);
    echo json_encode(array("message" => "Categoría actualizada exitosamente."));
  } else {
    http_response_code(400);
    echo json_encode(array("message" => "No se pudo actualizar la categoría."));
  }
}

$database->close();
?>