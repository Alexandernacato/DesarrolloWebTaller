<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="menu.jsp" %> <%-- Asegúrate que la ruta a menu.jsp sea correcta --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes Forestales</title>
    <!-- Bootstrap CSS (Asegúrate que la ruta sea correcta o usa un CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome (Asegúrate que la ruta sea correcta o usa un CDN) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Google Fonts (Opcional) -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body { 
            background-color: #f8f9fa; /* Un gris más claro */
            font-family: 'Poppins', sans-serif; 
            padding-top: 70px; /* Ajuste para navbar fija si menu.jsp la tiene */
        }
        .dashboard-container { 
            padding: 25px; 
            margin-top: 20px; 
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
            background-color: #e9ecef; /* Un gris más suave para headers */
            border-bottom: 1px solid #dee2e6; 
            padding: 15px 20px; 
            font-weight: 600; 
            font-size: 1.1rem; 
            border-radius: 10px 10px 0 0 !important; 
            color: #343a40; /* Texto más oscuro para contraste */
        }
        .card-header i { 
            color: #007bff; /* Azul primario de Bootstrap */
            margin-right: 10px; 
        }
        .filter-form { 
            background-color: #fff; 
            padding: 20px; 
            border-radius: 10px; 
            margin-bottom: 20px; 
            border: 1px solid #dee2e6;
        }
        .btn-primary { 
            background-color: #007bff; 
            border-color: #007bff; 
        }
        .btn-primary:hover { 
            background-color: #0056b3; 
            border-color: #0056b3; 
        }
        .table-responsive {
            margin-top: 10px;
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
        <h2 class="text-center page-title">Reportes del Sistema Forestal</h2>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
            </div>
        </c:if>

        <!-- Filtro para Actividades de Conservación por Zona -->
        <div class="card filter-form">
            <div class="card-header"><i class="fas fa-filter"></i> Actividades de Conservación por Zona</div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/reportes" method="get">
                    <input type="hidden" name="action" value="ver_actividades_por_zona">
                    <div class="row align-items-end">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <label for="zonaId_filter_actividades" class="form-label">Seleccione una Zona:</label>
                            <select class="form-select" id="zonaId_filter_actividades" name="zonaId_filter_actividades" required>
                                <option value="">-- Elija una zona --</option>
                                <c:forEach var="zona" items="${zonasParaFiltro}">
                                    <option value="${zona.id}"><c:out value="${zona.nombre} (${zona.id})"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn btn-primary w-100">Ver Actividades</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabla para mostrar Actividades de Conservación por Zona -->
        <c:if test="${not empty actividadesPorZonaReporte}">
            <div class="card">
                <div class="card-header">
                    <i class="fas fa-tasks"></i> Actividades en la Zona: <c:out value="${zonaSeleccionadaNombre}"/>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre Actividad</th>
                                    <th>Fecha</th>
                                    <th>Responsable</th>
                                    <th>Tipo</th>
                                    <th>Descripción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="act" items="${actividadesPorZonaReporte}">
                                    <tr>
                                        <td><c:out value="${act.id}"/></td>
                                        <td><c:out value="${act.nombreActividad}"/></td>
                                        <td><fmt:formatDate value="${act.fechaActividad}" pattern="dd/MM/yyyy"/></td>
                                        <td><c:out value="${act.responsable}"/></td>
                                        <td><c:out value="${act.tipoActividad}"/></td> <%-- Ajusta si tipoActividad es un Enum y necesitas mostrar un valor específico --%>
                                        <td><c:out value="${act.descripcion}"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${empty actividadesPorZonaReporte and not empty requestScope.action and requestScope.action eq 'ver_actividades_por_zona'}">
             <div class="alert alert-info mt-3" role="alert">
                No se encontraron actividades para la zona seleccionada o la zona no tiene actividades registradas.
            </div>
        </c:if>

        <!-- Reporte: Especies Registradas por Zona (General) -->
        <div class="card mt-4">
            <div class="card-header"><i class="fas fa-leaf"></i> Especies Registradas por Zona (General)</div>
            <div class="card-body">
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${not empty reporteEspeciesZonaFijo}">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <c:forEach var="columnName" items="${reporteEspeciesZonaFijo[0].keySet()}">
                                            <th><c:out value="${columnName}"/></th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${reporteEspeciesZonaFijo}">
                                        <tr>
                                            <c:forEach var="cell" items="${row.values()}">
                                                <td><c:out value="${cell}"/></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center">No hay datos de especies por zona para mostrar.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Reporte: Conteo de Especies por Estado de Conservación (Tabla) -->
        <div class="card mt-4">
            <div class="card-header"><i class="fas fa-shield-alt"></i> Conteo de Especies por Estado de Conservación</div>
            <div class="card-body">
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${not empty reporteConteoEspeciesEstado}">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <c:forEach var="columnName" items="${reporteConteoEspeciesEstado[0].keySet()}">
                                            <th><c:out value="${columnName}"/></th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${reporteConteoEspeciesEstado}">
                                        <tr>
                                            <c:forEach var="cell" items="${row.values()}">
                                                <td><c:out value="${cell}"/></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center">No hay datos de conteo de especies por estado para mostrar.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Reporte: Detalles de Zonas Registradas -->
        <div class="card mt-4">
            <div class="card-header"><i class="fas fa-map-marked-alt"></i> Detalles de Zonas Registradas</div>
            <div class="card-body">
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${not empty reporteZonasConDetalles}">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <c:forEach var="columnName" items="${reporteZonasConDetalles[0].keySet()}">
                                            <th><c:out value="${columnName}"/></th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${reporteZonasConDetalles}">
                                        <tr>
                                            <c:forEach var="cell" items="${row.values()}">
                                                <td><c:out value="${cell}"/></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center">No hay detalles de zonas para mostrar.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <%-- Aquí puedes añadir más secciones para otros reportes o gráficos --%>
        <%-- Ejemplo para un gráfico ChartJS (si lo implementas)
        <div class="card mt-4">
            <div class="card-header"><i class="fas fa-chart-pie"></i> Gráfico Estado de Conservación</div>
            <div class="card-body">
                <canvas id="conservationStatusChart" width="400" height="200"></canvas>
            </div>
        </div>
        --%>

    </div> <!-- Cierre del .container.dashboard-container -->

    <!-- Scripts de JavaScript -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    
    <%-- Si usas ChartJS para el gráfico de estado de conservación, asegúrate que los datos se pasen correctamente --%>
    <%-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> --%>
    <%-- 
    <script>
        // Lógica para ChartJS si la mantienes y pasas los datos desde el servlet
        // Ejemplo:
        // const ctx = document.getElementById('conservationStatusChart');
        // if (ctx) {
        //     const conservationLabels = JSON.parse('${conservationLabelsJson}'); // Necesitarías pasar esto desde el servlet
        //     const conservationData = JSON.parse('${conservationDataJson}');   // Necesitarías pasar esto desde el servlet
        //
        //     new Chart(ctx, {
        //         type: 'pie', // o 'doughnut'
        //         data: {
        //             labels: conservationLabels,
        //             datasets: [{
        //                 label: 'Número de Especies',
        //                 data: conservationData,
        //                 backgroundColor: [
        //                     'rgba(255, 99, 132, 0.7)',
        //                     'rgba(54, 162, 235, 0.7)',
        //                     'rgba(255, 206, 86, 0.7)',
        //                     'rgba(75, 192, 192, 0.7)',
        //                     'rgba(153, 102, 255, 0.7)',
        //                     'rgba(255, 159, 64, 0.7)',
        //                     'rgba(199, 199, 199, 0.7)'
        //                 ],
        //                 borderColor: [
        //                     'rgba(255, 99, 132, 1)',
        //                     'rgba(54, 162, 235, 1)',
        //                     'rgba(255, 206, 86, 1)',
        //                     'rgba(75, 192, 192, 1)',
        //                     'rgba(153, 102, 255, 1)',
        //                     'rgba(255, 159, 64, 1)',
        //                     'rgba(199, 199, 199, 1)'
        //                 ],
        //                 borderWidth: 1
        //             }]
        //         },
        //         options: {
        //             responsive: true,
        //             maintainAspectRatio: false,
        //             plugins: {
        //                 legend: {
        //                     position: 'top',
        //                 },
        //                 title: {
        //                     display: true,
        //                     text: 'Distribución de Especies por Estado de Conservación'
        //                 }
        //             }
        //         }
        //     });
        // }
    </script>
    --%>
</body>
</html>