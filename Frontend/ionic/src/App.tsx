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

import OrderPage from "./pages/order/OrdertPage";
import Login from "./pages/login/Login";
import ProductPage from "./pages/product/ProductPage";
import ProductEdit from "./pages/product/ProductEdit";
import SupplierPage from "./pages/supplier/SupplierPage";
import CustomerPage from "./pages/custumer/CustomerPage";
import KardexPage from "./pages/kardex/KardexPage";
import OrdertPage from "./pages/order/OrdertPage";

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
              <Redirect to="/page/home" />
            </Route>
            <Route path="/" exact>
              <Redirect to="/login" />
            </Route>

            {/* Default Routes */}
            <Route path="/page/:name" exact component={Page} />

            {/* Products Routes */}
            <Route path="/page/products" exact component={ProductPage} />
            <Route path="/page/products/:id" exact component={ProductEdit} />

            {/* Orders Routes */}
            <Route path="/page/orders" exact component={OrdertPage} />
            <Route path="/page/orders/:id" exact component={Page} />
            <Route path="/page/orders/new" exact component={Page} />

            {/* Customers Routes */}
            <Route path="/page/customers" exact component={CustomerPage} />
            <Route path="/page/customers/:id" exact component={Page} />
            <Route path="/page/customers/new" exact component={Page} />

            {/* Suppliers Routes */}
            <Route path="/page/suppliers" exact component={SupplierPage} />
            <Route path="/page/suppliers/:id" exact component={Page} />
            
            
            {/* Kardex Routes */}
            <Route path="/page/kardex" exact component={KardexPage} />
            <Route path="/page/kardex/:id" exact component={Page} />

            <Route path={["/page/home", "/page/about", "/page/contact"]} exact component={Page} />
          </IonRouterOutlet>
        </IonSplitPane>
        <Route path={"/login"} exact component={Login} />
      </IonReactRouter>
    </IonApp>
  );
};

export default App;
