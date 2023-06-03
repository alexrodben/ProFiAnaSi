import { customerFormat } from "./CustomerFormat";
import { URL } from "./../../config";
import axios from 'axios';

//GET
export async function searchCustomerData(): Promise<customerFormat[]> {
  if (!localStorage["customers"]) {
    try {
      const response = await axios.get(URL + "clientes", {
        headers: {
          Authorization: localStorage["token"]
        }
      });
      localStorage["customers"] = JSON.stringify(response.data);
      return response.data;
    } catch (error: any) {
      if (error.response && error.response.status === 403) {
        console.error('Acceso denegado. Redireccionando a /login...');
        localStorage.clear();
        window.location.href = '/login';
      } else {
        console.error('Error al obtener los clientes:', error);
      }
      return [];
    }
  }
  return JSON.parse(localStorage["customers"]);
}


//DELETE
export async function removeCustomerData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "clientes", {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let customers: customerFormat[] = await searchCustomerData();
    customers = customers.filter((customer: customerFormat) => customer.Id_Cliente !== remove);
    localStorage["customers"] = JSON.stringify(customers);
    return true;
  } catch (error) {
    console.error('Error al eliminar el cliente:', error);
    return false;
  }
}

//PUT
export async function editCustomerData(edit: customerFormat): Promise<boolean> {
  try {
    await axios.put(URL + "clientes", edit, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let customers: customerFormat[] = await searchCustomerData();
    customers = customers.map((customer: customerFormat) => {
      if (customer.Id_Cliente === edit.Id_Cliente) {
        return edit;
      }
      return customer;
    });
    localStorage["customers"] = JSON.stringify(customers);
    return true;
  } catch (error) {
    console.error('Error al editar el cliente:', error);
    return false;
  }
}

//POST
export async function saveCustomerData(customer: customerFormat): Promise<boolean> {
  try {
    await axios.post(URL + "clientes", customer, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let customers: customerFormat[] = await searchCustomerData();
    customers.push(customer);
    localStorage["customers"] = JSON.stringify(customers);
    return true;
  } catch (error) {
    console.error('Error al guardar el cliente:', error);
    return false;
  }
}
