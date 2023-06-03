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
  IonLoading,
  IonNavLink,
  IonRefresher,
  IonRefresherContent,
  RefresherEventDetail,
} from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonMenuButton, IonTitle, IonToolbar } from "@ionic/react";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import { searchCustomerData } from "./CustomerApi";
import { customerFormat } from "./CustomerFormat";
import CustomerEdit from "./CustomerEdit";
import CustomerAdd from "./CustomerAdd";

const CustomerList: React.FC = () => {
  const [customerData, setCustomerData] = useState<customerFormat[]>([]);
  const [showLoading, setShowLoading] = useState(false);

  useEffect(() => {
    searchCustomers();
  }, []);

  const searchCustomers = async () => {
    let list = await searchCustomerData();
    setShowLoading(true)
    setCustomerData(list);
    setTimeout(() => {
      setShowLoading(false);
    }, 1000);
  };

  const reload = () => {
    localStorage.removeItem("customers");
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
        <IonLoading
          isOpen={showLoading}
          onDidDismiss={() => setShowLoading(false)}
          message={'Cargando datos. Espere por favor...'}
        />
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
                  <IonCardHeader>
                    <IonCardTitle>{customer.Nombre}</IonCardTitle>
                    <IonCardSubtitle>{customer.Direccion}</IonCardSubtitle>
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