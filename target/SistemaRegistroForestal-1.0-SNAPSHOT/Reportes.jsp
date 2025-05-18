<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="menu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Reportes Forestales</title>

    <!-- Estilos y Fuentes -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
            padding-top: 70px;
        }
        .dashboard-container {
            padding: 25px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        .card-header {
            background-color: #e9ecef;
            border-bottom: 1px solid #dee2e6;
            padding: 15px 20px;
            font-weight: 600;
            font-size: 1.1rem;
            border-radius: 10px 10px 0 0 !important;
            color: #343a40;
        }
        .page-title {
            color: #343a40;
            margin-bottom: 30px;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container dashboard-container">
    <h2 class="text-center page-title">Especies existentes en cada Zona</h2>

    <!-- Primera fila: Cantidad de Especies por Zona -->
    <div class="row mb-4">
        <!-- Tabla Cantidad de Especies por Zona -->
        <div class="col-lg-6 col-md-12">
            <div class="card">
                <div class="card-header"><i class="fas fa-leaf"></i> Cantidad de Especies por Zona (Tabla)</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th>Zona</th>
                                    <th>Cantidad de Especies</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="fila" items="${reporteCantidadEspeciesPorZona}">
                                    <tr>
                                        <td>${fila["Zona"]}</td>
                                        <td>${fila["Cantidad de Especies"]}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Gráfico Cantidad de Especies por Zona -->
        <div class="col-lg-6 col-md-12">
            <div class="card">
                <div class="card-header"><i class="fas fa-chart-bar"></i> Cantidad de Especies por Zona (Gráfico)</div>
                <div class="card-body">
                    <canvas id="chartEspeciesPorZona" style="max-width: 100%; max-height: 400px;"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Segunda fila: Cantidad de Zonas por Tipo de Actividad -->
    <div class="row mb-4">
        <!-- Tabla Cantidad de Zonas por Tipo de Actividad -->
        <div class="col-lg-6 col-md-12">
            <div class="card">
                <div class="card-header"><i class="fas fa-chart-pie"></i> Cantidad de Zonas por Tipo de Actividad (Tabla)</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${not empty reporteCantidadZonasPorTipoActividad}">
                                <table class="table table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Tipo de Actividad</th>
                                            <th>Cantidad de Zonas</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="fila" items="${reporteCantidadZonasPorTipoActividad}">
                                            <tr>
                                                <td><c:out value="${fila.tipo_actividad}" /></td>
                                                <td><c:out value="${fila.cantidad_zonas}" /></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted">No hay datos disponibles.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Gráfico Cantidad de Zonas por Tipo de Actividad -->
        <div class="col-lg-6 col-md-12">
            <div class="card">
                <div class="card-header"><i class="fas fa-chart-pie"></i> Cantidad de Zonas por Tipo de Actividad (Gráfico)</div>
                <div class="card-body">
                    <canvas id="chartZonasPorActividad" style="max-width: 100%; max-height: 400px;"></canvas>
                </div>
            </div>
        </div>
    </div>
        
<!-- Tercera fila: Actividades por Mes -->
<div class="row mb-4">
    <!-- Tabla Actividades por Mes -->
    <div class="col-lg-6 col-md-12">
        <div class="card">
            <div class="card-header"><i class="fas fa-calendar-alt"></i> Actividades por Mes (Tabla)</div>
            <div class="card-body">
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${not empty reporteActividadesPorMes}">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>Año</th>
                                        <th>Mes</th>
                                        <th>Total de Actividades</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="fila" items="${reporteActividadesPorMes}">
                                        <tr>
                                            <td><c:out value="${fila.anio}" /></td>
                                            <td><c:out value="${fila.mes}" /></td>
                                            <td><c:out value="${fila.total_actividades}" /></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center text-muted">No hay datos disponibles.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Gráfico Actividades por Mes -->
    <div class="col-lg-6 col-md-12">
        <div class="card">
            <div class="card-header"><i class="fas fa-chart-line"></i> Actividades por Mes (Gráfico)</div>
            <div class="card-body">
                <canvas id="chartActividadesPorMes" style="max-width: 100%; max-height: 400px;"></canvas>
            </div>
        </div>
    </div>
</div>

    
        <!-- Tarjeta 1: Tabla Especies por Zona -->
        <div class="col-lg-6 col-md-12">
            <div class="card">
                <div class="card-header"><i class="fas fa-tree"></i> Especies Registradas por Zona</div>
                <div class="card-body">
                    
                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${not empty reporteEspeciesZonaFijo}">
                                <table class="table table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Zona</th>
                                            <th>Especie</th>
                                            <th>Nombre Científico</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="fila" items="${reporteEspeciesZonaFijo}">
                                            <tr>
                                                <c:forEach var="dato" items="${fila.values()}">
                                                    <td><c:out value="${dato}" /></td>
                                                </c:forEach>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <canvas id="chartEspeciesRegistradasPorZona" style="max-width: 100%; max-height: 400px;"></canvas>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted">No hay datos disponibles.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
  

    <!-- Script para generar gráfico -->
    <script>
        const etiquetasActividad = [
            <c:forEach var="fila" items="${reporteCantidadZonasPorTipoActividad}" varStatus="status">
                '${fila.tipo_actividad}'<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        const valoresActividad = [
            <c:forEach var="fila" items="${reporteCantidadZonasPorTipoActividad}" varStatus="status">
                ${fila.cantidad_zonas}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        const ctx = document.getElementById('chartZonasPorActividad').getContext('2d');
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: etiquetasActividad,
                datasets: [{
                    data: valoresActividad,
                    backgroundColor: [
                        '#007bff', '#28a745', '#ffc107', '#dc3545', '#17a2b8', '#6f42c1', '#fd7e14'
                    ],
                    borderColor: '#fff',
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            font: {
                                size: 14
                            }
                        }
                    }
                }
            }
        });
        
        // Gráfico de barras - Cantidad de Especies por Zona
const etiquetasZonas = [
    <c:forEach var="fila" items="${reporteCantidadEspeciesPorZona}" varStatus="status">
        '${fila["Zona"]}'<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const valoresEspecies = [
    <c:forEach var="fila" items="${reporteCantidadEspeciesPorZona}" varStatus="status">
        ${fila["Cantidad de Especies"]}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

const ctxBarras = document.getElementById('chartEspeciesPorZona').getContext('2d');
new Chart(ctxBarras, {
    type: 'bar',
    data: {
        labels: etiquetasZonas,
        datasets: [{
            label: 'Cantidad de Especies',
            data: valoresEspecies,
            backgroundColor: '#28a745',
            borderColor: '#1e7e34',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    stepSize: 1
                }
            }
        },
        plugins: {
            legend: {
                display: false
            }
        }
    }

});




   // Definir las etiquetas y los valores del gráfico (tomados de los datos proporcionados en el servidor)
    const etiquetasActividadesMes = [
        <c:forEach var="fila" items="${reporteActividadesPorMes}" varStatus="status">
            '${fila.mes}'<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const valoresActividadesMes = [
        <c:forEach var="fila" items="${reporteActividadesPorMes}" varStatus="status">
            ${fila.total_actividades}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    // Crear el gráfico en el canvas especificado
    const ctxActividadesMes = document.getElementById('chartActividadesPorMes').getContext('2d');
    new Chart(ctxActividadesMes, {
        type: 'line', // Tipo de gráfico (en este caso, una línea)
        data: {
            labels: etiquetasActividadesMes, // Etiquetas de los meses
            datasets: [{
                label: 'Total de Actividades', // Nombre del conjunto de datos
                data: valoresActividadesMes, // Los valores de las actividades
                fill: false, // No llenar el área debajo de la línea
                borderColor: '#28a745', // Color del borde de la línea
                tension: 0.1 // Curvatura de la línea
            }]
        },
        options: {
            responsive: true, // Hacer que el gráfico sea responsive
            plugins: {
                legend: {
                    position: 'top', // Posición de la leyenda
                    labels: {
                        font: {
                            size: 14 // Tamaño de la fuente de la leyenda
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true, // Asegurarse de que el eje Y comience en 0
                    ticks: {
                        stepSize: 1 // Tamaño de los pasos en el eje Y
                    }
                }
            }
        }
    });
    
    
    
    
    
    
    
    
    
    
    
</script>
</body>
</html>
