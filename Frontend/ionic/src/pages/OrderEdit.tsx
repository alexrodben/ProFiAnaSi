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
import { orderFormat } from "./OrderFormat";
import { editDataOrder, removeDataOrder } from "./OrderApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: orderFormat;
}

const OrderEdit: React.FC<ContainerProps> = ({ item }) => {
  const [order, setOrder] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = () => {
    if (order.registrationDate && order.updateDate && order.product && order.provider && order.transactionType && order.quantity) {
      const newOrder: orderFormat = {
        id: Math.round(Math.random() * 10000).toString(),
        registrationDate: order.registrationDate,
        updateDate: order.updateDate,
        product: order.product,
        provider: order.provider,
        transactionType: order.transactionType,
        quantity: order.quantity,
      };
      editDataOrder(newOrder);
      history.push("orders");
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
            removeDataOrder(id);
            history.push("orders");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setOrder(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{order.product}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar una transacción</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha de Registro</IonLabel>
                  <IonInput
                    onIonChange={(e) => (order.registrationDate = e.detail.value)}
                    value={order.registrationDate}
                    placeholder="Fecha de Registro del pedido"
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
                          onIonChange={(e) => (order.updateDate = e.detail.value)}
                             value={order.updateDate} 
                           placeholder="Fecha de Actualización del pedido"
                         required
                       disabled 
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
                    placeholder="Producto del pedido"
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
                    onIonChange={(e) => (order.provider = e.detail.value)}
                    placeholder="Proveedor del pedido"
                    value={order.provider}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Tipo de Transacción</IonLabel>
                  <IonInput
                    onIonChange={(e) => (order.transactionType = e.detail.value)}
                    value={order.transactionType}
                    placeholder="Tipo de Transacción del pedido"
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
                    value={order.quantity}
                    placeholder="Cantidad del pedido"
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

export default OrderEdit;