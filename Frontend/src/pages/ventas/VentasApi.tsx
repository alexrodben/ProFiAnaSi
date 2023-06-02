import { ventaFormat, prueba } from "./VentasFormat";

export function searchDataVenta() {
  if (!localStorage["venta"]) {
    localStorage["venta"] = JSON.stringify(prueba);
  }
  let ventas = localStorage["venta"];
  ventas = JSON.parse(ventas);
  return ventas;
}

export function removeDataVenta(remove: string) {
  let ventas = searchDataVenta();
  ventas = ventas.filter((item: ventaFormat) => item.idVenta !== remove);
  localStorage["venta"] = JSON.stringify(ventas);
}

export function editDataVenta(edit: ventaFormat) {
  let ventas = searchDataVenta();
  ventas = ventas.filter((item: ventaFormat) => item.idVenta !== edit.idVenta);
  ventas.push(edit);
  localStorage["venta"] = JSON.stringify(ventas);
}

export function saveDataVenta(venta: ventaFormat) {
  let ventaList = searchDataVenta();
  ventaList.push(venta);
  localStorage["venta"] = JSON.stringify(ventaList);
  return true;
}

export function reloadDataVenta() {
  localStorage.removeItem("venta");
  return searchDataVenta();
}