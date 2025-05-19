<%@ include file="menu.jsp" %> <!-- Incluye el menú principal -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Especies de Árboles</title>

    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/2.3.0/css/dataTables.bootstrap5.css" rel="stylesheet">
    <style>

    .container {
        margin-left: auto !important; 
        margin-right: auto !important; 
        max-width: 1200px; 
        transition: margin-left 0.3s ease;
        padding: 0 15px; 
    }
    
    
    table#treeSpeciesTable {
        width: 100% !important;
    }
    
  
    table#treeSpeciesTable td:last-child {
        white-space: nowrap;
    }
</style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Lista de Especies de Árboles</h2>
        <div class="text-center mb-3">
            <a href="${pageContext.request.contextPath}/TreeSpecies?option=new" class="btn btn-primary" id="abrirModal">Agregar Nueva Especie</a>
        </div>
       
        <table id="treeSpeciesTable" class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre Común</th>
                    <th>Nombre Científico</th>
                    <th>Familia</th>
                    <th>Estado</th>
                    <th>Uso</th>
                    <th>Altura (m)</th>
                    <th>ID Zona</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="treeSpecies" items="${treeSpeciesList}">
                    <tr>
                        <td>${treeSpecies.id}</td>
                        <td>${treeSpecies.nombreComun}</td>
                        <td>${treeSpecies.nombreCientifico}</td>
                        <td>${treeSpecies.familiaBotanica}</td>
                        <td>${treeSpecies.estadoConservacion}</td>
                        <td>${treeSpecies.usoPrincipal}</td>
                        <td>${treeSpecies.alturaMaximaM}</td>
                        <td>${treeSpecies.zonaId}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/TreeSpecies?option=update&id=${treeSpecies.id}" class="btn btn-warning btn-sm" id="editar_${treeSpecies.id}">Editar</a> 
 |
                            <a href="${pageContext.request.contextPath}/TreeSpecies?option=delete&id=${treeSpecies.id}" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar esta especie?')">Eliminar</a>
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
            $('#treeSpeciesTable').DataTable();  
        });
    </script>
</body>
</html>
