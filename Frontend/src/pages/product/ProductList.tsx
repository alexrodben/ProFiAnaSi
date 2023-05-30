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
import { reloadDataProducts, searchDataProducts } from "./ProductApi";
import { productFormat } from "./ProductFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import ProductAdd from "./ProductAdd";
import ProductEdit from "./ProductEdit";

const ProductsList: React.FC = () => {
  const [dataProducts, setDataProducts] = useState<productFormat[]>([]);
  useEffect(() => {
    searchProducts();
  }, []);

  const searchProducts = () => {
    let list = searchDataProducts();
    setDataProducts(list);
  };

  const reload = () => {
    reloadDataProducts();
    searchProducts();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchProducts();
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
          <IonTitle>Productos</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent></IonRefresherContent>
        </IonRefresher>
        <IonCard>
          <IonTitle>Gestion de los productos</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={() => <ProductAdd />}>
              <IonButton color={"success"} fill="solid" slot="end" size="small">
                Agregar producto
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color={"secondary"} onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color={"primary"}>
              <IonLabel>Listado de Productos</IonLabel>
            </IonListHeader>
            {dataProducts.map((item, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img alt={item.image} src="https://ionicframework.com/docs/img/demos/thumbnail.svg" />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{item.name}</IonCardTitle>
                    <IonCardSubtitle>{item.description}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <ProductEdit item={item} />}>
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

export default ProductsList;
