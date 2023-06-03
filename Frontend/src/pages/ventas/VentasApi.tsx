import axios from 'axios';
import { ventasFormat } from './VentasFormat';
import { URL } from "../../config";

// GET
export async function searchVentasData(): Promise<ventasFormat[]> {
  if (!localStorage["ventas"]) {
    try {
      const response = await axios.get(URL + "ventas", {
        headers: {
          Authorization: localStorage["token"]
        }
      });
      localStorage["ventas"] = JSON.stringify(response.data);
      return response.data;
    } catch (error: any) {
      if (error.response && error.response.status === 403) {
        console.error('Acceso denegado. Redireccionando a /login...');
        localStorage.clear();
        window.location.href = '/login';
      } else {
        console.error('Error al obtener las ventas:', error);
      }
    }
    return [];
  }
  let ventas: ventasFormat[] = JSON.parse(localStorage["ventas"]);
  return ventas;
}

// DELETE
export async function removeVentaData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "ventas/" + remove, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let ventas: ventasFormat[] = await searchVentasData();
    ventas = ventas.filter((venta: ventasFormat) => venta.Id_Venta !== remove);
    localStorage["ventas"] = JSON.stringify(ventas);
    return true;
  } catch (error) {
    console.error('Error al eliminar la venta:', error);
    return false;
  }
}

// PUT
export async function editVentaData(edit: ventasFormat): Promise<boolean> {
  try {
    await axios.put(URL + "ventas/" + edit.Id_Venta, edit, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let ventas: ventasFormat[] = await searchVentasData();
    ventas = ventas.map((venta: ventasFormat) => {
      if (venta.Id_Venta === edit.Id_Venta) {
        return edit;
      }
      return venta;
    });
    localStorage["ventas"] = JSON.stringify(ventas);
    return true;
  } catch (error) {
    console.error('Error al editar la venta:', error);
    return false;
  }
}

// POST
export async function saveVentaData(venta: ventasFormat): Promise<boolean> {
  try {
    await axios.post(URL + "ventas", venta, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let ventas: ventasFormat[] = await searchVentasData();
    ventas.push(venta);
    localStorage["ventas"] = JSON.stringify(ventas);
    return true;
  } catch (error) {
    console.error('Error al guardar la venta:', error);
    return false;
  }
}
