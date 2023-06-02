/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import SupplierList from "./SupplierList";
import { IonNav, IonPage } from "@ionic/react";

const SupplierPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <SupplierList />}></IonNav>
    </IonPage>
  );
};

export default SupplierPage;
