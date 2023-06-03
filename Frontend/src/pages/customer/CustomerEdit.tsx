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
import { editCustomerData, removeCustomerData } from "./CustomerApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: customerFormat;
}

const CustomerEdit: React.FC<ContainerProps> = ({ item }) => {
  const [customer, setCustomer] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = async () => {
    if (customer.Nombre && customer.Direccion && customer.Nit && customer.Telefono && customer.email && customer.CreatedAt && customer.UpdatedAt) {
      const newCustomer: customerFormat = {
        Id_Cliente: customer.Id_Cliente,
        Estatus: "true",
        Nombre: customer.Nombre,
        Direccion: customer.Direccion,
        Nit: customer.Nit,
        Telefono: customer.Telefono,
        Email: customer.email,
        CreatedAt: customer.CreatedAt,
        UpdatedAt: customer.UpdatedAt,
      };
      let edit = await editCustomerData(newCustomer);
      if (edit) history.push("/customers");
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
      buttons: [
        {
          text: "Cancelar",
          role: "cancel",
        },
        {
          text: "Eliminar",
          role: "confirm",
          handler: async () => {
            let Id_Cliente = item.Id_Cliente;
            let del = await removeCustomerData(Id_Cliente);
            if (del) history.push("/customers");
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
          <IonTitle>{customer.Nombre}</IonTitle>
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
                    onIonChange={(e) => (customer.Nombre = e.detail.value)}
                    placeholder="Nombre del cliente"
                    value={customer.Nombre}
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
                    onIonChange={(e) => (customer.Direccion = e.detail.value)}
                    placeholder="Dirección del cliente"
                    value={customer.Direccion}
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
                    onIonChange={(e) => (customer.Nit = e.detail.value)}
                    placeholder="NIT del cliente"
                    value={customer.Nit}
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
                    onIonChange={(e) => (customer.Telefono = e.detail.value)}
                    value={customer.Telefono}
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
                    onIonChange={(e) => (customer.CreatedAt = e.detail.value)}
                    value={customer.CreatedAt}
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
                    onIonChange={(e) => (customer.UpdatedAt = e.detail.value)}
                    value={customer.UpdatedAt}
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
