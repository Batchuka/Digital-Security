#!/bin/bash

# Atualizar os pacotes
sudo apt-get update

# Instalar o Nginx
sudo apt-get install -y nginx

# Criar o diretório raiz do site
sudo mkdir -p /var/www/html

cat << 'EOF' | sudo tee /var/www/html/index.html > /dev/null
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supervisório da Planta</title>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #2c3e50;
            color: #ecf0f1;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .dashboard {
            width: 90%;
            max-width: 1200px;
            background-color: #34495e;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #ecf0f1;
        }

        .section {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .section div {
            flex: 1;
            margin: 10px;
            padding: 20px;
            background-color: #2c3e50;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        }

        .thermometer {
            text-align: center;
            color: #ecf0f1;
        }

        .thermometer h2 {
            margin-bottom: 15px;
        }

        .thermometer img {
            width: 50px;
        }

        .chart-container {
            width: 100%;
            height: 300px;
            margin-top: 20px;
        }

        @media(max-width: 768px) {
            .section {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <h1>Supervisório da Planta de Produção de Aço</h1>
        <div class="section">
            <div class="thermometer">
                <h2>Temperatura da Caldeira</h2>
                <img src="thermometer.svg" alt="Termômetro">
                <p><strong>Temperatura Atual:</strong> <span id="tempValue">800°C</span></p>
            </div>
            <div class="chart-container">
                <h2>Taxa de Produção ao Longo do Tempo</h2>
                <canvas id="productionChart"></canvas>
            </div>
        </div>
        <div class="section">
            <div class="chart-container">
                <h2>Consumo de Energia</h2>
                <canvas id="energyChart"></canvas>
            </div>
            <div class="chart-container">
                <h2>Métricas de Controle de Qualidade</h2>
                <canvas id="qualityChart"></canvas>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Dados de exemplo para os gráficos
        const ctxProduction = document.getElementById('productionChart').getContext('2d');
        const productionChart = new Chart(ctxProduction, {
            type: 'line',
            data: {
                labels: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio"],
                datasets: [{
                    label: "Taxa de Produção (toneladas/hora)",
                    data: [120, 130, 110, 140, 150],
                    borderColor: "#3498db",
                    fill: false
                }]
            }
        });

        const ctxEnergy = document.getElementById('energyChart').getContext('2d');
        const energyChart = new Chart(ctxEnergy, {
            type: "bar",
            data: {
                labels: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio"],
                datasets: [{
                    label: "Consumo de Energia (MWh)",
                    data: [200, 220, 210, 230, 240],
                    backgroundColor: "#e74c3c"
                }]
            }
        });

        const ctxQuality = document.getElementById("qualityChart").getContext("2d");
        const qualityChart = new Chart(ctxQuality, {
            type: "radar",
            data: {
                labels: ["Precisão", "Durabilidade", "Acabamento", "Dureza", "Flexibilidade"],
                datasets: [{
                    label: "Controle de Qualidade",
                    data: [90, 85, 88, 92, 87],
                    backgroundColor: "rgba(46, 204, 113, 0.2)",
                    borderColor: "rgba(46, 204, 113, 1)"
                }]
            }
        });
    </script>
</body>
</html>
EOF

# Reiniciar o Nginx para aplicar as mudanças
sudo systemctl restart nginx

# Exibir mensagem de conclusão
echo "Servidor web Nginx instalado e rodando em http://localhost!"