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
import { orderFormat } from "./OrderFormat";
import { saveDataOrder } from "./OrderApi";
import { useHistory } from "react-router";

const OrderAdd: React.FC = () => {
  const [order, setOrder] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = () => {
    if (
      order.registrationDate &&
      order.updateDate &&
      order.product &&
      order.supplier &&
      order.transactionType &&
      order.quantity
    ) {
      const newOrder: orderFormat = {
        id: Math.round(Math.random() * 10000).toString(),
        registrationDate: order.registrationDate,
        updateDate: order.updateDate,
        product: order.product,
        provider: order.supplier,
        transactionType: order.transactionType,
        quantity: order.quantity,
      };
      let saved = saveDataOrder(newOrder);
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
    setOrder({
      id: "",
      registrationDate: "",
      updateDate: "",
      product: "",
      supplier: "",
      transactionType: "",
      quantity: "",
    });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar una nueva transacción</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar una nueva transacción</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha de registro</IonLabel>
                  <IonInput
                    onIonChange={(e) => (order.registrationDate = e.detail.value)}
                    placeholder="Fecha de registro"
                    value={order.registrationDate}
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
                    onIonChange={(e) => (order.updateDate = e.detail.value)}
                    placeholder="Fecha de Actualización"
                    value={order.updateDate}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Producto</IonLabel>
                  <IonInput
                    onIonChange={(e) => (order.product = e.detail.value)}
                    placeholder="Producto"
                    value={order.product}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Proveedor</IonLabel>
                  <IonInput
                    onIonChange={(e) => (order.supplier = e.detail.value)}
                    placeholder="Proveedor"
                    value={order.supplier}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Tipo de transacción</IonLabel>
                  <IonInput
                    onIonChange={(e) => (order.transactionType = e.detail.value)}
                    placeholder="Tipo de transacción"
                    value={order.transactionType}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Cantidad</IonLabel>
                  <IonInput
                    onIonChange={(e) => (order.quantity = e.detail.value)}
                    placeholder="Cantidad"
                    value={order.quantity}
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

export default OrderAdd;
