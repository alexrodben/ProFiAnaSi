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
  IonLoading,
  IonNavLink,
  IonRefresher,
  IonRefresherContent,
  IonThumbnail,
  RefresherEventDetail,
} from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonMenuButton, IonTitle, IonToolbar } from "@ionic/react";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import { searchSupplierData } from "./SupplierApi";
import { supplierFormat } from "./SupplierFormat";
import SupplierEdit from "./SupplierEdit";
import SupplierAdd from "./SupplierAdd";

const SupplierList: React.FC = () => {
  const [supplierData, setSupplierData] = useState<supplierFormat[]>([]);
  const [showLoading, setShowLoading] = useState(false);

  useEffect(() => {
    searchSuppliers();
  }, []);

  const searchSuppliers = async () => {
    setShowLoading(true)
    let list = await searchSupplierData();
    setTimeout(() => {
      setSupplierData(list);
      setShowLoading(false);
    }, 1000);

  };

  const reload = () => {
    localStorage.removeItem("suppliers");
    searchSuppliers();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchSuppliers();
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
          <IonTitle>Proveedores</IonTitle>
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
          <IonTitle>Gestión de los proveedores</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={() => <SupplierAdd />}>
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
            {supplierData.map((supplier, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img alt={supplier.Nombre} src="https://ionicframework.com/docs/img/demos/thumbnail.svg" />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{supplier.Nombre}</IonCardTitle>
                    <IonCardSubtitle>{supplier.Direccion}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <SupplierEdit item={supplier} />}>
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