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
import { ventaFormat } from "./VentasFormat";
import { editDataVenta, removeDataVenta } from "./VentasApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: ventaFormat;
}

const VentasEdit: React.FC<ContainerProps> = ({ item }) => {
  const [venta, setVenta] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = () => {
    if (
      venta.fecha &&
      venta.detalle &&
      venta.tipoTransaccion &&
      venta.cantidad &&
      venta.valorUnitario &&
      venta.valorTotal &&
      venta.stock
    ) {
      const newVenta: ventaFormat = {
        idVenta: Math.round(Math.random() * 10000).toString(),
        fecha: venta.fecha,
        detalle: venta.detalle,
        tipoTransaccion: venta.tipoTransaccion,
        cantidad: venta.cantidad,
        valorUnitario: venta.valorUnitario,
        valorTotal: venta.valorTotal,
        stock: venta.stock,
      };
      editDataVenta(newVenta);
      history.push("ventas");
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
            let id = item.idVenta;
            removeDataVenta(id);
            history.push("ventas");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setVenta(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{venta.detalle}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar una venta</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha</IonLabel>
                  <IonInput
                    onIonChange={(e) => (venta.fecha = e.detail.value)}
                    placeholder="Fecha de la venta"
                    value={venta.fecha}
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
                    onIonChange={(e) => (venta.detalle = e.detail.value)}
                    placeholder="Detalle de la venta"
                    value={venta.detalle}
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
                    onIonChange={(e) => (venta.tipoTransaccion = e.detail.value)}
                    placeholder="Tipo de transacción de la venta"
                    value={venta.tipoTransaccion}
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
                    onIonChange={(e) => (venta.cantidad = e.detail.value)}
                    value={venta.cantidad}
                    placeholder="Cantidad de la venta"
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
                    onIonChange={(e) => (venta.valorUnitario = e.detail.value)}
                    value={venta.valorUnitario}
                    placeholder="Valor unitario de la venta"
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
                    onIonChange={(e) => (venta.valorTotal = e.detail.value)}
                    value={venta.valorTotal}
                    placeholder="Valor total de la venta"
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
                    onIonChange={(e) => (venta.stock = e.detail.value)}
                    value={venta.stock}
                    placeholder="Stock de la venta"
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

export default VentasEdit;