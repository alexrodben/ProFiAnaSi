/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import CustomerList from "./CustomerList";
import { IonNav, IonPage } from "@ionic/react";

const CustomerPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <CustomerList />}></IonNav>
    </IonPage>
  );
};

export default CustomerPage;
