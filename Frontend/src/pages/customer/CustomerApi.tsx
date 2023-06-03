import { customerFormat } from "./CustomerFormat";
import axios, { AxiosResponse } from 'axios';
import { URL } from "./../../config";

//GET
export function searchCustomerData(): customerFormat[] {
  if (!localStorage["customers"]) {
    axios.get(URL + "clientes", {
      headers: {
        Authorization: localStorage["token"]
      }
    })
      .then((response: AxiosResponse) => {
        localStorage["customers"] = JSON.stringify(response.data);
      })
      .catch((error) => {
        if (error.response && error.response.status === 403) {
          console.error('Acceso denegado. Redireccionando a /login...');
          localStorage.clear();
          window.location.href = '/login';
        } else {
          console.error('Error al obtener los clientes:', error);
        }
      });
    return [];
  }
  let customers: customerFormat[] = JSON.parse(localStorage["customers"]);
  return customers;
}

//DELETE
export async function removeCustomerData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "clientes", {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let customers: customerFormat[] = searchCustomerData();
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
    let customers: customerFormat[] = searchCustomerData();
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
    let customers: customerFormat[] = searchCustomerData();
    customers.push(customer);
    localStorage["customers"] = JSON.stringify(customers);
    return true;
  } catch (error) {
    console.error('Error al guardar el cliente:', error);
    return false;
  }
}
