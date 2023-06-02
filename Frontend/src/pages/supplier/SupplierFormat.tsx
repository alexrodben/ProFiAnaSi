export interface supplierFormat {
  id: string;
  name: string;
  address: string;
  nit: string;
  phone: string;
  email: string;
  status: string;
}

export const prueba: supplierFormat[] = [
  {
    id: "1",
    name: "Proveedor 1",
    address: "Dirección 1",
    nit: "123456789",
    phone: "1234567890",
    email: "proveedor1@example.com",
    status: "Activo",
  },
  {
    id: "2",
    name: "Proveedor 2",
    address: "Dirección 2",
    nit: "987654321",
    phone: "0987654321",
    email: "proveedor2@example.com",
    status: "Inactivo",
  },
];