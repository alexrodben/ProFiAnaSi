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
  homeSharp,
  homeOutline,
  cardSharp,
  cardOutline,
  cubeSharp,
  cubeOutline,
  personSharp,
  personOutline,
  receiptSharp,
  receiptOutline,
  footstepsSharp,
  footstepsOutline,
  cog,
  people,
  clipboard,
  documentAttach,
} from "ionicons/icons";
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
    url: "/home",
    iosIcon: homeOutline,
    mdIcon: homeSharp,
  },
  {
    title: "Productos",
    url: "/products",
    iosIcon: cubeOutline,
    mdIcon: cubeSharp,
  },
  {
    title: "Ventas",
    url: "/ventas",
    iosIcon: cardOutline,
    mdIcon: cardSharp,
  },
  {
    title: "Compras",
    url: "/compras",
    iosIcon: receiptOutline,
    mdIcon: receiptSharp,
  },
  {
    title: "Clientes",
    url: "/customers",
    iosIcon: personOutline,
    mdIcon: personSharp,
  },
  {
    title: "Proveedores",
    url: "/suppliers",
    iosIcon: footstepsOutline,
    mdIcon: footstepsSharp,
  },
];

const labels: LabelPage[] = [
  {
    title: "Kardex",
    url: "/kardex",
    icon: documentAttach,
  },
  {
    title: "Categorías",
    url: "/categories",
    icon: clipboard,
  },
  {
    title: "Usuarios",
    url: "/users",
    icon: people,
  },
  {
    title: "Configuracion",
    url: "/settings",
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
          <IonListHeader>Complementos</IonListHeader>
          {labels.map((label, index) => {
            let disabled = label.title === "Configuracion" ? true : false;
            return (
              <IonMenuToggle key={index} autoHide={false}>
                <IonItem
                  lines="none"
                  detail={false}
                  routerDirection="none"
                  routerLink={label.url}
                  disabled={disabled}
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
