import { IonApp, IonRouterOutlet, IonSplitPane, setupIonicReact } from "@ionic/react";
import { IonReactRouter } from "@ionic/react-router";
import { Redirect, Route } from "react-router-dom";
import Menu from "./components/Menu";
import Page from "./pages/Page";

/* Core CSS required for Ionic components to work properly */
import "@ionic/react/css/core.css";

/* Basic CSS for apps built with Ionic */
import "@ionic/react/css/normalize.css";
import "@ionic/react/css/structure.css";
import "@ionic/react/css/typography.css";

/* Optional CSS utils that can be commented out */
import "@ionic/react/css/padding.css";
import "@ionic/react/css/float-elements.css";
import "@ionic/react/css/text-alignment.css";
import "@ionic/react/css/text-transformation.css";
import "@ionic/react/css/flex-utils.css";
import "@ionic/react/css/display.css";

/* Theme variables */
import "./theme/variables.css";


import Login from "./pages/login/Login";
import ProductPage from "./pages/product/ProductPage";
import SupplierPage from "./pages/supplier/SupplierPage";
import CustomerPage from "./pages/customer/CustomerPage";
import KardexPage from "./pages/kardex/KardexPage";
import CategoryPage from "./pages/category/CategoryPage";
import ComprasPage from "./pages/compras/ComprasPage";
import VentasPage from "./pages/ventas/VentasPage";
import UsersPage from "./pages/users/UserPage";


setupIonicReact();

const App: React.FC = () => {
  return (
    <IonApp>
      <IonReactRouter>
        <IonSplitPane contentId="main">
          <Menu />
          <IonRouterOutlet id="main">
            {/* Redirect Routes */}
            <Route path="/page" exact>
              <Redirect to="/home" />
            </Route>
            <Route path="/" exact>
              <Redirect to="/login" />
            </Route>

            {/* Default Routes */}
            <Route path="/:name" exact component={Page} />

            {/* Products Routes */}
            <Route path="/products" exact component={ProductPage} />

            {/* Customers Routes */}
            <Route path="/customers" exact component={CustomerPage} />

            {/* Suppliers Routes */}
            <Route path="/suppliers" exact component={SupplierPage} />

            {/* Kardex Routes */}
            <Route path="/kardex" exact component={KardexPage} />

            {/* Category Routes */}
            <Route path="/categories" exact component={CategoryPage} />

            {/* Compras Routes */}
            <Route path="/compras" exact component={ComprasPage} />

            {/* Ventas Routes */}
            <Route path="/ventas" exact component={VentasPage} />

            {/* Usuarios Routes */}
            <Route path="/users" exact component={UsersPage} />

            <Route path={["/home", "/about", "/contact"]} exact component={Page} />
          </IonRouterOutlet>
        </IonSplitPane>
        <Route path={"/login"} exact component={Login} />
      </IonReactRouter>
    </IonApp>
  );
};

export default App;
