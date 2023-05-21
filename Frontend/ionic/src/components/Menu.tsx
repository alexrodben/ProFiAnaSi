import {
  IonContent,
  IonIcon,
  IonItem,
  IonLabel,
  IonList,
  IonListHeader,
  IonMenu,
  IonMenuToggle,
  IonNote,
} from "@ionic/react";

import { useLocation } from "react-router-dom";
import {
  homeOutline,
  homeSharp,
  cubeOutline,
  cubeSharp,
  receiptOutline,
  receiptSharp,
  documentAttachOutline,
  documentAttachSharp,
  newspaperOutline,
  newspaperSharp,
  personOutline,
  personSharp,
} from "ionicons/icons";
import { people, cog } from "ionicons/icons";
import "./Menu.css";

interface AppPage {
  url: string;
  iosIcon: string;
  mdIcon: string;
  title: string;
}
interface LabelPage {
  url: string;
  icon: string;
  title: string;
}

const appPages: AppPage[] = [
  {
    title: "Tablero",
    url: "/page/home",
    iosIcon: homeOutline,
    mdIcon: homeSharp,
  },
  {
    title: "Productos",
    url: "/page/products",
    iosIcon: cubeOutline,
    mdIcon: cubeSharp,
  },
  {
    title: "Pedidos",
    url: "/page/orders",
    iosIcon: receiptOutline,
    mdIcon: receiptSharp,
  },
  {
    title: "Clientes",
    url: "/page/customers",
    iosIcon: personOutline,
    mdIcon: personSharp,
  },
  {
    title: "Facturacion",
    url: "/page/billings",
    iosIcon: documentAttachOutline,
    mdIcon: documentAttachSharp,
  },
  {
    title: "Proveedores",
    url: "/page/suppliers",
    iosIcon: newspaperOutline,
    mdIcon: newspaperSharp,
  },
];

const labels: LabelPage[] = [
  {
    title: "Usuarios",
    url: "/page/users",
    icon: people,
  },
  {
    title: "Configuracion",
    url: "/page/settings",
    icon: cog,
  },
];

const Menu: React.FC = () => {
  const location = useLocation();

  return (
    <IonMenu contentId="main" type="overlay">
      <IonContent>
        <IonList id="inbox-list">
          <IonListHeader>Principal</IonListHeader>
          <IonNote>Sanarate</IonNote>
          {appPages.map((appPage, index) => {
            return (
              <IonMenuToggle key={index} autoHide={false}>
                <IonItem
                  lines="none"
                  detail={false}
                  routerDirection="none"
                  routerLink={appPage.url}
                  className={location.pathname === appPage.url ? "selected" : ""}
                >
                  <IonIcon aria-hidden="true" slot="start" ios={appPage.iosIcon} md={appPage.mdIcon} />
                  <IonLabel>{appPage.title}</IonLabel>
                </IonItem>
              </IonMenuToggle>
            );
          })}
        </IonList>

        <IonList id="labels-list">
          <IonListHeader>Configuraciones</IonListHeader>
          {labels.map((label, index) => {
            return (
              <IonMenuToggle key={index} autoHide={false}>
                <IonItem
                  lines="none"
                  detail={false}
                  routerDirection="none"
                  routerLink={label.url}
                  className={location.pathname === label.url ? "selected" : ""}
                >
                  <IonIcon aria-hidden="true" slot="start" icon={label.icon} />
                  <IonLabel>{label.title}</IonLabel>
                </IonItem>
              </IonMenuToggle>
            );
          })}
        </IonList>
      </IonContent>
    </IonMenu>
  );
};

export default Menu;
