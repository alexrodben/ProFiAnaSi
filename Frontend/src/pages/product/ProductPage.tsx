/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import ProductList from "./ProductList";
import { IonNav, IonPage } from "@ionic/react";

const ProductPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <ProductList />}></IonNav>
    </IonPage>
  );
};

export default ProductPage;
