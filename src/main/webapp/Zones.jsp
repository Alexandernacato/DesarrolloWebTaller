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
    
 
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    
 
    <link href="https://cdn.datatables.net/2.3.0/css/dataTables.bootstrap5.css" rel="stylesheet">
    <style>
    .container {
        margin-left: 250px; 
        transition: margin-left 0.3s ease;
        margin-left: auto !important;
        margin-right: auto !important;
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
    

    <div class="modal fade" id="modalFormulario" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content" id="contenidoModal">
            
            </div>
        </div>
    </div>
    
  
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    
 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
    

    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.js"></script>
    
   
    <script src="https://cdn.datatables.net/2.3.0/js/dataTables.bootstrap5.js"></script>
    
  
    <script>
    $(document).ready(function(){
        
        $('#abrirModal').click(function(e){
            e.preventDefault();  
            
            var url = $(this).attr('href'); 
            
           
            $('#contenidoModal').load(url, function(){
                $('#modalFormulario').modal('show'); 
            });
        });
        
      
        $('[id^="editar_"]').click(function(e){
            e.preventDefault();  
            
            var url = $(this).attr('href'); 
            
           
            $('#contenidoModal').load(url, function(){
                $('#modalFormulario').modal('show'); 
            });
        });
    });
    </script>
    
  
    <script>
        $(document).ready(function() {
            $('#zonesTable').DataTable();  
        });
    </script>
    
   
    <script>
    $(document).ready(function() {
       
        $(document).on('submit', '#modalFormulario form', function(e) {
            e.preventDefault();
            
            
            console.log("Enviando formulario...");
            
          
            var formData = $(this).serialize();
            console.log("Datos: ", formData);
            
       
            if (!formData.includes('option=')) {
                formData += '&option=save';
            }
            
          
            $.ajax({
                url: "${pageContext.request.contextPath}/zones",
                type: "POST",
                data: formData,
                success: function(response) {
                    console.log("Éxito al guardar");
                  
                    $('#modalFormulario').modal('hide');
                  
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
