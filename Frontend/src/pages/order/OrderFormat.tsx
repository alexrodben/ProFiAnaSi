export interface orderFormat {
  id: string;
  registrationDate: string;
  updateDate: string;
  product: string;
  provider: string;
  transactionType: string;
  quantity: string;
}

export const prueba: orderFormat[] = [
  {
    id: "1",
    registrationDate: "2021-01-01",
    updateDate: "2021-01-01",
    product: "Transacción 1",
    provider: "Proveedor 1",
    transactionType: "Tipo 1",
    quantity: "10",
  },
  {
    id: "2",
    registrationDate: "2021-01-02",
    updateDate: "2021-01-02",
    product: "Transacción 2",
    provider: "Proveedor 2",
    transactionType: "Tipo 2",
    quantity: "20",
  },
];
