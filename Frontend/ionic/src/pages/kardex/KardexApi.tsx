import { kardexFormat, prueba } from "./KardexFormat";

export function searchDataKardex() {
  if (!localStorage["kardex"]) {
    localStorage["kardex"] = JSON.stringify(prueba);
  }
  let kardex = localStorage["kardex"];
  kardex = JSON.parse(kardex);
  return kardex;
}

export function removeDataKardex(remove: string) {
  let kardex = searchDataKardex();
  kardex = kardex.filter((item: kardexFormat) => item.id !== remove);
  localStorage["kardex"] = JSON.stringify(kardex);
}

export function editDataKardex(edit: kardexFormat) {
  let kardex = searchDataKardex();
  kardex = kardex.filter((item: kardexFormat) => item.id !== edit.id);
  kardex.push(edit);
  localStorage["kardex"] = JSON.stringify(kardex);
}

export function saveDataKardex(kardex: kardexFormat) {
  let kardexData = searchDataKardex();
  kardexData.push(kardex);
  localStorage["kardex"] = JSON.stringify(kardexData);
  return true;
}

export function reloadDataKardex() {
  localStorage.removeItem("kardex");
  return searchDataKardex();
}