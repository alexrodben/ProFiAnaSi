/* eslint-disable react/jsx-no-comment-textnodes */
import React, { useState } from "react";
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
  IonTitle,
  IonToolbar,
  useIonViewWillEnter
} from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonMenuButton } from "@ionic/react";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import { searchVentasData } from "./VentasApi";
import { ventasFormat } from "./VentasFormat";
import VentasEdit from "./VentasEdit";
import VentasAdd from "./VentasAdd";

const VentasList: React.FC = () => {
  const [ventasData, setVentasData] = useState<ventasFormat[]>([]);
  const [showLoading, setShowLoading] = useState(false);

  useIonViewWillEnter(() => {
    searchVentas();
  });

  const searchVentas = async () => {
    setShowLoading(true);
    let list = await searchVentasData();
    setVentasData(list);
    setTimeout(() => {
      setShowLoading(false);
    }, 1000);
  };

  const reload = () => {
    localStorage.removeItem("ventas");
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
        <IonLoading
          isOpen={showLoading}
          onDidDismiss={() => setShowLoading(false)}
          message={'Cargando datos. Espere por favor...'}
        />
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
                  <IonCardHeader>
                    <IonCardTitle>{venta.Id_Cliente} {venta.CreatedAt}</IonCardTitle>
                    <IonCardSubtitle>{venta.Fecha}</IonCardSubtitle>
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