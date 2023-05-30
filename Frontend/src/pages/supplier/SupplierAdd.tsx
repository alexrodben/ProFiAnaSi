/* eslint-disable react/jsx-no-comment-textnodes */
import React, { useState } from "react";
import { useHistory } from "react-router-dom";
import { IonButton, IonContent, IonHeader, IonInput, IonPage, IonTitle, IonToolbar } from "@ionic/react";
import { SupplierFormat, saveDataSupplier } from "./SupplierApi";

const SupplierAdd: React.FC = () => {
  const history = useHistory();
  const [supplier, setSupplier] = useState<SupplierFormat>({
    id: "",
    name: "",
    address: "",
    phone: "",
  });

  const handleSave = () => {
    let newSupplier: SupplierFormat = {
      id: supplier.id,
      name: supplier.name,
      address: supplier.address,
      phone: supplier.phone,
    };
    let saved = saveDataSupplier(newSupplier);
    if (saved) {
      history.goBack();
    }
  };

  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonTitle>Agregar Proveedor</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent>
        <IonInput
          placeholder="ID"
          value={supplier.id}
          onIonChange={(e) => setSupplier({ ...supplier, id: e.detail.value! })}
        ></IonInput>
        <IonInput
          placeholder="Nombre"
          value={supplier.name}
          onIonChange={(e) => setSupplier({ ...supplier, name: e.detail.value! })}
        ></IonInput>
        <IonInput
          placeholder="Dirección"
          value={supplier.address}
          onIonChange={(e) => setSupplier({ ...supplier, address: e.detail.value! })}
        ></IonInput>
        <IonInput
          placeholder="Teléfono"
          value={supplier.phone}
          onIonChange={(e) => setSupplier({ ...supplier, phone: e.detail.value! })}
        ></IonInput>
        <IonButton expand="full" onClick={handleSave}>
          Guardar
        </IonButton>
      </IonContent>
    </IonPage>
  );
};

export default SupplierAdd;