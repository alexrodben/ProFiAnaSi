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
import { customerFormat } from "./CustomerFormat";
import { saveCustomerData } from "./CustomerApi";
import { useHistory } from "react-router";

const CustomerAdd: React.FC = () => {
  const [customer, setCustomer] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = async () => {
    if (customer.name && customer.address && customer.nit && customer.phone && customer.email) {
      const newCustomer: customerFormat = {
        Id_Cliente: Math.round(Math.random() * 10).toString(),
        Estatus: "true",
        Nombre: customer.name,
        Direccion: customer.address,
        Nit: customer.nit,
        Telefono: customer.phone,
        Email: customer.email,
      };
      let saved = await saveCustomerData(newCustomer);
      if (saved && saveDisabled === true) {
        setSaveDisabled(false);
        history.push("/customers");
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
    setCustomer({ id: "", name: "", address: "", nit: "", phone: "", email: "" });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar un nuevo cliente</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar un nuevo cliente</IonLabel>
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
                    placeholder="Teléfono del cliente"
                    value={customer.phone}
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
                    placeholder="Correo Electrónico del cliente"
                    value={customer.email}
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

export default CustomerAdd;