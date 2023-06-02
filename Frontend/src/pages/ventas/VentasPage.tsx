import React from "react";
import "./../Page.css";

import VentasList from "./VentasList";
import { IonNav, IonPage } from "@ionic/react";

const VentasPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <VentasList />}></IonNav>
    </IonPage>
  );
};

export default VentasPage;
