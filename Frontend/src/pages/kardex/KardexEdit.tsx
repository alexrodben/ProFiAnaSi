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
import { kardexFormat } from "./KardexFormat";
import { editDataKardex, removeDataKardex } from "./KardexApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: kardexFormat;
}

const KardexEdit: React.FC<ContainerProps> = ({ item }) => {
  const [kardex, setKardex] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = () => {
    if (
      kardex.fecha &&
      kardex.detalle &&
      kardex.tipoTransaccion &&
      kardex.cantidad &&
      kardex.valorUnitario &&
      kardex.valorTotal &&
      kardex.stock
    ) {
      const newKardex: kardexFormat = {
        id: Math.round(Math.random() * 10000).toString(),
        fecha: kardex.fecha,
        detalle: kardex.detalle,
        tipoTransaccion: kardex.tipoTransaccion,
        cantidad: kardex.cantidad,
        valorUnitario: kardex.valorUnitario,
        valorTotal: kardex.valorTotal,
        stock: kardex.stock,
      };
      editDataKardex(newKardex);
      history.push("kardex");
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
            removeDataKardex(id);
            history.push("kardex");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setKardex(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{kardex.detalle}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar un kardex</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha</IonLabel>
                  <IonInput
                    onIonChange={(e) => (kardex.fecha = e.detail.value)}
                    placeholder="Fecha del kardex"
                    value={kardex.fecha}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Detalle</IonLabel>
                  <IonInput
                    onIonChange={(e) => (kardex.detalle = e.detail.value)}
                    placeholder="Detalle del kardex"
                    value={kardex.detalle}
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
                    onIonChange={(e) => (kardex.tipoTransaccion = e.detail.value)}
                    placeholder="Tipo de transacción del kardex"
                    value={kardex.tipoTransaccion}
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
                    onIonChange={(e) => (kardex.cantidad = e.detail.value)}
                    value={kardex.cantidad}
                    placeholder="Cantidad del kardex"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Valor Unitario</IonLabel>
                  <IonInput
                    onIonChange={(e) => (kardex.valorUnitario = e.detail.value)}
                    value={kardex.valorUnitario}
                    placeholder="Valor unitario del kardex"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Valor Total</IonLabel>
                  <IonInput
                    onIonChange={(e) => (kardex.valorTotal = e.detail.value)}
                    value={kardex.valorTotal}
                    placeholder="Valor total del kardex"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Stock</IonLabel>
                  <IonInput
                    onIonChange={(e) => (kardex.stock = e.detail.value)}
                    value={kardex.stock}
                    placeholder="Stock del kardex"
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

export default KardexEdit;