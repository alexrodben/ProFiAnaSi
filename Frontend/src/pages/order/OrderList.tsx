/* eslint-disable react/jsx-no-comment-textnodes */
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
import { reloadDataOrders, searchDataOrders } from "./OrderApi";
import { orderFormat } from "./OrderFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import OrderAdd from "./OrderAdd";
import OrderEdit from "./OrderEdit";

const OrderList: React.FC = () => {
  const [orderData, setOrderData] = useState<orderFormat[]>([]);

  useEffect(() => {
    searchOrders();
  }, []);

  const searchOrders = () => {
    let list = searchDataOrders();
    setOrderData(list);
  };

  const reload = () => {
    reloadDataOrders();
    searchOrders();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchOrders();
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
          <IonTitle>Transacciones</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent></IonRefresherContent>
        </IonRefresher>
        <IonCard>
          <IonTitle>Gestión de las transacciones</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={() => <OrderAdd />}>
              <IonButton color={"success"} fill="solid" slot="end" size="small">
                Agregar transacción
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color={"secondary"} onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color={"primary"}>
              <IonLabel>Listado de Transacciones</IonLabel>
            </IonListHeader>
            {orderData.map((order, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img alt={order.product} src="https://ionicframework.com/docs/img/demos/thumbnail.svg" />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{order.product}</IonCardTitle>
                    <IonCardSubtitle>{order.provider}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <OrderEdit item={order} />}>
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

export default OrderList;
