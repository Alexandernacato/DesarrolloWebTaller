<%@ include file="menu.jsp" %> <!-- Incluye el menú principal -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Zonas</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/2.3.0/css/dataTables.bootstrap5.css" rel="stylesheet">
    <style>
    .container {
        margin-left: 250px; /* Puedes ajustar a lo que mida tu sidebar */
        transition: margin-left 0.3s ease;
    }

    @media (max-width: 768px) {
        .container {
            margin-left: 0;
        }
    }
</style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Lista de Zonas</h2>
        <a href="${pageContext.request.contextPath}/zones?option=new" class="btn btn-primary mb-3" id="abrirModal">Agregar Nueva Zona</a>
        
        <table id="zonesTable" class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Ubicación</th>
                    <th>Provincia</th>
                    <th>Tipo Bosque</th>
                    <th>Área (ha)</th>
                    <th>Descripción</th>
                    <th>Fecha Registro</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="zone" items="${zonesList}">
                    <tr>
                        <td><c:out value="${zone.id}"/></td>
                        <td><c:out value="${zone.nombre}"/></td>
                        <td><c:out value="${zone.ubicacion}"/></td>
                        <td><c:out value="${zone.provincia}"/></td>
                        <td><c:out value="${zone.tipo_bosque.displayName}"/></td>
                        <td><c:out value="${zone.area_ha}"/></td>
                        <td><c:out value="${zone.descripcion}"/></td>
                        <td><fmt:formatDate value="${zone.fecha_registro}" pattern="dd/MM/yyyy"/></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/zones?option=update&id=${zone.id}" class="btn btn-warning btn-sm" id="editar_${zone.id}">Editar</a> |
                            <a href="${pageContext.request.contextPath}/zones?option=delete&id=${zone.id}" class="btn btn-danger btn-sm" onclick="return confirm('¿Está seguro de eliminar esta zona?')">Eliminar</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <!-- Modal para formulario -->
    <div class="modal fade" id="modalFormulario" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" id="contenidoModal">
                <!-- El contenido se cargará aquí -->
            </div>
        </div>
    </div>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    
    <!-- Bootstrap JS (con Popper) -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
    
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.js"></script>
    
    <!-- DataTables Bootstrap JS -->
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.bootstrap5.js"></script>
    
    <!-- Script para abrir el modal -->
    <script>
    $(document).ready(function(){
        // Capturar el clic en el enlace "Agregar Nueva Zona"
        $('#abrirModal').click(function(e){
            e.preventDefault();  // Prevenir la recarga de la página
            
            var url = $(this).attr('href'); // Obtener la URL del enlace
            
            // Usar jQuery para cargar el contenido del formulario en el modal
            $('#contenidoModal').load(url, function(){
                $('#modalFormulario').modal('show'); // Mostrar el modal
            });
        });
        
        // Capturar el clic en los enlaces "Editar"
        $('[id^="editar_"]').click(function(e){
            e.preventDefault();  // Prevenir la recarga de la página
            
            var url = $(this).attr('href'); // Obtener la URL del enlace
            
            // Usar jQuery para cargar el contenido del formulario en el modal
            $('#contenidoModal').load(url, function(){
                $('#modalFormulario').modal('show'); // Mostrar el modal
            });
        });
    });
    </script>
    
    <!-- Script para DataTables -->
    <script>
        $(document).ready(function() {
            $('#zonesTable').DataTable();  // Aplicar DataTables a la tabla
        });
    </script>
    
    <!-- Script para manejar el envío del formulario del modal -->
    <script>
    $(document).ready(function() {
        // Delegación de eventos para capturar el envío del formulario dentro del modal
        $(document).on('submit', '#modalFormulario form', function(e) {
            e.preventDefault();
            
            // Registrar en consola para depuración
            console.log("Enviando formulario...");
            
            // Obtener datos del formulario
            var formData = $(this).serialize();
            console.log("Datos: ", formData);
            
            // Agregar el parámetro option=save si no está presente
            if (!formData.includes('option=')) {
                formData += '&option=save';
            }
            
            // Enviar formulario mediante AJAX
            $.ajax({
                url: "${pageContext.request.contextPath}/zones",
                type: "POST",
                data: formData,
                success: function(response) {
                    console.log("Éxito al guardar");
                    // Cerrar el modal
                    $('#modalFormulario').modal('hide');
                    // Recargar la página para ver los cambios
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error("Error al guardar: ", error);
                    alert("Error al guardar los datos. Por favor, intenta nuevamente.");
                }
            });
        });
    });
    </script>
</body>
</html>
