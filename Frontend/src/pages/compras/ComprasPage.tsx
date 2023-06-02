import React from "react";
import "./../Page.css";

import ComprasList from "./ComprasList";
import { IonNav, IonPage } from "@ionic/react";

const ComprasPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <ComprasList />}></IonNav>
    </IonPage>
  );
};

export default ComprasPage;
