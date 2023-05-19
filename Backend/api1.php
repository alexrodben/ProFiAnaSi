<?php

// Configuración de la base de datos
$servername = "localhost";
$username = "root";
$password = "";
$database = "inventarios";

// Crear conexión a la base de datos
$conn = new mysqli($servername, $username, $password, $database);

// Verificar si hay errores de conexión
if ($conn->connect_error) {
    die("Error de conexión a la base de datos: " . $conn->connect_error);
}

// Definir las cabeceras de respuesta para permitir el acceso desde diferentes dominios
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Verificar el método de la solicitud HTTP
$method = $_SERVER['REQUEST_METHOD'];

// Obtener los datos enviados en la solicitud
$data = json_decode(file_get_contents("php://input"), true);

// Función para enviar una respuesta JSON
function sendResponse($status, $message, $data = null)
{
    $response = array(
        "status" => $status,
        "message" => $message,
        "data" => $data
    );
    echo json_encode($response);
}

// Manejar la solicitud
switch ($method) {
    case 'GET':
        // Obtener todos los productos
        $sql = "SELECT * FROM tbl_productos";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $productos = array();
            while ($row = $result->fetch_assoc()) {
                $productos[] = $row;
            }
            sendResponse("success", "Productos obtenidos exitosamente", $productos);
        } else {
            sendResponse("success", "No se encontraron productos");
        }
        break;

    case 'POST':
        // Crear un nuevo producto
        $nombre = $data['nombre'];
        $descripcion = $data['descripcion'];
        $precio = $data['precio'];

        $sql = "INSERT INTO tbl_productos (nombre, descripcion, precio) VALUES ('$nombre', '$descripcion', $precio)";
        if ($conn->query($sql) === TRUE) {
            sendResponse("success", "Producto creado exitosamente");
        } else {
            sendResponse("error", "Error al crear el producto: " . $conn->error);
        }
        break;

    case 'PUT':
        // Actualizar un producto existente
        $idProducto = $data['id_producto'];
        $nombre = $data['nombre'];
        $descripcion = $data['descripcion'];
        $precio = $data['precio'];

        $sql = "UPDATE tbl_productos SET nombre='$nombre', descripcion='$descripcion', precio=$precio WHERE id_producto=$idProducto";
        if ($conn->query($sql) === TRUE) {
            sendResponse("success", "Producto actualizado exitosamente");
        } else {
            sendResponse("error", "Error al actualizar el producto: " . $conn->error);
        }
        break;

    case 'DELETE':
        // Eliminar un producto
        $idProducto = $_GET['id_producto'];

        $sql = "DELETE FROM tbl_productos WHERE id_producto=$idProducto";
        if ($conn->query($sql) === TRUE) {
            sendResponse("success", "Producto eliminado exitosamente");
        } else {
            sendResponse("error", "Error al eliminar el producto: " . $conn->error);
        }
        break;

    default:
        sendResponse("error", "Método no válido");
        break;
}

// Cerrar la conexión a la base de datos
$conn->close();

?>