import { productFormat } from "./ProductFormat";
import axios, { AxiosResponse } from 'axios';
import { URL } from "./../../config";

//GET
export function searchProductData(): productFormat[] {
  if (!localStorage["products"]) {
    axios.get(URL + "productos", {
      headers: {
        Authorization: localStorage["token"]
      }
    })
      .then((response: AxiosResponse) => {
        localStorage["products"] = JSON.stringify(response.data);
      })
      .catch((error) => {
        if (error.response && error.response.status === 403) {
          console.error('Acceso denegado. Redireccionando a /login...');
          localStorage.clear();
          window.location.href = '/login';
        } else {
          console.error('Error al obtener los productos:', error);
        }
      });
    return [];
  }
  let products: productFormat[] = JSON.parse(localStorage["products"]);
  return products;
}

//DELETE
export async function removeProductData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "productos", {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let products: productFormat[] = searchProductData();
    products = products.filter((product: productFormat) => product.Id_Producto !== remove);
    localStorage["products"] = JSON.stringify(products);
    return true;
  } catch (error) {
    console.error('Error al eliminar el producto:', error);
    return false;
  }
}

//PUT
export async function editProductData(edit: productFormat): Promise<boolean> {
  try {
    await axios.put(URL + "productos", edit, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let products: productFormat[] = searchProductData();
    products = products.map((product: productFormat) => {
      if (product.Id_Producto === edit.Id_Producto) {
        return edit;
      }
      return product;
    });
    localStorage["products"] = JSON.stringify(products);
    return true;
  } catch (error) {
    console.error('Error al editar el producto:', error);
    return false
  }
}

//POST
export async function saveProductData(product: productFormat): Promise<boolean> {
  try {
    await axios.post(URL + "productos", product, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let products: productFormat[] = searchProductData();
    products.push(product);
    localStorage["products"] = JSON.stringify(products);
    return true;
  } catch (error) {
    console.error('Error al guardar el producto:', error);
    return false;
  }
}
