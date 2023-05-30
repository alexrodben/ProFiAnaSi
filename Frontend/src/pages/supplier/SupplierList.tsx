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
import { reloadDataSuppliers, searchDataSuppliers } from "./SupplierApi"; // Corregido
import { supplierFormat } from "./SupplierFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import SupplierAdd from "./SupplierAdd";
import SupplierEdit from "./SupplierEdit"; // Agregado

const SupplierList: React.FC = () => {
  const [dataSuppliers, setDataSuppliers] = useState<supplierFormat[]>([]);
  useEffect(() => {
    searchSuppliers();
  }, []);

  const searchSuppliers = () => {
    let list = searchDataSuppliers(); // Corregido
    setDataSuppliers(list);
  };

  const reload = () => {
    reloadDataSuppliers(); // Corregido
    searchSuppliers();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchSuppliers();
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
          <IonTitle>Proveedores</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent></IonRefresherContent>
        </IonRefresher>
        <IonCard>
          <IonTitle>Gestión de los proveedores</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={SupplierAdd}>
              <IonButton color={"success"} fill="solid" slot="end" size="small">
                Agregar proveedor
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color={"secondary"} onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color={"primary"}>
              <IonLabel>Listado de Proveedores</IonLabel>
            </IonListHeader>
            {dataSuppliers.map((item, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img alt={item.name} src="https://ionicframework.com/docs/img/demos/thumbnail.svg" /> {/* Corregido */}
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{item.name}</IonCardTitle>
                    <IonCardSubtitle>{item.address}</IonCardSubtitle> {/* Corregido */}
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <SupplierEdit item={item} />}>
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

export default SupplierList;
