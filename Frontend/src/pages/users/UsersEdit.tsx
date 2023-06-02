/* eslint-disable react/jsx-no-comment-textnodes */
import React, { useEffect, useState } from "react";
import "./../Page.css";

import {
  IonBackButton,
  IonButton,
  IonCard,
  IonCol,
  IonIcon,
  IonInput,
  IonItem,
  IonLabel,
  IonList,
  IonListHeader,
  IonRow,
  useIonToast,
} from "@ionic/react";
import { IonButtons, IonContent, IonHeader, IonTitle, IonToolbar, useIonAlert } from "@ionic/react";
import { checkmark, close, trash } from "ionicons/icons";
import { UsersFormat } from "./UsersFormat";
import { editDataUser, removeDataUser } from "./UsersApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: UsersFormat;
}

const UsersEdit: React.FC<ContainerProps> = ({ item }) => {
  const [user, setUser] = useState<UsersFormat>({} as UsersFormat);
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = () => {
    if (
      user.userId &&
      user.username &&
      user.password &&
      user.firstname &&
      user.lastname
    ) {
      const newUser: UsersFormat = {
        id: item.id,
        userId: user.userId,
        username: user.username,
        password: user.password,
        firstname: user.firstname,
        lastname: user.lastname,
      };
      editDataUser(newUser);
      history.push("/users");
    } else {
      present({
        message: "No has llenado todos los datos",
        duration: 1000,
        position: "middle",
        icon: close,
      });
    }
  };

  const remove = () => {
    presentAlert({
      header: "Alert!",
      message: "¿Estás seguro de que deseas eliminar este usuario?",
      buttons: [
        {
          text: "Cancelar",
          role: "cancel",
        },
        {
          text: "Eliminar",
          role: "confirm",
          handler: () => {
            let id = item.id;
            removeDataUser(id);
            history.push("/users");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setUser(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{user.firstname} {user.lastname}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar un usuario</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Id Usuario</IonLabel>
                  <IonInput
                    onIonChange={(e) => (user.userId = e.detail.value!)}
                    placeholder="Id Usuario"
                    value={user.userId}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Username</IonLabel>
                  <IonInput
                    onIonChange={(e) => (user.username = e.detail.value!)}
                    placeholder="Username"
                    value={user.username}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Password</IonLabel>
                  <IonInput
                    onIonChange={(e) => (user.password = e.detail.value!)}
                    placeholder="Password"
                    value={user.password}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Nombre</IonLabel>
                  <IonInput
                    onIonChange={(e) => (user.firstname = e.detail.value!)}
                    placeholder="Nombre"
                    value={user.firstname}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Apellido</IonLabel>
                  <IonInput
                    onIonChange={(e) => (user.lastname = e.detail.value!)}
                    placeholder="Apellido"
                    value={user.lastname}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol size="6">
                <IonItem>
                  <IonButton onClick={edit} color={"warning"} fill="solid" slot="end" size="default">
                    <IonIcon icon={checkmark} /> Modificar
                  </IonButton>
                </IonItem>
              </IonCol>
              <IonCol size="6">
                <IonItem>
                  <IonButton onClick={remove} color={"danger"} fill="outline" slot="end" size="default">
                    <IonIcon icon={trash} /> Eliminar
                  </IonButton>
                </IonItem>
              </IonCol>
            </IonRow>
          </IonList>
        </IonCard>
      </IonContent>
    </>
  );
};

export default UsersEdit;