import { supplierFormat } from "./SupplierFormat";
import { URL } from "./../../config";
import axios from 'axios';

// GET
export async function searchSupplierData(): Promise<supplierFormat[]> {
  if (!localStorage["suppliers"]) {
    try {
      const response = await axios.get(URL + "proveedores", {
        headers: {
          Authorization: localStorage["token"]
        }
      });
      localStorage["suppliers"] = JSON.stringify(response.data);
      return response.data;
    } catch (error: any) {
      if (error.response && error.response.status === 403) {
        console.error('Acceso denegado. Redireccionando a /login...');
        localStorage.clear();
        window.location.href = '/login';
      } else {
        console.error('Error al obtener los proveedores:', error);
      }
      return [];
    }
  }
  return JSON.parse(localStorage["suppliers"]);
}


// DELETE
export async function removeSupplierData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "proveedores", {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let suppliers: supplierFormat[] = await searchSupplierData();
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
    let suppliers: supplierFormat[] = await searchSupplierData();
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
    let suppliers: supplierFormat[] = await searchSupplierData();
    suppliers.push(supplier);
    localStorage["suppliers"] = JSON.stringify(suppliers);
    return true;
  } catch (error) {
    console.error('Error al guardar el proveedor:', error);
    return false;
  }
}
