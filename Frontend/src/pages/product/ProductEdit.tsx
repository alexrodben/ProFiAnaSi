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
import { productFormat } from "./ProductFormat";
import { editProductData, removeProductData } from "./ProductApi";
import { useHistory } from "react-router";

interface ContainerProps {
  item: productFormat;
}

const ProductEdit: React.FC<ContainerProps> = ({ item }) => {
  const [product, setProduct] = useState<any>({});
  const [present] = useIonToast();
  const [presentAlert] = useIonAlert();
  const history = useHistory();

  const edit = () => {
    if (
      product.name &&
      product.sku &&
      product.status &&
      product.description &&
      product.minStock &&
      product.maxStock &&
      product.stock &&
      product.image &&
      product.unitPrice &&
      product.registrationDate &&
      product.updateDate
    ) {
      const newProduct: productFormat = {
        id: Math.round(Math.random() * 10000).toString(),
        name: product.name,
        sku: product.sku,
        status: product.status,
        description: product.description,
        minStock: product.minStock,
        maxStock: product.maxStock,
        stock: product.stock,
        image: product.image,
        unitPrice: product.unitPrice,
        registrationDate: product.registrationDate,
        updateDate: product.updateDate,
      };
      editProductData(newProduct);
      history.push("products");
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
            removeProductData(id);
            history.push("products");
          },
        },
      ],
    });
  };

  useEffect(() => {
    setProduct(item);
  }, [item]);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>{product.name}</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"warning"}>
              <IonLabel>Modificar o visualizar un producto</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Nombre</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.name = e.detail.value)}
                    value={product.name}
                    placeholder="Nombre del producto"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">SKU</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.sku = e.detail.value)}
                    placeholder="SKU del producto"
                    value={product.sku}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Estado</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.status = e.detail.value)}
                    placeholder="Estado del producto"
                    value={product.status}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Descripción</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.description = e.detail.value)}
                    placeholder="Descripción del producto"
                    value={product.description}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Stock Mínimo</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.minStock = e.detail.value)}
                    value={product.minStock}
                    placeholder="Stock mínimo del producto"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Stock Máximo</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.maxStock = e.detail.value)}
                    value={product.maxStock}
                    placeholder="Stock máximo del producto"
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
                    onIonChange={(e) => (product.stock = e.detail.value)}
                    value={product.stock}
                    placeholder="Stock del producto"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Imagen</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.image = e.detail.value)}
                    value={product.image}
                    placeholder="URL de la imagen del producto"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Precio Unitario</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.unitPrice = e.detail.value)}
                    value={product.unitPrice}
                    placeholder="Precio unitario del producto"
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Fecha de Registro</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.registrationDate = e.detail.value)}
                    value={product.registrationDate}
                    placeholder="Fecha de Registro del producto"
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
                    onIonChange={(e) => (product.updateDate = e.detail.value)}
                    value={product.updateDate}
                    placeholder="Fecha de Actualización del producto"
                    required
                    disabled
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

export default ProductEdit;