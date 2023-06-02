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
  IonTitle,
  IonToolbar,
  useIonViewWillEnter
} from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonMenuButton } from "@ionic/react";
import { reloadDataVenta, searchDataVenta } from "./VentasApi";
import { ventaFormat } from "./VentasFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import VentasAdd from "./VentasAdd";
import VentasEdit from "./VentasEdit";

const VentasList: React.FC = () => {
  const [ventasData, setVentasData] = useState<ventaFormat[]>([]);

  useIonViewWillEnter(() => {
    searchVentas();
  });

  const searchVentas = () => {
    let list = searchDataVenta();
    setVentasData(list);
  };

  const reload = () => {
    reloadDataVenta();
    searchVentas();
  };

  const handleRefresh = (event: CustomEvent) => {
    setTimeout(() => {
      searchVentas();
      event.detail.complete();
    }, 2000);
  };

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton />
          </IonButtons>
          <IonTitle>Ventas</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent></IonRefresherContent>
        </IonRefresher>
        <IonCard>
          <IonTitle>Gestión de Ventas</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={VentasAdd}>
              <IonButton color="success" fill="solid" slot="end" size="small">
                Agregar venta
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color="secondary" onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color="primary">
              <IonLabel>Listado de Ventas</IonLabel>
            </IonListHeader>
            {ventasData.map((venta, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img alt={venta.idVenta} src="https://ionicframework.com/docs/img/demos/thumbnail.svg" />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{venta.idVenta}</IonCardTitle>
                    <IonCardSubtitle>{venta.detalle}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <VentasEdit item={venta} />}>
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

export default VentasList;