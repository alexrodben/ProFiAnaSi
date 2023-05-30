/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import ProductsList from "./ProductList";
import { IonNav, IonPage } from "@ionic/react";

const ProductPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <ProductsList />}></IonNav>
    </IonPage>
  );
};

export default ProductPage;
