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
import { saveDataKardex } from "./KardexApi";
import { useHistory } from "react-router";

const KardexAdd: React.FC = () => {
  const [kardex, setKardex] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = () => {
    if (kardex.fecha && kardex.detalle && kardex.cantidad && kardex.valorUnitario && kardex.valorTotal) {
      const newKardex = {
        id: Math.round(Math.random() * 10000).toString(),
        fecha: kardex.fecha,
        detalle: kardex.detalle,
        cantidad: kardex.cantidad,
        valorUnitario: kardex.valorUnitario,
        valorTotal: kardex.valorTotal,
      };
      let saved = saveDataKardex(newKardex);
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
    setKardex({ id: "", fecha: "", detalle: "", cantidad: "", valorUnitario: "", valorTotal: "" });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar un nuevo registro en el Kardex</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar un nuevo registro en el Kardex</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha</IonLabel>
                  <IonInput
                    onIonChange={(e) => (kardex.fecha = e.detail.value)}
                    placeholder="Fecha del registro"
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
                    placeholder="Detalle del registro"
                    value={kardex.detalle}
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
                    placeholder="Cantidad del registro"
                    value={kardex.cantidad}
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
                    placeholder="Valor unitario del registro"
                    value={kardex.valorUnitario}
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
                    placeholder="Valor total del registro"
                    value={kardex.valorTotal}
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

export default KardexAdd;