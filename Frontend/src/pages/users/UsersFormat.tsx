export interface UsersFormat {
  id: string;
  userId: string;
  username: string;
  password: string;
  firstname: string;
  lastname: string;
}

export const prueba: UsersFormat[] = [
  {
    id: "1",
    userId: "user1",
    username: "john_doe",
    password: "123456",
    firstname: "John",
    lastname: "Doe",
  },
  {
    id: "2",
    userId: "user2",
    username: "jane_smith",
    password: "abcdef",
    firstname: "Jane",
    lastname: "Smith",
  },
];