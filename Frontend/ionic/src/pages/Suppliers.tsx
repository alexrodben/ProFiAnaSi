/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./Page.css";

import { IonLabel, IonList, IonListHeader } from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonMenuButton, IonPage, IonTitle, IonToolbar } from "@ionic/react";
//import { useParams } from "react-router";
import ItemList from "../components/ItemList";

const Suppliers: React.FC = () => {
  //  const { name } = useParams<{ name: string }>();

  interface DataFormat {
    id: number;
    name: string;
    description: string;
    image: string;
  }

  const data: DataFormat[] = [
    {
      id: 1,
      name: "Proveedore 1",
      description: "Proveedore 1",
      image: "https://ionicframework.com/docs/img/demos/thumbnail.svg",
    },
    {
      id: 2,
      name: "Proveedore 2",
      description: "Proveedore 2",
      image: "https://ionicframework.com/docs/img/demos/thumbnail.svg",
    },
  ];
  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton />
          </IonButtons>
          <IonTitle>Proveedores</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonList inset={true}>
          <IonListHeader color={"primary"}>
            <IonLabel>Listado de Proveedores</IonLabel>
          </IonListHeader>

          {data.map((item, index) => {
            return <ItemList key={index} url={"suppliers"} data={item} />;
          })}
        </IonList>
      </IonContent>
    </IonPage>
  );
};

export default Suppliers;
