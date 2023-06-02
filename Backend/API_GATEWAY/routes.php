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

// Definir las rutas privadas y sus servidores correspondientes
$privateRoutes = array(
    "/api/cardex" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta del cardex"
    ),
    "/api/categorias" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta de categorías"
    ),
    "/api/clientes" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta de clientes"
    ),
    "/api/compras" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta de compras"
    ),
    "/api/detalleCompras" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta de detalle de compras"
    ),
    "/api/detalleVentas" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta de detalle de ventas"
    ),
    "/api/productos" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta de productos"
    ),
    "/api/proveedores" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta de proveedores"
    ),
    "/api/ventas" => array(
        "server" => "192.168.28.52",
        "description" => "Ruta de ventas"
    ),
    "/api/usuarios" => array(
        "server" => "192.168.28.51",
        "description" => "Ruta de usuarios"
    )
);

// Definir las rutas públicas y sus servidores correspondientes
$publicRoutes = array(
    "/api/auth" => array(
        "server" => "192.168.28.51",
        "description" => "Ruta de autenticación"
    ),
    "/api/info" => array(
        "server" => "192.168.28.51",
        "description" => "Ruta de información"
    )
);


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

// Listar todas la rutas disponibles
if ($current_url === "/api/routes") {
    // Crear un array para almacenar las rutas y su tipo
    $routes = array();
    // Agregar las rutas privadas con el tipo "requiere seguridad"
    foreach ($privateRoutes as $route => $data) {
        $routes[$route] = $data['description'] . " - requiere autenticacion";
    }

    // Agregar las rutas públicas con el tipo "libre"
    foreach ($publicRoutes as $route => $data) {
        $routes[$route] = $data['description'];
    }
    http_response_code(200); // Respuesta exitosa sin contenido
    echo json_encode($routes);
    return;
}

// Ruutas del Gateway
if (array_key_exists($current_url, $privateRoutes)) {
    if ($authHeader) {
        $auth_server_ip = '192.168.28.51';
        $auth_server_url = "http://$auth_server_ip/api/info";

        // Crear el array con el token
        $data = array('token' => $authHeader);

        // Convertir el array en formato JSON
        $json_data = json_encode($data);

        // Realizar la solicitud al servidor de autenticación
        $auth_response = file_get_contents($auth_server_url, false, stream_context_create([
            'http' => [
                'header' => "Content-type: application/json\r\n" .
                    "Authorization: $authHeader\r\n",
                'method' => 'POST',
                'content' => $json_data, // Agregar el contenido JSON en el cuerpo de la solicitud
                'ignore_errors' => true
            ]
        ]));

        // Obtener el código de respuesta del servidor de autenticación
        $auth_response_code = $http_response_header[0];
        $auth_response_code = (int)substr($auth_response_code, 9, 3);

        // Verificar el código de respuesta y tomar la acción correspondiente
        if ($auth_response_code === 200) {
            // El token es válido, continuar con la redirección
            $privateServer = $privateRoutes[$current_url]['server'];
            $privateServerUrl = "http://$privateServer" . $current_url;
            redirectRequest($privateServerUrl, $method, $authHeader);
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
        http_response_code(403);
        echo json_encode(array("message" => "No hay token o es un token invalido"));
        return;
    }
}

if (array_key_exists($current_url, $publicRoutes)) {
    $publicServer = $publicRoutes[$current_url]['server'];
    $publicServerUrl = "http://$publicServer" . $current_url;
    redirectRequest($publicServerUrl, $method, $authHeader);
    return;
}

http_response_code(404);
echo json_encode(array("message" => "Ruta gateway no encontrada: " . $complete_url));
return;
