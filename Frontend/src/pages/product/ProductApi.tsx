import { productFormat, prueba } from "./ProductFormat";

export function searchProductData() {
  if (!localStorage["products"]) {
    localStorage["products"] = JSON.stringify(prueba);
  }
  let products = localStorage["products"];
  products = JSON.parse(products);
  return products;
}

export function removeProductData(remove: string) {
  let products = searchProductData();
  products = products.filter((product: productFormat) => product.id !== remove);
  localStorage["products"] = JSON.stringify(products);
}

export function editProductData(edit: productFormat) {
  let products = searchProductData();
  products = products.filter((product: productFormat) => product.id !== edit.id);
  products.push(edit);
  localStorage["products"] = JSON.stringify(products);
}

export function saveProductData(product: productFormat) {
  let products = searchProductData();
  products.push(product);
  localStorage["products"] = JSON.stringify(products);
  return true;
}

export function reloadProductData() {
  localStorage.removeItem("products");
  return searchProductData();
}