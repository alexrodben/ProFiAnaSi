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
import { checkmark, close } from "ionicons/icons";
import { categoryFormat } from "./CategoryFormat";
import { editDataCategory, removeDataCategory } from "./CategoryApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: categoryFormat;
}

const CategoryEdit: React.FC<ContainerProps> = ({ item }) => {
  const [category, setCategory] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = () => {
    if (category.name && category.registrationDate && category.updateDate) {
      const newCategory: categoryFormat = {
        id: item.id,
        name: category.name,
        registrationDate: category.registrationDate,
        updateDate: category.updateDate,
      };
      editDataCategory(newCategory);
      history.push("categories");
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
            removeDataCategory(id);
            history.push("categories");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setCategory(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{category.name}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar una categoría</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Nombre</IonLabel>
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
                    value={category.registrationDate}
                    placeholder="Fecha de Registro de la categoría"
                    required
                    disabled
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
                    value={category.updateDate}
                    placeholder="Fecha de Actualización de la categoría"
                    required
                    disabled
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
                    <IonIcon icon={checkmark} /> Eliminar
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

export default CategoryEdit;