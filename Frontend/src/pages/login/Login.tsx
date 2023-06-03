import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from "@ionic/react";
import React, { useState } from "react";
import { IonGrid, IonRow, IonCol } from "@ionic/react";
import { personCircle } from "ionicons/icons";
import { useHistory } from "react-router-dom";
import { IonItem, IonLabel, IonInput, IonButton, IonIcon, IonAlert } from "@ionic/react";
import "./Login.css";

import { loginFormat } from "./LoginFormat";
import { loginData } from "./LoginApi";

const Login: React.FC = () => {
  const history = useHistory();
  const [username, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");

  const [iserror, setIserror] = useState<boolean>(false);
  const [message, setMessage] = useState<string>("");


  const handleLogin = async () => {
    if (!username) {
      setMessage("Por favor ingrese su usuario");
      setIserror(true);
      return;
    }

    if (!password || password.length < 3) {
      setMessage("Porfavor ingrese su contraseña");
      setIserror(true);
      return;
    }

    const data: loginFormat = {
      username: username,
      password: password,
    };

    const loggedIn = await loginData(data);
    if (loggedIn) {
      // Inicio de sesión exitoso, redireccionar a la página principal
      history.push("/home");
    } else {
      // Error en el inicio de sesión, mostrar mensaje de error
      setMessage("Error en el inicio de sesión");
      setIserror(true);
    }
  };

  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonTitle>INICIO DE SESION</IonTitle>
        </IonToolbar>
      </IonHeader>
      <IonContent fullscreen className="ion-padding ion-text-center">
        <IonGrid>
          <IonRow>
            <IonCol>
              <IonAlert
                isOpen={iserror}
                onDidDismiss={() => setIserror(false)}
                cssClass="my-custom-class"
                header={"Error!"}
                message={message}
                buttons={["Dismiss"]}
              />
            </IonCol>
          </IonRow>
          <IonRow>
            <IonCol>
              <IonIcon style={{ fontSize: "70px", color: "#0040ff" }} icon={personCircle} />
            </IonCol>
          </IonRow>
          <IonRow>
            <IonCol>
              <IonItem>
                <IonLabel position="floating">Usuario</IonLabel>
                <IonInput type="text" value={username} onIonChange={(e) => setEmail(e.detail.value!)}></IonInput>
              </IonItem>
            </IonCol>
          </IonRow>

          <IonRow>
            <IonCol>
              <IonItem>
                <IonLabel position="floating">Contraseña</IonLabel>
                <IonInput type="password" value={password} onIonChange={(e) => setPassword(e.detail.value!)}></IonInput>
              </IonItem>
            </IonCol>
          </IonRow>
          <IonRow>
            <IonCol>
              <p className="small">
                Al iniciar sesión, aceptas nuestra <a href="/">política de privacidad</a>
              </p>
              <IonButton expand="block" onClick={handleLogin}>
                INICIAR SESIÓN
              </IonButton>
              <p className="medium">
                No tienes una cuenta <a href="/">Crea una Aquí</a>
              </p>
            </IonCol>
          </IonRow>
        </IonGrid>
      </IonContent>
    </IonPage>
  );
};

export default Login;
