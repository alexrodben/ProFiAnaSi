import { IonButtons, IonCard, IonContent, IonHeader, IonLabel, IonList, IonListHeader, IonLoading, IonMenuButton, IonPage, IonTitle, IonToolbar } from "@ionic/react";
import { searchProductData } from "./product/ProductApi";
import { productFormat } from "./product/ProductFormat";
import React, { useEffect, useState } from 'react';
import { Chart, CategoryScale, LinearScale, BarController, BarElement } from 'chart.js';
import { Bar } from 'react-chartjs-2';
import "./Page.css";

interface ChartProps {
  products: productFormat[];
}

const Page: React.FC<ChartProps> = () => {

  const [productData, setProductData] = useState<productFormat[]>([]);
  const [showLoading, setShowLoading] = useState(false);

  useEffect(() => {
    searchProducts();
  }, []);

  const searchProducts = async () => {
    setShowLoading(true);
    try {
      const productList = await searchProductData();
      setProductData(productList);
    } catch (error) {
      console.error('Error al obtener los productos:', error);
    } finally {
      setShowLoading(false);
    }
  };

  // Registrando las escalas necesarias
  Chart.register(CategoryScale, LinearScale, BarController, BarElement);

  // Obtener los datos para el gráfico
  const chartData = {
    labels: productData.map((product) => product.Nombre),
    datasets: [
      {
        label: 'Stock',
        data: productData.map((product) => parseInt(product.Stock)), // Convertir el stock a tipo number
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
      },
    ],
  }
  // Configuración del gráfico
  const chartOptions = {
    scales: {
      y: {
        beginAtZero: true,
      },
    },
  };

  return (
    <IonPage>
      <IonHeader>
        <IonToolbar>
          <IonButtons slot="start">
            <IonMenuButton />
          </IonButtons>
          <IonTitle>Tablero</IonTitle>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonLoading
          isOpen={showLoading}
          onDidDismiss={() => setShowLoading(false)}
          message={'Cargando datos. Espere por favor...'}
        />
        <IonCard>
          <IonTitle>Grafica de productos</IonTitle>
          <IonList inset={true}>
            <IonListHeader color="primary">
              <IonLabel>Listado de Ventas</IonLabel>
            </IonListHeader>

            <div className="chart-container">
              <Bar data={chartData} options={chartOptions} />
            </div>
          </IonList>
        </IonCard>
      </IonContent>
    </IonPage>
  );
};

export default Page;
