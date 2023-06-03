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
import { saveProductData } from "./ProductApi";
import { useHistory } from "react-router";
import { productFormat } from "./ProductFormat";

const ProductAdd: React.FC = () => {
  const [product, setProduct] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = async () => {
    if (
      product.name &&
      product.sku &&
      product.status &&
      product.description &&
      product.minStock &&
      product.maxStock &&
      product.stock &&
      product.image &&
      product.unitPrice
    ) {
      const newProduct: productFormat = {
        Id_Producto: Math.round(Math.random() * 10).toString(),
        Id_Categoria: Math.round(Math.random() * 10).toString(),
        Nombre: product.name,
        SKU: product.sku,
        Estado: product.status,
        Descripcion: product.description,
        Existencia_minima: product.minStock,
        Existencia_maxima: product.maxStock,
        Stock: product.stock,
        Imagen: product.image,
        Valor_Unitario: product.unitPrice,
      };
      let saved = await saveProductData(newProduct);
      if (saved && saveDisabled === true) {
        setSaveDisabled(false);
        history.push("/products");
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
    setProduct({
      id: "",
      name: "",
      sku: "",
      status: "",
      description: "",
      minStock: "",
      maxStock: "",
      stock: "",
      image: "",
      unitPrice: "",
    });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar un nuevo producto</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar un nuevo producto</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Nombre</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.name = e.detail.value)}
                    placeholder="Nombre"
                    value={product.name}
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
                    placeholder="SKU"
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
                    placeholder="Estado"
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
                    placeholder="Descripción"
                    value={product.description}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Existencia Mínima</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.minStock = e.detail.value)}
                    placeholder="Existencia Mínima"
                    value={product.minStock}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Existencia Máxima</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.maxStock = e.detail.value)}
                    placeholder="Existencia Máxima"
                    value={product.maxStock}
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
                    placeholder="Stock"
                    value={product.stock}
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
                    placeholder="Imagen"
                    value={product.image}
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
                    onIonChange={(e) => (product.unitPrice = e.detail.value)}
                    placeholder="Valor Unitario"
                    value={product.unitPrice}
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

export default ProductAdd;