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
import { searchUserData } from "./UserApi";
import { userFormat } from "./UserFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import UsersAdd from "./UserAdd";
import UsersEdit from "./UserEdit";

const UsersList: React.FC = () => {
  const [userData, setUsersData] = useState<userFormat[]>([]);
  const [showLoading, setShowLoading] = useState(false);

  useEffect(() => {
    searchUsers();
  }, []);

  const searchUsers = async () => {
    setShowLoading(true)
    let list = await searchUserData();
    setTimeout(() => {
      setUsersData(list);
      setShowLoading(false);
    }, 1000);
  };

  const reload = () => {
    localStorage.removeItem("users");
    searchUsers();
  };

  function handleRefresh(event: CustomEvent<RefresherEventDetail>) {
    setTimeout(() => {
      searchUsers();
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
          <IonTitle>Usuarios</IonTitle>
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
          <IonTitle>Gestión de Usuarios</IonTitle>
          <IonItem>
            <IonNavLink routerDirection="forward" component={() => <UsersAdd />}>
              <IonButton color="success" fill="solid" slot="end" size="small">
                Agregar usuario
                <IonIcon icon={add} />
              </IonButton>
            </IonNavLink>
            <IonButton color="secondary" onClick={reload} fill="clear" slot="end" size="small">
              <IonIcon icon={cloudDownload} />
            </IonButton>
          </IonItem>
          <IonList inset={true}>
            <IonListHeader color="primary">
              <IonLabel>Listado de Usuarios</IonLabel>
            </IonListHeader>
            {userData.map((user, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img
                      alt={user.id_usuario}
                      src="https://ionicframework.com/docs/img/demos/thumbnail.svg"
                    />
                  </IonThumbnail>
                  <IonCardHeader>
                    <IonCardTitle>{user.firstname} {user.lastname}</IonCardTitle>
                    <IonCardSubtitle>{user.username}</IonCardSubtitle>
                  </IonCardHeader>
                  <IonNavLink
                    slot="end"
                    routerDirection="forward"
                    component={() => <UsersEdit item={user} />}
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

export default UsersList;