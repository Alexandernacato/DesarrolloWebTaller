<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Actividades de Conservación</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/2.3.0/css/dataTables.bootstrap5.css" rel="stylesheet">
    
    <style>
        table#conservationActivitiesTable {
            width: 100% !important;
        }
        table#conservationActivitiesTable td:last-child {
            white-space: nowrap;
        }
        table#conservationActivitiesTable td:last-child a.btn {
            margin-right: 5px;
        }
    </style>
    
</head>

<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Listado de Actividades de Conservación</h2>
        <a href="${pageContext.request.contextPath}/ConservationActivities?option=new" class="btn btn-primary mb-3" id="abrirModal">Agregar Nueva Actividad</a>

        <table id="conservationActivitiesTable" class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre Actividad</th>
                    <th>Fecha</th>
                    <th>Responsable</th>
                    <th>Tipo Actividad</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="actividad" items="${listaActividades}">
                    <tr>
                        <td>${actividad.id}</td>
                        <td>${actividad.nombreActividad}</td>
                        <td>${actividad.fechaActividad}</td>
                        <td>${actividad.responsable}</td>
                        <td>${actividad.tipoActividad}</td>
                        <td>${actividad.descripcion}</td>
                        <td>
                            <c:choose>
                                <c:when test="${actividad.activo}">
                                    Activo
                                </c:when>
                                <c:otherwise>
                                    Inactivo
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/ConservationActivities?option=update&id=${actividad.id}" class="btn btn-warning btn-sm" id="editar_${actividad.id}">Editar</a> |
                            <a href="${pageContext.request.contextPath}/ConservationActivities?option=delete&id=${actividad.id}" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar esta actividad?')">Eliminar</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="modalFormulario" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" id="contenidoModal">
                <!-- El contenido se cargará aquí -->
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <!-- Bootstrap JS (con Popper) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.js"></script>

    <!-- DataTables Bootstrap JS -->
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.bootstrap5.js"></script>

    <script>
    $(document).ready(function(){
        // Abrir modal para agregar nueva actividad
        $('#abrirModal').click(function(e){
            e.preventDefault();

            var url = $(this).attr('href');

            $('#contenidoModal').load(url, function(){
                $('#modalFormulario').modal('show');
            });
        });

        // Abrir modal para editar actividad
        $('[id^="editar_"]').click(function(e){
            e.preventDefault();

            var url = $(this).attr('href');

            $('#contenidoModal').load(url, function(){
                $('#modalFormulario').modal('show');
            });
        });

        // Inicializar DataTables
        $('#conservationActivitiesTable').DataTable();
    });
    </script>
</body>
</html>
