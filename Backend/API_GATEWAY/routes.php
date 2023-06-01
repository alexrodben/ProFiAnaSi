<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
http_response_code(500);

$complete_url = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
$current_url = $_SERVER['REQUEST_URI'];
$current_url = preg_replace("/\?.*/", "", $current_url);

$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'OPTIONS') {
    http_response_code(200);
    echo json_encode(array());
    return;
}

include_once 'dbconfig.php';
$database = new mysqli($host, $username, $password, $dbname);
if ($database->connect_error) {
    die("Conexión fallida: " . $database->connect_error);
}

$headers = getallheaders();
$headerValue = $headers['Authorization'];

// Obtener la IP del servidor actual
$current_server_ip = $_SERVER['SERVER_ADDR'];

if ($headerValue) {
    // Rutas protegidas
    if (strpos($current_url, '/secure/') === 0) {
        // Redireccionar la solicitud al servidor de rutas protegidas
        $secure_server_ip = '192.168.28.51'; // IP del servidor de rutas protegidas
        $secure_server_url = "http://$secure_server_ip" . $current_url;
        redirectRequest($secure_server_url, $method);
    } else {
        http_response_code(404);
        echo json_encode(array("message" => "Ruta no encontrada: " . $complete_url));
    }
} else {
    // Rutas libres
    if (strpos($current_url, '/api/') === 0) {
        // Redireccionar la solicitud al servidor de rutas libres
        $api_server_ip = '192.168.28.52'; // IP del servidor de rutas libres
        $api_server_url = "http://$api_server_ip" . $current_url;
        redirectRequest($api_server_url, $method);
    } else {
        http_response_code(404);
        echo json_encode(array("message" => "Ruta no encontrada: " . $complete_url));
    }
}

$database->close();

// Redirigir la solicitud al servidor correspondiente
function redirectRequest($url, $method)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);

    // Si es una solicitud POST, agregar el cuerpo de la solicitud
    if ($method === 'POST') {
        $postData = file_get_contents('php://input');
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
    }

    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    http_response_code($httpCode);
    echo $response;
}
?>