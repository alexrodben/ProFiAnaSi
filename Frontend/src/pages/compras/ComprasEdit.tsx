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
import { comprasFormat } from "./ComprasFormat";
import { editCompraData, removeCompraData } from "./ComprasApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: comprasFormat;
}

const ComprasEdit: React.FC<ContainerProps> = ({ item }) => {
  const [compra, setCompra] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = async () => {
    if (
      compra.Fecha &&
      compra.Id_Proveedor &&
      compra.CreatedAt &&
      compra.UpdatedAt &&
      compra.valorUnitario &&
      compra.valorTotal &&
      compra.stock
    ) {
      const newCompra: comprasFormat = {
        Id_Compra: Math.round(Math.random() * 10000).toString(),
        Fecha: compra.Fecha,
        Id_Proveedor: compra.Id_Proveedor,
        CreatedAt: compra.CreatedAt,
        UpdatedAt: compra.UpdatedAt,
      };
      let edit = await editCompraData(newCompra);
      if (edit) history.push("compras");
    } else {
      present({
        message: "No has llenado todos los datos",
        duration: 1000,
        position: "middle",
        icon: close,
      });
    }
  };

  const remove = async () => {
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
          handler: async () => {
            let id = item.Id_Compra;
            let del = await removeCompraData(id);
            if (del) history.push("compras");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setCompra(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{compra.Id_Proveedor}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar una compra</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha</IonLabel>
                  <IonInput
                    onIonChange={(e) => (compra.Fecha = e.detail.value)}
                    placeholder="Fecha de la compra"
                    value={compra.Fecha}
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
                    onIonChange={(e) => (compra.Id_Proveedor = e.detail.value)}
                    placeholder="Detalle de la compra"
                    value={compra.Id_Proveedor}
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
                    onIonChange={(e) => (compra.CreatedAt = e.detail.value)}
                    placeholder="Tipo de transacción de la compra"
                    value={compra.CreatedAt}
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
                    onIonChange={(e) => (compra.UpdatedAt = e.detail.value)}
                    value={compra.UpdatedAt}
                    placeholder="Cantidad de la compra"
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
                    onIonChange={(e) => (compra.valorUnitario = e.detail.value)}
                    value={compra.valorUnitario}
                    placeholder="Valor unitario de la compra"
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
                    onIonChange={(e) => (compra.valorTotal = e.detail.value)}
                    value={compra.valorTotal}
                    placeholder="Valor total de la compra"
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
                    onIonChange={(e) => (compra.stock = e.detail.value)}
                    value={compra.stock}
                    placeholder="Stock de la compra"
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

export default ComprasEdit;