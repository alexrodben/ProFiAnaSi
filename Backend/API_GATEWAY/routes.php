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
}

if (strpos($current_url, '/api/app') === 0) {
    if ($authHeader) {
        $api_server_ip = '192.168.28.52';
        $api_server_url = "http://$api_server_ip" . $current_url;
        redirectRequest($api_server_url, $method, $headerValue);
    } else {
        http_response_code(403);
        echo json_encode(array("message" => "No estas autenticado: " . $complete_url));
    }
}

http_response_code(404);
echo json_encode(array("message" => "Ruta no encontrada: " . $complete_url));
?>