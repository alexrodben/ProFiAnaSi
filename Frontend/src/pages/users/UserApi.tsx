import { userFormat } from './UserFormat';
import { URL } from "../../config";
import axios from 'axios';

// GET
export async function searchUserData(): Promise<userFormat[]> {
  if (!localStorage["users"]) {
    try {
      const response = await axios.get(URL + "usuarios", {
        headers: {
          Authorization: localStorage["token"]
        }
      });
      localStorage["users"] = JSON.stringify(response.data);
      return response.data;
    } catch (error: any) {
      if (error.response && error.response.status === 403) {
        console.error('Acceso denegado. Redireccionando a /login...');
        localStorage.clear();
        window.location.href = '/login';
      } else {
        console.error('Error al obtener los usuarios:', error);
      }
      return [];
    }
  }
  return JSON.parse(localStorage["users"]);
}


// DELETE
export async function removeUserData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "usuarios", {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let users: userFormat[] = await searchUserData();
    users = users.filter((user: userFormat) => user.id_usuario !== remove);
    localStorage["users"] = JSON.stringify(users);
    return true;
  } catch (error) {
    console.error('Error al eliminar el usuario:', error);
    return false;
  }
}

// PUT
export async function editUserData(edit: userFormat): Promise<boolean> {
  try {
    await axios.put(URL + "usuarios", edit, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let users: userFormat[] = await searchUserData();
    users = users.map((user: userFormat) => {
      if (user.id_usuario === edit.id_usuario) {
        return edit;
      }
      return user;
    });
    localStorage["users"] = JSON.stringify(users);
    return true;
  } catch (error) {
    console.error('Error al editar el usuario:', error);
    return false;
  }
}

// POST
export async function saveUserData(user: userFormat): Promise<boolean> {
  try {
    await axios.post(URL + "usuarios", user, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let users: userFormat[] = await searchUserData();
    users.push(user);
    localStorage["users"] = JSON.stringify(users);
    return true;
  } catch (error) {
    console.error('Error al guardar el usuario:', error);
    return false;
  }
}
