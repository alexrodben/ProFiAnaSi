import { orderFormat, prueba } from "./OrderFormat";

export function searchDataOrders() {
  if (!localStorage["orders"]) {
    localStorage["orders"] = JSON.stringify(prueba);
  }
  let orders = localStorage["orders"];
  orders = JSON.parse(orders);
  return orders;
}

export function removeDataOrder(remove: string) {
  let orders = searchDataOrders();
  orders = orders.filter((order: orderFormat) => order.id !== remove);
  localStorage["orders"] = JSON.stringify(orders);
}

export function editDataOrder(edit: orderFormat) {
  let orders = searchDataOrders();
  orders = orders.filter((order: orderFormat) => order.id !== edit.id);
  orders.push(edit);
  localStorage["orders"] = JSON.stringify(orders);
}

export function saveDataOrder(order: orderFormat) {
  let orders = searchDataOrders();
  orders.push(order);
  localStorage["orders"] = JSON.stringify(orders);
  return true;
}

export function reloadDataOrders() {
  localStorage.removeItem("orders");
  return searchDataOrders();
}