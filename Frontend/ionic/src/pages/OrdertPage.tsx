/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import OrderList from "./OrderList";
import { IonNav, IonPage } from "@ionic/react";

const OrderPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <OrderList />}></IonNav>
    </IonPage>
  );
};

export default OrderPage;