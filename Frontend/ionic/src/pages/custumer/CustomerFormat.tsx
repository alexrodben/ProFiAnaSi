export interface customerFormat {
  id: string;
  name: string;
  address: string;
  nit: string;
  phone: string;
  email: string;
  registrationDate: string;
  updateDate: string;
}

export const prueba: customerFormat[] = [
  {
    id: "1",
    name: "Cliente 1",
    address: "Dirección 1",
    nit: "123456789",
    phone: "1234567890",
    email: "cliente1@example.com",
    registrationDate: "2021-01-01",
    updateDate: "2021-01-01",
  },
  {
    id: "2",
    name: "Cliente 2",
    address: "Dirección 2",
    nit: "987654321",
    phone: "0987654321",
    email: "cliente2@example.com",
    registrationDate: "2021-01-02",
    updateDate: "2021-01-02",
  },
];