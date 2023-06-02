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
import { saveDataCategory } from "./CategoryApi"; // Importa el método de API correspondiente para guardar la categoría
import { useHistory } from "react-router";

const CategoryAdd: React.FC = () => {
  const [category, setCategory] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = () => {
    if (category.name && category.registrationDate && category.updateDate) {
      const newCategory = {
        id: Math.round(Math.random() * 10000).toString(),
        name: category.name,
        registrationDate: category.registrationDate,
        updateDate: category.updateDate,
      };
      let saved = saveDataCategory(newCategory);
      if (saved && saveDisabled === true) {
        setSaveDisabled(false);
        history.goBack();
      }

      // history.push("categories");
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
    setCategory({ id: "", name: "", registrationDate: "", updateDate: "" });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar una nueva categoría</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar una nueva categoría</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Nombre Categoría</IonLabel>
                  <IonInput
                    onIonChange={(e) => (category.name = e.detail.value)}
                    placeholder="Nombre de la categoría"
                    value={category.name}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha de Registro</IonLabel>
                  <IonInput
                    onIonChange={(e) => (category.registrationDate = e.detail.value)}
                    placeholder="Fecha de registro"
                    value={category.registrationDate}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha de Actualización</IonLabel>
                  <IonInput
                    onIonChange={(e) => (category.updateDate = e.detail.value)}
                    placeholder="Fecha de actualización"
                    value={category.updateDate}
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

export default CategoryAdd;