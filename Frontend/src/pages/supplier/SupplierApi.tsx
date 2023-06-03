import { supplierFormat } from "./SupplierFormat";
import axios, { AxiosResponse } from 'axios';
import { URL } from "./../../config";

// GET
export function searchSupplierData(): supplierFormat[] {
  if (!localStorage["suppliers"]) {
    axios.get(URL + "proveedores", {
      headers: {
        Authorization: localStorage["token"]
      }
    })
      .then((response: AxiosResponse) => {
        localStorage["suppliers"] = JSON.stringify(response.data);
      })
      .catch((error) => {
        if (error.response && error.response.status === 403) {
          console.error('Acceso denegado. Redireccionando a /login...');
          localStorage.clear();
          window.location.href = '/login';
        } else {
          console.error('Error al obtener los proveedores:', error);
        }
      });
    return [];
  }
  let suppliers: supplierFormat[] = JSON.parse(localStorage["suppliers"]);
  return suppliers;
}

// DELETE
export async function removeSupplierData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "proveedores", {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let suppliers: supplierFormat[] = searchSupplierData();
    suppliers = suppliers.filter((supplier: supplierFormat) => supplier.Id_Proveedor !== remove);
    localStorage["suppliers"] = JSON.stringify(suppliers);
    return true;
  } catch (error) {
    console.error('Error al eliminar el proveedor:', error);
    return false;
  }
}

// PUT
export async function editSupplierData(edit: supplierFormat): Promise<boolean> {
  try {
    await axios.put(URL + "proveedores", edit, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let suppliers: supplierFormat[] = searchSupplierData();
    suppliers = suppliers.map((supplier: supplierFormat) => {
      if (supplier.Id_Proveedor === edit.Id_Proveedor) {
        return edit;
      }
      return supplier;
    });
    localStorage["suppliers"] = JSON.stringify(suppliers);
    return true;
  } catch (error) {
    console.error('Error al editar el proveedor:', error);
    return false;
  }
}

// POST
export async function saveSupplierData(supplier: supplierFormat): Promise<boolean> {
  try {
    await axios.post(URL + "proveedores", supplier, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let suppliers: supplierFormat[] = searchSupplierData();
    suppliers.push(supplier);
    localStorage["suppliers"] = JSON.stringify(suppliers);
    return true;
  } catch (error) {
    console.error('Error al guardar el proveedor:', error);
    return false;
  }
}
