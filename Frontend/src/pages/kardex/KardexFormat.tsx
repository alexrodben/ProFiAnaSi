export interface kardexFormat {
  id: string;
  fecha: string;
  detalle: string;
  tipoTransaccion: string;
  cantidad: string;
  valorUnitario: string;
  valorTotal: string;
  stock: string;
}

export const prueba: kardexFormat[] = [
  {
    id: "1",
    fecha: "2021-01-01",
    detalle: "Detalle 1",
    tipoTransaccion: "Tipo 1",
    cantidad: "10",
    valorUnitario: "50",
    valorTotal: "500",
    stock: "100",
  },
  {
    id: "2",
    fecha: "2021-01-02",
    detalle: "Detalle 2",
    tipoTransaccion: "Tipo 2",
    cantidad: "20",
    valorUnitario: "30",
    valorTotal: "600",
    stock: "80",
  },
];