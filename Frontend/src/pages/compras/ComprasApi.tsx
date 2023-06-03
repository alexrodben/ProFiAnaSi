import axios from 'axios';
import { comprasFormat } from './ComprasFormat';
import { URL } from "../../config";

// GET
export async function searchComprasData(): Promise<comprasFormat[]> {
  if (!localStorage["compras"]) {
    try {
      const response = await axios.get(URL + "compras", {
        headers: {
          Authorization: localStorage["token"]
        }
      });
      localStorage["compras"] = JSON.stringify(response.data);
      return response.data;
    } catch (error: any) {
      if (error.response && error.response.status === 403) {
        console.error('Acceso denegado. Redireccionando a /login...');
        localStorage.clear();
        window.location.href = '/login';
      } else {
        console.error('Error al obtener las compras:', error);
      }
    }
    return [];
  }
  let compras: comprasFormat[] = JSON.parse(localStorage["compras"]);
  return compras;
}

// DELETE
export async function removeCompraData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "compras/" + remove, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let compras: comprasFormat[] = await searchComprasData();
    compras = compras.filter((compra: comprasFormat) => compra.Id_Compra !== remove);
    localStorage["compras"] = JSON.stringify(compras);
    return true;
  } catch (error) {
    console.error('Error al eliminar la compra:', error);
    return false;
  }
}

// PUT
export async function editCompraData(edit: comprasFormat): Promise<boolean> {
  try {
    await axios.put(URL + "compras/" + edit.Id_Compra, edit, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let compras: comprasFormat[] = await searchComprasData();
    compras = compras.map((compra: comprasFormat) => {
      if (compra.Id_Compra === edit.Id_Compra) {
        return edit;
      }
      return compra;
    });
    localStorage["compras"] = JSON.stringify(compras);
    return true;
  } catch (error) {
    console.error('Error al editar la compra:', error);
    return false;
  }
}

// POST
export async function saveCompraData(compra: comprasFormat): Promise<boolean> {
  try {
    await axios.post(URL + "compras", compra, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let compras: comprasFormat[] = await searchComprasData();
    compras.push(compra);
    localStorage["compras"] = JSON.stringify(compras);
    return true;
  } catch (error) {
    console.error('Error al guardar la compra:', error);
    return false;
  }
}
