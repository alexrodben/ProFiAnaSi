import { loginFormat } from "./LoginFormat";
import axios, { AxiosResponse } from 'axios';
import { URL } from "./../../config";

export async function loginData(login: loginFormat): Promise<boolean> {
    try {
        const response: AxiosResponse = await axios.post(URL + "auth", login);
        if (response.status === 200) {
            const responseData = response.data;

            if (responseData.hasOwnProperty("token")) {
                localStorage.setItem("token", responseData.token);
                return true;
            } else {
                console.error('La respuesta no contiene un token válido:', responseData);
                return false;
            }
        } else {
            console.error('Respuesta incorrecta del servidor:', response);
            return false;
        }
    } catch (error) {
        console.error('Error al realizar la solicitud de autenticación:', error);
        return false;
    }
}
