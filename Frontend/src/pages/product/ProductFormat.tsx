export interface productFormat {
  id: string;
  registrationDate: string;
  updateDate: string;
  name: string;
  sku: string;
  status: string;
  description: string;
  minStock: string;
  maxStock: string;
  stock: string;
  image: string;
  unitPrice: string;
}

export const prueba: productFormat[] = [
  {
    id: "1",
    registrationDate: "2021-01-01",
    updateDate: "2021-01-01",
    name: "Producto 1",
    sku: "SKU 1",
    status: "Estado 1",
    description: "Descripción 1",
    minStock: "5",
    maxStock: "50",
    stock: "20",
    image: "URL de la imagen 1",
    unitPrice: "10.99",
  },
  {
    id: "2",
    registrationDate: "2021-01-02",
    updateDate: "2021-01-02",
    name: "Producto 2",
    sku: "SKU 2",
    status: "Estado 2",
    description: "Descripción 2",
    minStock: "10",
    maxStock: "100",
    stock: "30",
    image: "URL de la imagen 2",
    unitPrice: "19.99",
  },
];