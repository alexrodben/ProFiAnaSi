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
import { saveDataCompra } from "./ComprasApi";
import { useHistory } from "react-router";

const ComprasAdd: React.FC = () => {
  const [compra, setCompra] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = () => {
    if (
      compra.idCompra &&
      compra.producto &&
      compra.cantidad &&
      compra.valorUnitario &&
      compra.valorCosto &&
      compra.valorTotal
    ) {
      const newCompra = {
        idCompra: Math.round(Math.random() * 10000).toString(),
        producto: compra.producto,
        cantidad: compra.cantidad,
        valorUnitario: compra.valorUnitario,
        valorCosto: compra.valorCosto,
        valorTotal: compra.valorTotal,
        fecha: "", // Agrega la propiedad "fecha" al objeto newCompra
        detalle: "", // Agrega la propiedad "detalle" al objeto newCompra
        tipoTransaccion: "", // Agrega la propiedad "tipoTransaccion" al objeto newCompra
        stock: "", // Agrega la propiedad "stock" al objeto newCompra
      };
      let saved = saveDataCompra(newCompra);
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
    setCompra({
      idCompra: "",
      producto: "",
      cantidad: "",
      valorUnitario: "",
      valorCosto: "",
      valorTotal: "",
    });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar una nueva Compra</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar una nueva Compra</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Id Compra</IonLabel>
                  <IonInput
                    onIonChange={(e) => setCompra({ ...compra, idCompra: e.detail.value })}
                    placeholder="Id Compra"
                    value={compra.idCompra}
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
                    onIonChange={(e) => setCompra({ ...compra, producto: e.detail.value })}
                    placeholder="Producto"
                    value={compra.producto}
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
                    onIonChange={(e) => setCompra({ ...compra, cantidad: e.detail.value })}
                    placeholder="Cantidad"
                    value={compra.cantidad}
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
                    onIonChange={(e) => setCompra({ ...compra, valorUnitario: e.detail.value })}
                    placeholder="Valor Unitario"
                    value={compra.valorUnitario}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Valor Costo</IonLabel>
                  <IonInput
                    onIonChange={(e) => setCompra({ ...compra, valorCosto: e.detail.value })}
                    placeholder="Valor Costo"
                    value={compra.valorCosto}
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
                    onIonChange={(e) => setCompra({ ...compra, valorTotal: e.detail.value })}
                    placeholder="Valor Total"
                    value={compra.valorTotal}
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

export default ComprasAdd;