import { loginFormat } from "./LoginFormat";
import axios, { AxiosResponse } from 'axios';
import { URL } from "./../../config";

export async function loginData(login: loginFormat): Promise<String> {
    try {
        const response: AxiosResponse = await axios.post(URL + "auth", login);
        if (response.status === 200) {
            const responseData = response.data;

            if (responseData.hasOwnProperty("token")) {
                localStorage.setItem("token", responseData.token);
                return "true";
            } else {
                console.error('La respuesta no contiene un token válido:', responseData);
                return "la respuesta no contiene un token válido ";
            }
        } else if (response.status === 401) {
            console.error('Usuario o contraseña incorrecta:', response);
            return "respuesta incorrecta del servidor";
        }
    } catch (error) {
        console.error('al realizar la solicitud de autenticación:', error);
        return "al realizar la solicitud de autenticación";
    }
    return "No hay conexion a internet";
}
