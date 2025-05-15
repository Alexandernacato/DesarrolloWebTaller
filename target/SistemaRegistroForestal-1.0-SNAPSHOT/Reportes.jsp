<%@ include file="menu.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes - Sistema de Registro Forestal</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/2.3.0/css/dataTables.bootstrap5.css" rel="stylesheet">
    
    <style>
        .container {
            margin-left: auto !important; /* Elimina el margen izquierdo */
            margin-right: auto !important;
            max-width: 1200px;
        }
        
        .table-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
            padding: 20px;
        }
        
        .section-title {
            color: #005f40;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Reportes del Sistema de Conservación Forestal</h2>
        
        <!-- Sección de filtrado -->
        <div class="filter-section">
            <div class="row">
                <div class="col-md-4">
                    <div class="mb-3">
                        <label for="zonaFilter" class="form-label">Zona:</label>
                        <select class="form-select" id="zonaFilter">
                            <option value="">Todas las zonas</option>
                            <c:forEach var="zona" items="${zonas}">
                                <option value="${zona.id}">${zona.nombre}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="mb-3">
                        <label for="tipoActividadFilter" class="form-label">Tipo de Actividad:</label>
                        <select class="form-select" id="tipoActividadFilter">
                            <option value="">Todos los tipos</option>
                            <option value="Reforestación">Reforestación</option>
                            <option value="Monitoreo">Monitoreo</option>
                            <option value="Control de especies invasoras">Control de especies invasoras</option>
                            <option value="Educación ambiental">Educación ambiental</option>
                            <option value="Otro">Otro</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="mb-3">
                        <label class="form-label">&nbsp;</label>
                        <button id="btnFiltrar" class="btn btn-primary form-control">
                            <i class="fas fa-filter"></i> Aplicar Filtros
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Tabla de Especies por Zona -->
        <div class="table-container">
            <h3 class="section-title">Especies por Zona</h3>
            <div class="table-responsive">
                <table id="especiesTable" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Zona</th>
                            <th>Tipo de Bosque</th>
                            <th>Cantidad de Especies</th>
                            <th>Especies</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
    <c:when test="${not empty especiesPorZona}">
        <c:forEach var="especie" items="${especiesPorZona}">
            <tr>
                <td>${especie.nombreZona}</td>
                <td>${especie.tipoBosque}</td>
                <td>${especie.cantidadEspecies}</td>
                <td>
                    <c:choose>
                        <c:when test="${empty especie.especies}">
                            Sin especies registradas
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="esp" items="${especie.especies}" varStatus="status">
                                ${esp.nombreComun}<c:if test="${!status.last}">, </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <tr>
            <td colspan="4" class="text-center">No hay datos para mostrar</td>
        </tr>
    </c:otherwise>
</c:choose>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Tabla de Actividades de Conservación por Zona -->
        <div class="table-container">
            <h3 class="section-title">Actividades de Conservación por Zona</h3>
            <div class="table-responsive">
                <table id="actividadesTable" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Zona</th>
                            <th>Actividad</th>
                            <th>Tipo</th>
                            <th>Fecha</th>
                            <th>Responsable</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Los datos se cargarán desde el servidor -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Scripts necesarios -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.bootstrap5.js"></script>
    
    <script>
        // Variables para almacenar las instancias de DataTables
        let especiesTable;
        let actividadesTable;
        
        $(document).ready(function() {
            // Inicializar las tablas de DataTables
            especiesTable = $('#especiesTable').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json'
                },
                responsive: true
            });
            
            actividadesTable = $('#actividadesTable').DataTable({
                language: {
                    url: 'https://cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json'
                },
                responsive: true
            });
            
            // Cargar datos iniciales
            cargarZonas();
            cargarDatos();
            
            // Evento para el botón de filtrado
            $('#btnFiltrar').click(function() {
                cargarDatos();
            });
        });
        
        // Función para cargar las zonas en el select
        function cargarZonas() {
            $.ajax({
                url: '${pageContext.request.contextPath}/reportes',
                type: 'GET',
                data: { action: 'getZonas' },
                dataType: 'json',
                success: function(response) {
                    const select = $('#zonaFilter');
                    select.empty();
                    select.append('<option value="">Todas las zonas</option>');
                    
                    response.forEach(function(zona) {
                        select.append(`<option value="${zona.id}">${zona.nombre}</option>`);
                    });
                },
                error: function() {
                    console.error('Error al cargar las zonas');
                }
            });
        }
        
        // Función para cargar los datos de especies y actividades
        function cargarDatos() {
            const zonaId = $('#zonaFilter').val();
            const tipoActividad = $('#tipoActividadFilter').val();
            
            // Mostrar indicador de carga
            $('#especiesTable tbody').html('<tr><td colspan="4" class="text-center">Cargando datos...</td></tr>');
            $('#actividadesTable tbody').html('<tr><td colspan="5" class="text-center">Cargando datos...</td></tr>');
            
            $.ajax({
                url: '${pageContext.request.contextPath}/reportes',
                type: 'GET',
                data: { 
                    action: 'getDatosReporte',
                    zonaId: zonaId,
                    tipoActividad: tipoActividad
                },
                dataType: 'json',
                success: function(response) {
                    // Actualizar tabla de especies
                    especiesTable.clear();
                    if (response.especies && response.especies.length > 0) {
                        response.especies.forEach(function(especie) {
                            especiesTable.row.add([
                                especie.nombreZona,
                                especie.tipoBosque,
                                especie.cantidadEspecies,
                                especie.nombresEspecies
                            ]);
                        });
                    }
                    especiesTable.draw();
                    
                    // Actualizar tabla de actividades
                    actividadesTable.clear();
                    if (response.actividades && response.actividades.length > 0) {
                        response.actividades.forEach(function(actividad) {
                            actividadesTable.row.add([
                                actividad.nombreZona,
                                actividad.nombreActividad,
                                actividad.tipoActividad,
                                formatDate(actividad.fechaActividad),
                                actividad.responsable
                            ]);
                        });
                    }
                    actividadesTable.draw();
                },
                error: function(error) {
                    console.error('Error al cargar los datos:', error);
                    $('#especiesTable tbody').html('<tr><td colspan="4" class="text-center text-danger">Error al cargar datos</td></tr>');
                    $('#actividadesTable tbody').html('<tr><td colspan="5" class="text-center text-danger">Error al cargar datos</td></tr>');
                }
            });
        }
        
        // Función para formatear fechas
        function formatDate(dateString) {
            if (!dateString) return '';
            
            const date = new Date(dateString);
            return date.toLocaleDateString('es-ES', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric'
            });
        }
    </script>
</body>
</html>