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
import { reloadDataKardex, searchDataKardex } from "./KardexApi";
import { kardexFormat } from "./KardexFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import KardexAdd from "./KardexAdd";
import KardexEdit from "./KardexEdit";

const KardexList: React.FC = () => {
  const [kardexData, setKardexData] = useState<kardexFormat[]>([]);

  useEffect(() => {
    searchKardex();
  }, []);

  const searchKardex = () => {
    let list = searchDataKardex();
    setKardexData(list);
  };

  const reload = () => {
    reloadDataKardex();
    searchKardex();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchKardex();
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
          <IonTitle>Kardex</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent></IonRefresherContent>
        </IonRefresher>
        <IonCard>
          <IonTitle>Gestión del Kardex</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={() => <KardexAdd />}>
              <IonButton color="success" fill="solid" slot="end" size="small">
                Agregar movimiento
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color="secondary" onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color="primary">
              <IonLabel>Listado de Movimientos</IonLabel>
            </IonListHeader>
            {kardexData.map((kardex, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img
                      alt={kardex.id}
                      src="https://ionicframework.com/docs/img/demos/thumbnail.svg"
                    />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{kardex.id}</IonCardTitle>
                    <IonCardSubtitle>{kardex.detalle}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink
                    slot="end"
                    routerDirection="forward"
                    component={() => <KardexEdit item={kardex} />}
                  >
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

export default KardexList;