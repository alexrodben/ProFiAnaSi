import { customerFormat, prueba } from "./CustomerFormat";

export function searchDataCustomers() {
  if (!localStorage["customers"]) {
    localStorage["customers"] = JSON.stringify(prueba);
  }
  let customers = localStorage["customers"];
  customers = JSON.parse(customers);
  return customers;
}

export function removeDataCustomer(remove: string) {
  let customers = searchDataCustomers();
  customers = customers.filter((customer: customerFormat) => customer.id !== remove);
  localStorage["customers"] = JSON.stringify(customers);
}

export function editDataCustomer(edit: customerFormat) {
  let customers = searchDataCustomers();
  customers = customers.filter((customer: customerFormat) => customer.id !== edit.id);
  customers.push(edit);
  localStorage["customers"] = JSON.stringify(customers);
}

export function saveDataCustomer(customer: customerFormat) {
  let customers = searchDataCustomers();
  customers.push(customer);
  localStorage["customers"] = JSON.stringify(customers);
  return true;
}

export function reloadDataCustomers() {
  localStorage.removeItem("customers");
  return searchDataCustomers();
}