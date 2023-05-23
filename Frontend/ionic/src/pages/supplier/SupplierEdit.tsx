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
import { editDataSupplier, removeDataSupplier } from "./SupplierApi";
import { checkmark, close } from "ionicons/icons";
import { supplierFormat } from "./SupplierFormat";
import { useHistory } from "react-router";

interface ContainerProps {
  item: supplierFormat;
}
const SupplierEdit: React.FC<ContainerProps> = ({ item }) => {
  const [supplier, setSupplier] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = () => {
    if (supplier.name && supplier.address && supplier.phone) {
      const newSupplier: supplierFormat = {
        id: Math.round(Math.random() * 10000).toString(),
        name: supplier.name,
        address: supplier.address,
        phone: supplier.phone,
      };
      editDataSupplier(newSupplier);
      history.push("suppliers");
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
            removeDataSupplier(id);
            history.push("suppliers");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setSupplier(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{supplier.name}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar un proveedor</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Nombre</IonLabel>
                  <IonInput
                    onIonChange={(e) => (supplier.name = e.detail.value)}
                    placeholder="Nombre del proveedor"
                    value={supplier.name}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Dirección</IonLabel>
                  <IonInput
                    onIonChange={(e) => (supplier.address = e.detail.value)}
                    placeholder="Dirección del proveedor"
                    value={supplier.address}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Teléfono</IonLabel>
                  <IonInput
                    onIonChange={(e) => (supplier.phone = e.detail.value)}
                    value={supplier.phone}
                    placeholder="Teléfono"
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

export default SupplierEdit;
