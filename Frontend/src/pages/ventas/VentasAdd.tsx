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
import { saveVentaData } from "./VentasApi";
import { useHistory } from "react-router";
import { ventasFormat } from "./VentasFormat";

const VentasAdd: React.FC = () => {
  const [venta, setVenta] = useState<any>();
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = async () => {
    if (
      venta.Id_Venta &&
      venta.Id_Cliente &&
      venta.Fecha
    ) {
      const newVenta: ventasFormat = {
        Id_Venta: Math.round(Math.random() * 10000).toString(),
        Id_Cliente: venta.Id_Cliente,
        Fecha: venta.Fecha,
        CreatedAt: "",
        UpdatedAt: "",
      };
      let saved = await saveVentaData(newVenta);
      if (saved && saveDisabled === true) {
        setSaveDisabled(false);
        history.push("ventas");
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
      Id_Venta: "",
      Id_Cliente: "",
      Fecha: "",
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
                    onIonChange={(e) => setVenta({ ...venta, Id_Venta: e.detail.value ?? "" })}
                    placeholder="Id Venta"
                    value={venta.Id_Venta}
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
                    onIonChange={(e) => setVenta({ ...venta, Id_Cliente: e.detail.value ?? "" })}
                    placeholder="Producto"
                    value={venta.Id_Cliente}
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
                    onIonChange={(e) => setVenta({ ...venta, Fecha: e.detail.value ?? "" })}
                    placeholder="Cantidad"
                    value={venta.Fecha}
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