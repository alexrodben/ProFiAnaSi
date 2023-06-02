/* eslint-disable react/jsx-no-comment-textnodes */
import React from "react";
import "./../Page.css";

import UsersList from "./UsersList";
import { IonNav, IonPage } from "@ionic/react";

const UsersPage: React.FC = () => {
  return (
    <IonPage>
      <IonNav root={() => <UsersList />}></IonNav>
    </IonPage>
  );
};

export default UsersPage;
