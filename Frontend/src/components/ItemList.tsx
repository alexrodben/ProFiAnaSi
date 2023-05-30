//import './ItemList.css';

import { IonButton, IonCardHeader, IonCardSubtitle, IonCardTitle, IonItem, IonThumbnail } from "@ionic/react";

interface DataFormat {
  id: number;
  name: string;
  description: string;
  image: string;
}

interface ContainerProps {
  data: DataFormat;
  url: string;
  image?: boolean;
}

const ItemList: React.FC<ContainerProps> = ({ data, url, image = false }) => {
  const sendUrl = url + "/" + data.id;
  return (
    <>
      <IonItem>
        {image && (
          <IonThumbnail slot="start">
            <img alt="Silhouette of mountains" src={data.image} />
          </IonThumbnail>
        )}
        <IonCardHeader>
          <IonCardTitle>{data.name}</IonCardTitle>
          <IonCardSubtitle>{data.description}</IonCardSubtitle>
        </IonCardHeader>
        <IonButton slot="end" shape="round" size="default" fill="outline" routerLink={sendUrl}>
          &gt;
        </IonButton>
      </IonItem>
    </>
  );
};

export default ItemList;
