import { categoryFormat, prueba } from "./CategoryFormat";

export function searchDataCategories() {
  if (!localStorage["categories"]) {
    localStorage["categories"] = JSON.stringify(prueba);
  }
  let categories = localStorage["categories"];
  categories = JSON.parse(categories);
  return categories;
}

export function removeDataCategory(remove: string) {
  let categories = searchDataCategories();
  categories = categories.filter((category: categoryFormat) => category.id !== remove);
  localStorage["categories"] = JSON.stringify(categories);
}

export function editDataCategory(edit: categoryFormat) {
  let categories = searchDataCategories();
  categories = categories.filter((category: categoryFormat) => category.id !== edit.id);
  categories.push(edit);
  localStorage["categories"] = JSON.stringify(categories);
}

export function saveDataCategory(category: categoryFormat) {
  let categories = searchDataCategories();
  categories.push(category);
  localStorage["categories"] = JSON.stringify(categories);
  return true;
}

export function reloadDataCategories() {
  localStorage.removeItem("categories");
  return searchDataCategories();
}