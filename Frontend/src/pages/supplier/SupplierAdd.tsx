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
import { supplierFormat } from "./SupplierFormat";
import { saveSupplierData } from "./SupplierApi";
import { useHistory } from "react-router";

const SupplierAdd: React.FC = () => {
  const [supplier, setSupplier] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = async () => {
    if (supplier.Estatus && supplier.Nombre && supplier.Direccion && supplier.Nit && supplier.Telefono && supplier.Email) {
      const newSupplier: supplierFormat = {
        Id_Proveedor: Math.round(Math.random() * 10000).toString(),
        Estatus: supplier.Estatus,
        Nombre: supplier.Nombre,
        Direccion: supplier.Direccion,
        Nit: supplier.Nit,
        Telefono: supplier.Telefono,
        Email: supplier.Email,
      };
      let saved = await saveSupplierData(newSupplier);
      if (saved && saveDisabled === true) {
        setSaveDisabled(false);
        history.push("/suppliers");
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
    setSupplier({ Id_Proveedor: "", Estatus: "", Nombre: "", Direccion: "", Nit: "", Telefono: "", Email: "" });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar un nuevo proveedor</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar un nuevo proveedor</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Estatus</IonLabel>
                  <IonInput
                    onIonChange={(e) => (supplier.Estatus = e.detail.value)}
                    placeholder="Estatus del proveedor"
                    value={supplier.Estatus}
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
                    placeholder="Teléfono del proveedor"
                    value={supplier.Telefono}
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
                    placeholder="Correo Electrónico del proveedor"
                    value={supplier.Email}
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

export default SupplierAdd;