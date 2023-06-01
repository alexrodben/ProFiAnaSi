<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
http_response_code(500);

$complete_url = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
$current_url = $_SERVER['REQUEST_URI'];
$current_url = preg_replace("/\?.*/", "", $current_url);
$folder = "apiSanarate/api";

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

switch ($current_url) {
    case ("/{$folder}/usuarios"):
        include_once 'routes/usuarios.php';
        break;
    case ("/{$folder}/auth"):
        include_once 'routes/auth.php';
        break;
    case ("/{$folder}/info"):
        include_once 'routes/info.php';
        break;
    default:
        http_response_code(404);
        echo json_encode(array("message" => "elemento no exite, ruta: " . $complete_url));
        break;
}