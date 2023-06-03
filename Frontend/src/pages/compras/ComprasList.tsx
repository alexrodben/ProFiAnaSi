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
import { searchComprasData } from "./ComprasApi";
import { comprasFormat } from "./ComprasFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import ComprasAdd from "./ComprasAdd";
import ComprasEdit from "./ComprasEdit";

const ComprasList: React.FC = () => {
  const [comprasData, setComprasData] = useState<comprasFormat[]>([]);
  const [showLoading, setShowLoading] = useState(false);

  useIonViewWillEnter(() => {
    searchCompras();
  });

  const searchCompras = async () => {
    setShowLoading(true);
    let list = await searchComprasData();
    setComprasData(list);
    setTimeout(() => {
      setShowLoading(false);
    }, 1000);
  };

  const reload = () => {
    localStorage.removeItem("compras");
    searchCompras();
  };

  const handleRefresh = (event: CustomEvent) => {
    setTimeout(() => {
      searchCompras();
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
          <IonTitle>Compras</IonTitle>
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
          <IonTitle>Gestión de Compras</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={ComprasAdd}>
              <IonButton color="success" fill="solid" slot="end" size="small">
                Agregar compra
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color="secondary" onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color="primary">
              <IonLabel>Listado de Compras</IonLabel>
            </IonListHeader>
            {comprasData.map((compra, index) => {
              return (
                <IonItem key={index}>
                  <IonCardHeader>
                    <IonCardTitle>{compra.Id_Proveedor}</IonCardTitle>
                    <IonCardSubtitle>{compra.Fecha}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <ComprasEdit item={compra} />}>
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

export default ComprasList;