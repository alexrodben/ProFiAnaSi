<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
http_response_code(500);

$complete_url = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
$current_url = $_SERVER['REQUEST_URI'];
$current_url = preg_replace("/\?.*/", "", $current_url);
$folder = "api/app";

$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'OPTIONS') {
    http_response_code(200);
    echo json_encode(array());
    return;
}

// Ruta específica para manejar la solicitud de favicon.ico
if ($current_url === '/favicon.ico') {
    http_response_code(204); // Respuesta exitosa sin contenido
    return;
}


include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
    die("Conexión fallida: " . $database->connect_error);
}

if (true) {
    switch ($current_url) {

        case ("/{$folder}/cardex"):
            include_once 'routes/cardex.php';
            break;
        case ("/{$folder}/categorias"):
            include_once 'routes/categorias.php';
            break;
        case ("/{$folder}/clientes"):
            include_once 'routes/clientes.php';
            break;
        case ("/{$folder}/compras"):
            include_once 'routes/compras.php';
            break;
        case ("/{$folder}/detalleCompras"):
            include_once 'routes/detalle_compras.php';
            break;
        case ("/{$folder}/detalleVentas"):
            include_once 'routes/detalle_venta.php';
            break;
        case ("/{$folder}/productos"):
            include_once 'routes/productos.php';
            break;
        case ("/{$folder}/proveedores"):
            include_once 'routes/proveedores.php';
            break;
        case ("/{$folder}/ventas"):
            include_once 'routes/ventas.php';
            break;
        default:
            http_response_code(404);
            echo json_encode(array("message" => "elemento no exite, ruta: " . $complete_url));
            break;
    }
}

function authentication($token, $database)
{
    try {
        $query = "SELECT id_usuario, expiracion FROM tbl_tokens WHERE token = '$token'";
        $result = mysqli_query($database, $query);
        if (mysqli_num_rows($result) == 1) {
            $token_data = mysqli_fetch_assoc($result);
            if (strtotime($token_data['expiracion']) < time()) {
                http_response_code(403);
                echo json_encode(["controller" => "Auth", "message" => "El token ha expirado"]);
                return false;
            } else {
                return true;
            }
        } else {
            http_response_code(403);
            echo json_encode(["controller" => "Auth", "message" => "Token no es valido"]);
        }
        $database->close();
        return false;
    } catch (Exception $e) {
        return false;
    }
}
