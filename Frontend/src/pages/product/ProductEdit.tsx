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

  const edit = async () => {
    if (
      product.Nombre &&
      product.SKU &&
      product.Estado &&
      product.Descripcion &&
      product.Existencia_minima &&
      product.Existencia_maxima &&
      product.Stock &&
      product.Imagen &&
      product.Valor_Unitario &&
      product.CreatedAt &&
      product.UpdatedAt
    ) {
      const newProduct: productFormat = {
        Id_Producto: product.Id_Producto,
        Nombre: product.Nombre,
        SKU: product.SKU,
        Id_Categoria: product.category,
        Estado: product.Estado,
        Descripcion: product.Descripcion,
        Existencia_minima: product.Existencia_minima,
        Existencia_maxima: product.Existencia_maxima,
        Stock: product.Stock,
        Imagen: product.Imagen,
        Valor_Unitario: product.Valor_Unitario,
        CreatedAt: product.CreatedAt,
        UpdatedAt: product.UpdatedAt,
      };
      let edit = await editProductData(newProduct);
      if (edit) history.push("/products");
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
          handler: async () => {
            let Id_Producto = item.Id_Producto;
            let del = await removeProductData(Id_Producto);
            if (del) history.push("/products");
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
          <IonTitle>{product.Nombre}</IonTitle>
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
                    onIonChange={(e) => (product.Nombre = e.detail.value)}
                    value={product.Nombre}
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
                    onIonChange={(e) => (product.SKU = e.detail.value)}
                    placeholder="SKU del producto"
                    value={product.SKU}
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
                    onIonChange={(e) => (product.Estado = e.detail.value)}
                    placeholder="Estado del producto"
                    value={product.Estado}
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
                    onIonChange={(e) => (product.Descripcion = e.detail.value)}
                    placeholder="Descripción del producto"
                    value={product.Descripcion}
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
                    onIonChange={(e) => (product.Existencia_minima = e.detail.value)}
                    value={product.Existencia_minima}
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
                    onIonChange={(e) => (product.Existencia_maxima = e.detail.value)}
                    value={product.Existencia_maxima}
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
                    onIonChange={(e) => (product.Stock = e.detail.value)}
                    value={product.Stock}
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
                    onIonChange={(e) => (product.Imagen = e.detail.value)}
                    value={product.Imagen}
                    placeholder="URL de la Imagenn del producto"
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
                    onIonChange={(e) => (product.Valor_Unitario = e.detail.value)}
                    value={product.Valor_Unitario}
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
                    onIonChange={(e) => (product.CreatedAt = e.detail.value)}
                    value={product.CreatedAt}
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
                    onIonChange={(e) => (product.UpdatedAt = e.detail.value)}
                    value={product.UpdatedAt}
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