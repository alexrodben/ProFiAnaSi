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
import { customerFormat } from "./CustomerFormat";
import { editDataCustomer, removeDataCustomer } from "./CustomerApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: customerFormat;
}

const CustomerEdit: React.FC<ContainerProps> = ({ item }) => {
  const [customer, setCustomer] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = () => {
    if (customer.name && customer.address && customer.nit && customer.phone && customer.email && customer.registrationDate && customer.updateDate) {
      const newCustomer: customerFormat = {
        id: Math.round(Math.random() * 10000).toString(),
        name: customer.name,
        address: customer.address,
        nit: customer.nit,
        phone: customer.phone,
        email: customer.email,
        registrationDate: customer.registrationDate,
        updateDate: customer.updateDate,
      };
      editDataCustomer(newCustomer);
      history.push("customers");
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
            removeDataCustomer(id);
            history.push("customers");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setCustomer(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{customer.name}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar un cliente</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Nombre</IonLabel>
                  <IonInput
                    onIonChange={(e) => (customer.name = e.detail.value)}
                    placeholder="Nombre del cliente"
                    value={customer.name}
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
                    onIonChange={(e) => (customer.address = e.detail.value)}
                    placeholder="Dirección del cliente"
                    value={customer.address}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">NIT</IonLabel>
                  <IonInput
                    onIonChange={(e) => (customer.nit = e.detail.value)}
                    placeholder="NIT del cliente"
                    value={customer.nit}
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
                    onIonChange={(e) => (customer.phone = e.detail.value)}
                    value={customer.phone}
                    placeholder="Teléfono del cliente"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Correo Electrónico</IonLabel>
                  <IonInput
                    onIonChange={(e) => (customer.email = e.detail.value)}
                    value={customer.email}
                    placeholder="Correo Electrónico del cliente"
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
                    onIonChange={(e) => (customer.registrationDate = e.detail.value)}
                    value={customer.registrationDate}
                    placeholder="Fecha de Registro del cliente"
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
                          onIonChange={(e) => (customer.updateDate = e.detail.value)}
                             value={customer.updateDate} 
                           placeholder="Fecha de Actualización del cliente"
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

export default CustomerEdit;
