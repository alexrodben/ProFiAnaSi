import axios, { AxiosResponse } from 'axios';
import { categoryFormat } from './CategoryFormat';
import { URL } from "../../config";

// GET
export function searchCategoryData(): categoryFormat[] {
  if (!localStorage["categories"]) {
    axios.get(URL + "categorias", {
      headers: {
        Authorization: localStorage["token"]
      }
    })
      .then((response: AxiosResponse) => {
        localStorage["categories"] = JSON.stringify(response.data);
      })
      .catch((error) => {
        if (error.response && error.response.status === 403) {
          console.error('Acceso denegado. Redireccionando a /login...');
          localStorage.clear();
          window.location.href = '/login';
        } else {
          console.error('Error al obtener las categorías:', error);
        }
      });
    return [];
  }
  let categories: categoryFormat[] = JSON.parse(localStorage["categories"]);
  return categories;
}

// DELETE
export async function removeCategoryData(remove: string): Promise<boolean> {
  try {
    await axios.delete(URL + "categorias", {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let categories: categoryFormat[] = searchCategoryData();
    categories = categories.filter((category: categoryFormat) => category.Id_Categoria !== remove);
    localStorage["categories"] = JSON.stringify(categories);
    return true;
  } catch (error) {
    console.error('Error al eliminar la categoría:', error);
    return false;
  }
}

// PUT
export async function editCategoryData(edit: categoryFormat): Promise<boolean> {
  try {
    await axios.put(URL + "categorias", edit, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let categories: categoryFormat[] = searchCategoryData();
    categories = categories.map((category: categoryFormat) => {
      if (category.Id_Categoria === edit.Id_Categoria) {
        return edit;
      }
      return category;
    });
    localStorage["categories"] = JSON.stringify(categories);
    return true;
  } catch (error) {
    console.error('Error al editar la categoría:', error);
    return false;
  }
}

// POST
export async function saveCategoryData(category: categoryFormat): Promise<boolean> {
  try {
    await axios.post(URL + "categorias", category, {
      headers: {
        Authorization: localStorage["token"]
      }
    });
    let categories: categoryFormat[] = searchCategoryData();
    categories.push(category);
    localStorage["categories"] = JSON.stringify(categories);
    return true;
  } catch (error) {
    console.error('Error al guardar la categoría:', error);
    return false;
  }
}
