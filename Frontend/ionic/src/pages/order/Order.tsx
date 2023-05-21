/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import { IonLabel, IonList, IonListHeader } from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonMenuButton, IonPage, IonTitle, IonToolbar } from "@ionic/react";
import ItemList from "../../components/ItemList";

const Orders: React.FC = () => {
  interface DataFormat {
    id: number;
    name: string;
    description: string;
    image: string;
  }

  const data: DataFormat[] = [
    {
      id: 1,
      name: "Orden 1",
      description: "Orden 1",
      image: "https://ionicframework.com/docs/img/demos/thumbnail.svg",
    },
    {
      id: 2,
      name: "Orden 2",
      description: "Orden 2",
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
          <IonTitle>Ordenes</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonList inset={true}>
          <IonListHeader color={"primary"}>
            <IonLabel>Listado de Ordenes</IonLabel>
          </IonListHeader>

          {data.map((item, index) => {
            return <ItemList key={index} data={item} url={"orders"} image={true} />;
          })}
        </IonList>
      </IonContent>
    </IonPage>
  );
};

export default Orders;
