import { productFormat, prueba } from "./ProductFormat";

export function searchDataProducts() {
  if (!localStorage["products"]) {
    localStorage["products"] = JSON.stringify(prueba);
  }
  let products = localStorage["products"];
  products = JSON.parse(products);
  return products;
}

export function removeDataProduct(remove: String) {
  let products = searchDataProducts();
  products = products.filter((product: productFormat) => product.id !== remove);
  localStorage["products"] = JSON.stringify(products);
}

export function editDataProduct(edit: productFormat) {
  let products = searchDataProducts();
  products = products.filter((product: productFormat) => product.id !== edit.id);
  products.push(edit);
  localStorage["products"] = JSON.stringify(products);
}

export function saveDataProduct(product: productFormat) {
  let products = searchDataProducts();
  products.push(product);
  localStorage["products"] = JSON.stringify(products);
  return true;
}

export function reloadDataProducts() {
  localStorage.removeItem("products");
  return searchDataProducts();
}
