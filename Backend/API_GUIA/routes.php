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

if ('/api/auth' === $current_url) {
    include_once 'routes/auth.php';
} else if ('/api/respuestas/usuario' === $current_url) {
    include_once 'routes/respuestasUsuario.php';
} else {
    include_once 'dbconfig.php';
    $database = new mysqli($host, $username, $password, $dbname);
    if ($database->connect_error) {
        die("Conexión fallida: " . $database->connect_error);
    }

    $headers = getallheaders();
    $headerValue = $headers['Authorization'];
    $authentication = authentication($headerValue, $database);
    if ($authentication) {
        switch ($current_url) {
            case ("/api/usuarios"):
                include_once 'routes/usuarios.php';
                break;
            case ("/api/encuestas"):
                include_once 'routes/encuestas.php';
                break;
            case ("/api/preguntas"):
                include_once 'routes/preguntas.php';
                break;
            case ("/api/respuestas"):
                include_once 'routes/respuestas.php';
                break;
            case ("/api/respuestas/admin"):
                include_once 'routes/respuestasAdmin.php';
                break;
            default:
                http_response_code(404);
                echo json_encode(array("message" => "elemento no exite, ruta: " . $complete_url));
                break;
        }
    } else {
        http_response_code(401);
        echo json_encode(array("message" => "Usuario no no permitido."));
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