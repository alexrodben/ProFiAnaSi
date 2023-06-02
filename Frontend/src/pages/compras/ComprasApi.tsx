import { compraFormat, prueba } from "./ComprasFormat";

export function searchDataCompra() {
  if (!localStorage["compra"]) {
    localStorage["compra"] = JSON.stringify(prueba);
  }
  let compras = localStorage["compra"];
  compras = JSON.parse(compras);
  return compras;
}

export function removeDataCompra(remove: string) {
  let compras = searchDataCompra();
  compras = compras.filter((item: compraFormat) => item.idCompra !== remove);
  localStorage["compra"] = JSON.stringify(compras);
}

export function editDataCompra(edit: compraFormat) {
  let compras = searchDataCompra();
  compras = compras.filter((item: compraFormat) => item.idCompra !== edit.idCompra);
  compras.push(edit);
  localStorage["compra"] = JSON.stringify(compras);
}

export function saveDataCompra(compra: compraFormat) {
  let compraList = searchDataCompra();
  compraList.push(compra);
  localStorage["compra"] = JSON.stringify(compraList);
  return true;
}

export function reloadDataCompra() {
  localStorage.removeItem("compra");
  return searchDataCompra();
}