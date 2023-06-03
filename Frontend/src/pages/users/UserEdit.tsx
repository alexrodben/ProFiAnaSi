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
import { userFormat } from "./UserFormat";
import { editUserData, removeUserData } from "./UserApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: userFormat;
}

const UsersEdit: React.FC<ContainerProps> = ({ item }) => {
  const [user, setUser] = useState<userFormat>({} as userFormat);
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = async () => {
    if (
      user.id_usuario &&
      user.username &&
      user.password &&
      user.firstname &&
      user.lastname
    ) {
      const newUser: userFormat = {
        id_usuario: user.id_usuario,
        username: user.username,
        password: user.password,
        firstname: user.firstname,
        lastname: user.lastname,
      };
      let edit = await editUserData(newUser);
      if (edit) history.push("/users");
    } else {
      present({
        message: "No has llenado todos los datos",
        duration: 1000,
        position: "middle",
        icon: close,
      });
    }
  };

  const remove = async () => {
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
          handler: async () => {
            let id_usuario = item.id_usuario;
            let del = await removeUserData(id_usuario);
            if (del) history.push("/users");
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