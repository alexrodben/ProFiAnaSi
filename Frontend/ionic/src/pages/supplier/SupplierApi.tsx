import { supplierFormat, prueba } from "./SupplierFormat";

export interface SupplierFormat extends supplierFormat {}

export function searchDataSuppliers() {
  if (!localStorage["suppliers"]) {
    localStorage["suppliers"] = JSON.stringify(prueba);
  }
  let suppliers = localStorage["suppliers"];
  suppliers = JSON.parse(suppliers);
  return suppliers;
}

export function removeDataSupplier(remove: string) {
  let suppliers = searchDataSuppliers();
  suppliers = suppliers.filter((supplier: supplierFormat) => supplier.id !== remove);
  localStorage["suppliers"] = JSON.stringify(suppliers);
}

export function editDataSupplier(edit: supplierFormat) {
  let suppliers = searchDataSuppliers();
  suppliers = suppliers.filter((supplier: supplierFormat) => supplier.id !== edit.id);
  suppliers.push(edit);
  localStorage["suppliers"] = JSON.stringify(suppliers);
}

export function saveDataSupplier(supplier: supplierFormat) {
  let suppliers = searchDataSuppliers();
  suppliers.push(supplier);
  localStorage["suppliers"] = JSON.stringify(suppliers);
  return true;
}

export function reloadDataSuppliers() {
  localStorage.removeItem("suppliers");
  return searchDataSuppliers();
}