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
import { supplierFormat } from "./SupplierFormat";
import { editSupplierData, removeSupplierData } from "./SupplierApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: supplierFormat;
}

const SupplierEdit: React.FC<ContainerProps> = ({ item }) => {
  const [supplier, setSupplier] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = async () => {
    if (supplier.Nombre && supplier.Direccion && supplier.Nit && supplier.Telefono && supplier.Email) {
      const newSupplier: supplierFormat = {
        Id_Proveedor: item.Id_Proveedor,
        Nombre: supplier.Nombre,
        Direccion: supplier.Direccion,
        Nit: supplier.Nit,
        Telefono: supplier.Telefono,
        Email: supplier.Email,
        Estatus: ""
      };
      let edit = await editSupplierData(newSupplier);
      if (edit) history.push("/suppliers");
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
            let Id_Proveedor = item.Id_Proveedor;
            let del = await removeSupplierData(Id_Proveedor);
            if (del) history.push("/suppliers");
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
          <IonTitle>{supplier.Nombre}</IonTitle>
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
                    onIonChange={(e) => (supplier.Nombre = e.detail.value)}
                    placeholder="Nombre del proveedor"
                    value={supplier.Nombre}
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
                    onIonChange={(e) => (supplier.Direccion = e.detail.value)}
                    placeholder="Dirección del proveedor"
                    value={supplier.Direccion}
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
                    onIonChange={(e) => (supplier.Nit = e.detail.value)}
                    placeholder="NIT del proveedor"
                    value={supplier.Nit}
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
                    onIonChange={(e) => (supplier.Telefono = e.detail.value)}
                    value={supplier.Telefono}
                    placeholder="Teléfono del proveedor"
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
                    onIonChange={(e) => (supplier.Email = e.detail.value)}
                    value={supplier.Email}
                    placeholder="Correo Electrónico del proveedor"
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
                    onIonChange={(e) => (supplier.CreatedAt = e.detail.value)}
                    value={supplier.CreatedAt}
                    placeholder="Fecha de Registro del producto"
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
                    onIonChange={(e) => (supplier.UpdatedAt = e.detail.value)}
                    value={supplier.UpdatedAt}
                    placeholder="Fecha de Actualización del producto"
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

export default SupplierEdit;