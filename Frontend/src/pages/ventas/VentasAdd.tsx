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
import { saveDataVenta } from "./VentasApi";
import { useHistory } from "react-router";

export interface ventaFormat {
  idVenta: string;
  producto: string;
  cantidad: string;
  valorUnitario: string;
  fecha: string;
  detalle: string;
  tipoTransaccion: string;
  valorTotal: string;
  stock: string;
}

const VentasAdd: React.FC = () => {
  const [venta, setVenta] = useState<ventaFormat>({
    idVenta: "",
    producto: "",
    cantidad: "",
    valorUnitario: "",
    fecha: "",
    detalle: "",
    tipoTransaccion: "",
    valorTotal: "",
    stock: "",
  });
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = () => {
    if (
      venta.idVenta &&
      venta.producto &&
      venta.cantidad &&
      venta.valorUnitario &&
      venta.fecha
    ) {
      const newVenta: ventaFormat = {
        idVenta: Math.round(Math.random() * 10000).toString(),
        producto: venta.producto,
        cantidad: venta.cantidad,
        valorUnitario: venta.valorUnitario,
        fecha: venta.fecha,
        detalle: "",
        tipoTransaccion: "",
        valorTotal: "",
        stock: "",
      };
      let saved = saveDataVenta(newVenta);
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
    setVenta({
      idVenta: "",
      producto: "",
      cantidad: "",
      valorUnitario: "",
      fecha: "",
      detalle: "",
      tipoTransaccion: "",
      valorTotal: "",
      stock: "",
    });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar una nueva Venta</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar una nueva Venta</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Id Venta</IonLabel>
                  <IonInput
                    onIonChange={(e) => setVenta({ ...venta, idVenta: e.detail.value ?? "" })}
                    placeholder="Id Venta"
                    value={venta.idVenta}
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
                    onIonChange={(e) => setVenta({ ...venta, producto: e.detail.value ?? "" })}
                    placeholder="Producto"
                    value={venta.producto}
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
                    onIonChange={(e) => setVenta({ ...venta, cantidad: e.detail.value ?? "" })}
                    placeholder="Cantidad"
                    value={venta.cantidad}
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
                    onIonChange={(e) => setVenta({ ...venta, valorUnitario: e.detail.value ?? "" })}
                    placeholder="Valor Unitario"
                    value={venta.valorUnitario}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha</IonLabel>
                  <IonInput
                    onIonChange={(e) => setVenta({ ...venta, fecha: e.detail.value ?? "" })}
                    placeholder="Fecha"
                    value={venta.fecha}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>

            <IonRow>
              <IonCol>
                <IonItem>
                  <IonButton
                    onClick={save}
                    color={"success"}
                    fill="solid"
                    slot="end"
                    size="default"
                  >
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

export default VentasAdd;