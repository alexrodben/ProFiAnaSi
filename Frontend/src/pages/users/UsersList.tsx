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
import { reloadDataUsers, searchDataUsers } from "./UsersApi";
import { UsersFormat } from "./UsersFormat";
import { add, chevronForward, cloudDownload } from "ionicons/icons";
import UsersAdd from "./UsersAdd";
import UsersEdit from "./UsersEdit";

const UsersList: React.FC = () => {
  const [usersData, setUsersData] = useState<UsersFormat[]>([]);

  useEffect(() => {
    searchUsers();
  }, []);

  const searchUsers = () => {
    let list = searchDataUsers();
    setUsersData(list);
  };

  const reload = () => {
    reloadDataUsers();
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
          <IonTitle>Users</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
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
            {usersData.map((user, index) => {
              return (
                <IonItem key={index}>
                  <IonThumbnail slot="start">
                    <img
                      alt={user.id}
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