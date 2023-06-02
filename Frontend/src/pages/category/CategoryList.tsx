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
import { reloadDataCategories, searchDataCategories } from "./CategoryApi";
import { categoryFormat } from "./CategoryFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import CategoryAdd from "./CategoryAdd";
import CategoryEdit from "./CategoryEdit";

const CategoryList: React.FC = () => {
  const [categoryData, setCategoryData] = useState<categoryFormat[]>([]);

  useEffect(() => {
    searchCategories();
  }, []);

  const searchCategories = () => {
    let list = searchDataCategories();
    setCategoryData(list);
  };

  const reload = () => {
    reloadDataCategories();
    searchCategories();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchCategories();
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
          <IonTitle>Categorías</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent></IonRefresherContent>
        </IonRefresher>
        <IonCard>
          <IonTitle>Gestión de las categorías</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={() => <CategoryAdd />}>
              <IonButton color={"success"} fill="solid" slot="end" size="small">
                Agregar categoría
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color={"secondary"} onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color={"primary"}>
              <IonLabel>Listado de Categorías</IonLabel>
            </IonListHeader>
            {categoryData.map((category, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img alt={category.name} src="https://ionicframework.com/docs/img/demos/thumbnail.svg" />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{category.name}</IonCardTitle>
                    <IonCardSubtitle>{category.registrationDate}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink slot="end" routerDirection="forward" component={() => <CategoryEdit item={category} />}>
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

export default CategoryList;