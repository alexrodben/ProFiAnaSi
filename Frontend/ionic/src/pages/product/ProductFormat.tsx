export interface productFormat {
  id: string;
  name: string;
  price: string;
  description: string;
  image: string;
  estado: string;
}

export const prueba: productFormat[] = [
  {
    id: "1",
    name: "Producto 1",
    price: "10.00",
    description: "Producto 1",
    image: "https://ionicframework.com/docs/img/demos/thumbnail.svg",
    estado: "Activo",
  },
  {
    id: "2",
    name: "Producto 2",
    price: "10.00",
    description: "Producto 2",
    image: "https://ionicframework.com/docs/img/demos/thumbnail.svg",
    estado: "Inactivo",
  },
];
