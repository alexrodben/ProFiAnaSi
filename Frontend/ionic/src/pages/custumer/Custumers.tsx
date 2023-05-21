/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import { IonLabel, IonList, IonListHeader } from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonMenuButton, IonPage, IonTitle, IonToolbar } from "@ionic/react";
//import { useParams } from "react-router";
import ItemList from "../../components/ItemList";

const Customers: React.FC = () => {
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
      name: "Cliente 1",
      description: "Cliente 1",
      image: "https://ionicframework.com/docs/img/demos/thumbnail.svg",
    },
    {
      id: 2,
      name: "Cliente 2",
      description: "Cliente 2",
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
          <IonTitle>Clientes</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonList inset={true}>
          <IonListHeader color={"primary"}>
            <IonLabel>Listado de Clientes</IonLabel>
          </IonListHeader>

          {data.map((item, index) => {
            return <ItemList key={index} url={"custumers"} data={item} />;
          })}
        </IonList>
      </IonContent>
    </IonPage>
  );
};

export default Customers;
