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
import { IonButtons, IonContent, IonHeader, IonTitle, IonToolbar } from "@ionic/react";
import { checkmark, close } from "ionicons/icons";
import { saveDataUser } from "./UsersApi";
import { useHistory } from "react-router";

const UsersAdd: React.FC = () => {
  const [user, setUser] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = () => {
    if (
      user.userId &&
      user.username &&
      user.password &&
      user.firstname &&
      user.lastname
    ) {
      const newUser = {
        id: Math.round(Math.random() * 10000).toString(),
        userId: user.userId,
        username: user.username,
        password: user.password,
        firstname: user.firstname,
        lastname: user.lastname
      };
      let saved = saveDataUser(newUser);
      if (saved && saveDisabled === true) {
        setSaveDisabled(false);
        history.goBack();
      }
    } else {
      present({
        message: "No has llenado todos los datos",
        duration: 1000,
        position: "middle",
        icon: close,
      });
    }
  };

  useEffect(() => {
    setUser({
      id: "",
      userId: "",
      username: "",
      password: "",
      firstname: "",
      lastname: ""
    });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar un nuevo usuario</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar un nuevo usuario</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Id Usuario</IonLabel>
                  <IonInput
                    onIonChange={(e) => (user.userId = e.detail.value)}
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
                    onIonChange={(e) => (user.username = e.detail.value)}
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
                    onIonChange={(e) => (user.password = e.detail.value)}
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
                  <IonLabel position="floating">Firstname</IonLabel>
                  <IonInput
                    onIonChange={(e) => (user.firstname = e.detail.value)}
                    placeholder="Firstname"
                    value={user.firstname}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Lastname</IonLabel>
                  <IonInput
                    onIonChange={(e) => (user.lastname = e.detail.value)}
                    placeholder="Lastname"
                    value={user.lastname}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>

            <IonRow>
              <IonCol>
                <IonItem>
                  <IonButton onClick={save} color={"success"} fill="solid" slot="end" size="default">
                    <IonIcon icon={checkmark} /> Guardar
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

export default UsersAdd;