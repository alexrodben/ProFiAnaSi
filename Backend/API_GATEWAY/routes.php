<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");

$complete_url = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://" . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
$current_url = $_SERVER['REQUEST_URI'];
$current_url = preg_replace("/\?.*/", "", $current_url);

$method = $_SERVER['REQUEST_METHOD'];
if ($method === 'OPTIONS') {
    http_response_code(200);
    echo json_encode(array());
    return;
}

$headers = getallheaders();
$authHeader = isset($headers['Authorization']) ? $headers['Authorization'] : '';

// Método para redireccionar la solicitud al servidor correspondiente
function redirectRequest($url, $method, $authHeader)
{
    // Obtener los datos de la solicitud original
    $postData = file_get_contents('php://input');

    // Configurar la nueva solicitud al servidor de destino
    $options = array(
        'http' => array(
            'header'  => "Content-type: application/json\r\n" .
                "Authorization: $authHeader\r\n",
            'method'  => $method,
            'content' => $postData,
            'ignore_errors' => true // Permite obtener la respuesta incluso si hay errores HTTP en el servidor de destino
        )
    );
    $context  = stream_context_create($options);
    $response = file_get_contents($url, false, $context);

    // Obtener los headers de respuesta del servidor de destino
    $responseHeaders = $http_response_header;

    // Pasar los headers de respuesta al cliente
    foreach ($responseHeaders as $header) {
        header($header);
    }

    // Pasar el código de respuesta del servidor de destino al cliente
    $responseCode = $http_response_header[0];
    http_response_code((int)substr($responseCode, 9, 3));

    // Pasar la respuesta del servidor de destino al cliente
    echo $response;
}

// Ruta específica para manejar la solicitud de favicon.ico
if ($current_url === '/favicon.ico') {
    http_response_code(204); // Respuesta exitosa sin contenido
    return;
}

if (strpos($current_url, '/api/secure') === 0) {
    $secure_server_ip = '192.168.28.51';
    $secure_server_url = "http://$secure_server_ip" . $current_url;
    redirectRequest($secure_server_url, $method, $headerValue);
    return;
}

if (strpos($current_url, '/api/app') === 0) {
    if ($authHeader) {
        $auth_server_ip = '192.168.28.51';
        $auth_server_url = "http://$auth_server_ip/api/secure/info";

        // Realizar la solicitud al servidor de autenticación
        $auth_response = file_get_contents($auth_server_url, false, stream_context_create([
            'http' => [
                'header' => "Content-type: application/json\r\n" .
                    "Authorization: $authHeader\r\n",
                'method' => 'POST',
                'ignore_errors' => true
            ]
        ]));

        // Obtener el código de respuesta del servidor de autenticación
        $auth_response_code = $http_response_header[0];
        $auth_response_code = (int)substr($auth_response_code, 9, 3);

        // Verificar el código de respuesta y tomar la acción correspondiente
        if ($auth_response_code === 200) {
            // El token es válido, continuar con la redirección
            $api_server_ip = '192.168.28.52';
            $api_server_url = "http://$api_server_ip" . $current_url;
            redirectRequest($api_server_url, $method, $headerValue);
            return;
        } else {
            // El token no es válido, retornar código de respuesta y mensaje de error de la API de autenticación
            $auth_response_data = json_decode($auth_response, true);
            $auth_response_message = isset($auth_response_data['message']) ? $auth_response_data['message'] : 'Token no válido';

            http_response_code($auth_response_code);
            echo json_encode(array("message" => $auth_response_message));
            return;
        }
    } else {
        // No se proporcionó el token de autenticación, retornar código de respuesta 403 y mensaje de error
        http_response_code(403);
        echo json_encode(array("message" => "No estás autenticado: " . $complete_url));
        return;
    }
}

http_response_code(404);
echo json_encode(array("message" => "Ruta no encontrada: " . $complete_url));
return;
