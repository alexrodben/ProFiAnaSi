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
import { productFormat } from "./ProductFormat";
import { saveDataProduct } from "./ProductApi";
import { useHistory } from "react-router";

const ProductAdd: React.FC = () => {
  const [product, setProduct] = useState<any>({});
  const [saveDisabled, setSaveDisabled] = useState<boolean>(true);
  const [present] = useIonToast();
  const history = useHistory();

  const save = () => {
    if (product.name && product.description && product.image) {
      const newProduct: productFormat = {
        id: Math.round(Math.random() * 10000).toString(),
        name: product.name,
        price: product.price,
        description: product.description,
        image: product.image,
        estado: product.estado
      };
      let saved = saveDataProduct(newProduct);
      if (saved && saveDisabled === true) {
        setSaveDisabled(false);
        history.goBack();
      }

      //history.push("products");
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
    setProduct({ id: "", name: "", description: "", image: "" });
  }, []);

  return (
    <>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonBackButton></IonBackButton>
          </IonButtons>
          <IonTitle>Agregar un nuevo productos</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonCard>
          <IonList inset={true}>
            <IonListHeader color={"success"}>
              <IonLabel>Agregar un nuevo productos</IonLabel>
            </IonListHeader>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Nombre</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.name = e.detail.value)}
                    placeholder="Nombre del producto"
                    value={product.name}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Price</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.price = e.detail.value)}
                    placeholder="Descripcion del producto"
                    value={product.price}
                    required
                  ></IonInput>
                </IonItem>
              </IonCol>
            </IonRow>
            <IonRow>
              <IonCol>
                <IonItem>
                  <IonLabel position="floating">Descripcion</IonLabel>
                  <IonInput
                    onIonChange={(e) => (product.description = e.detail.value)}
                    placeholder="Descripcion del producto"
                    value={product.description}
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
                    onIonChange={(e) => (product.estado = e.detail.value)}
                    placeholder="Estado del producto"
                    value={product.estado}
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
                    placeholder="Imagen"
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
