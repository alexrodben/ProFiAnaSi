/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import KardexList from "./KardexList";
import { IonNav, IonPage } from "@ionic/react";

const KardexPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <KardexList />}></IonNav>
    </IonPage>
  );
};

export default KardexPage;
