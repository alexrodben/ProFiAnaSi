export interface kardexFormat {
  id: string;
  fecha: string;
  detalle: string;
  cantidad: string;
  valorUnitario: string;
  valorTotal: string;
}

export const prueba: kardexFormat[] = [
  {
    id: "1",
    fecha: "2021-01-01",
    detalle: "Detalle 1",
    cantidad: "10",
    valorUnitario: "100",
    valorTotal: "1000",
  },
  {
    id: "2",
    fecha: "2021-01-02",
    detalle: "Detalle 2",
    cantidad: "5",
    valorUnitario: "50",
    valorTotal: "250",
  },
];