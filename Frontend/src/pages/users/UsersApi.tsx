import { UsersFormat } from "./UsersFormat";

export function searchDataUsers(): UsersFormat[] {
  if (!localStorage["users"]) {
    localStorage["users"] = JSON.stringify([]);
  }
  let users = localStorage["users"];
  users = JSON.parse(users);
  return users;
}

export function removeDataUser(remove: string): void {
  let users = searchDataUsers();
  users = users.filter((user) => user.id !== remove);
  localStorage["users"] = JSON.stringify(users);
}

export function editDataUser(edit: UsersFormat): void {
  let users = searchDataUsers();
  users = users.filter((user) => user.id !== edit.id);
  users.push(edit);
  localStorage["users"] = JSON.stringify(users);
}

export function saveDataUser(user: UsersFormat): boolean {
  if (
    user.userId &&
    user.username &&
    user.password &&
    user.firstname &&
    user.lastname
  ) {
    let userList = searchDataUsers();
    userList.push(user);
    localStorage["users"] = JSON.stringify(userList);
    return true;
  }
  return false;
}

export function reloadDataUsers(): UsersFormat[] {
  localStorage.removeItem("users");
  return searchDataUsers();
}