/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import CategoryList from "./CategoryList";
import { IonNav, IonPage } from "@ionic/react";

const CategoryPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <CategoryList />}></IonNav>
    </IonPage>
  );
};

export default CategoryPage;