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
import { searchProductData } from "./ProductApi";
import { productFormat } from "./ProductFormat";
import ProductEdit from "./ProductEdit";
import ProductAdd from "./ProductAdd";

const ProductList: React.FC = () => {
  const [productData, setProductData] = useState<productFormat[]>([]);
  const [showLoading, setShowLoading] = useState(false);

  useEffect(() => {
    searchProducts();
  }, []);

  const searchProducts = async () => {
    setShowLoading(true)
    let list = await searchProductData();
    setTimeout(() => {
      setProductData(list);
      setShowLoading(false);
    }, 1000);
  };

  const reload = async () => {
    localStorage.removeItem("products");
    await searchProducts();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchProducts();
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
        <IonLoading
          isOpen={showLoading}
          onDidDismiss={() => setShowLoading(false)}
          message={'Cargando datos. Espere por favor...'}
        />
        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent></IonRefresherContent>
        </IonRefresher>
        <IonCard>
          <IonTitle>Gestión de los productos</IonTitle>
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
            {productData.map((product, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img alt={product.Nombre} src="https://ionicframework.com/docs/img/demos/thumbnail.svg" />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{product.Nombre}</IonCardTitle>
                    <IonCardSubtitle>{product.SKU}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <ProductEdit item={product} />}>
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

export default ProductList;
