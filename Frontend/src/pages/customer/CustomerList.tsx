import React, { useEffect, useState } from "react";
import "./../Page.css";

import {
  IonButton,
  IonCard,
  IonCardHeader,
  IonCardSubtitle,
  IonCardTitle,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonListHeader,
  IonNavLink,
  IonRefresher,
  IonRefresherContent,
  IonThumbnail,
  RefresherEventDetail,
} from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonMenuButton, IonTitle, IonToolbar } from "@ionic/react";
import { reloadDataCustomers, searchDataCustomers } from "./CustomerApi";
import { customerFormat } from "./CustomerFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import CustomerAdd from "./CustomerAdd";
import CustomerEdit from "./CustomerEdit";

const CustomerList: React.FC = () => {
  const [customerData, setCustomerData] = useState<customerFormat[]>([]);

  useEffect(() => {
    searchCustomers();
  }, []);

  const searchCustomers = () => {
    let list = searchDataCustomers();
    setCustomerData(list);
  };

  const reload = () => {
    reloadDataCustomers();
    searchCustomers();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchCustomers();
      // Any calls to load data go here
      event.detail.complete();
    }, 2000);
  }

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton />
          </IonButtons>
          <IonTitle>Clientes</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent></IonRefresherContent>
        </IonRefresher>
        <IonCard>
          <IonTitle>Gestión de los clientes</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={() => <CustomerAdd />}>
              <IonButton color={"success"} fill="solid" slot="end" size="small">
                Agregar cliente
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color={"secondary"} onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color={"primary"}>
              <IonLabel>Listado de Clientes</IonLabel>
            </IonListHeader>
            {customerData.map((customer, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img alt={customer.name} src="https://ionicframework.com/docs/img/demos/thumbnail.svg" />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{customer.name}</IonCardTitle>
                    <IonCardSubtitle>{customer.address}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <CustomerEdit item={customer} />}>
                    <IonButton shape="round" size="small" fill="outline">
                      <IonIcon icon={chevronForward} />
                    </IonButton>
                  </IonNavLink>
                </IonItem>
              );
            })}
          </IonList>
        </IonCard>
      </IonContent>
    </>
  );
};

export default CustomerList;