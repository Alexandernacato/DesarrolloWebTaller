<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
    <title>${empty zone.id || zone.id == 0 ? 'Agregar' : 'Editar'} Zona</title>
</head>
<body>
    <h1>${empty zone.id || zone.id == 0 ? 'Agregar Nueva Zona' : 'Editar Zona'}</h1>
    
    <!-- Encabezado del modal -->
    <div class="modal-header">
        <h5 class="modal-title">${empty zone.id || zone.id == 0 ? 'Nueva Zona' : 'Editar Zona'}</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
    </div>
  
    <!-- Formulario dentro del cuerpo del modal -->
    <form action="${pageContext.request.contextPath}/zones" method="post" id="zonaForm">
        <div class="modal-body">
            <!-- Campo oculto para el ID -->
            <input type="hidden" name="id" value="${empty zone.id ? 0 : zone.id}">
            <!-- Campo oculto para la opción -->
            <input type="hidden" name="option" value="save">
            
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre:</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="<c:out value='${zone.nombre}'/>" required>
            </div>
            
            <div class="mb-3">
                <label for="ubicacion" class="form-label">Ubicación:</label>
                <input type="text" class="form-control" id="ubicacion" name="ubicacion" value="<c:out value='${zone.ubicacion}'/>" required>
            </div>
            
            <div class="mb-3">
                <label for="provincia" class="form-label">Provincia:</label>
                <input type="text" class="form-control" id="provincia" name="provincia" value="<c:out value='${zone.provincia}'/>">
            </div>
            
            <div class="mb-3">
                <label for="tipo_bosque" class="form-label">Tipo de Bosque:</label>
                <select class="form-select" id="tipo_bosque" name="tipo_bosque">
                    <c:forEach var="tipo" items="${tiposBosque}">
                        <option value="${tipo.displayName}" ${zone.tipo_bosque == tipo ? 'selected' : ''}>
                            <c:out value="${tipo.displayName}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="area_ha" class="form-label">Área (ha):</label>
                <input type="number" step="0.01" class="form-control" id="area_ha" name="area_ha" value="<c:out value='${zone.area_ha}'/>" required>
            </div>
            
            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción:</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3"><c:out value='${zone.descripcion}'/></textarea>
            </div>
            
            <div class="mb-3">
                <label for="fecha_registro" class="form-label">Fecha Registro:</label>
                <fmt:formatDate value="${zone.fecha_registro}" pattern="yyyy-MM-dd" var="formattedFechaRegistro"/>
                <input type="date" class="form-control" id="fecha_registro" name="fecha_registro" value="${formattedFechaRegistro}">
            </div>
        </div>
        
        <!-- Pie del modal -->
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary">Guardar</button>
        </div>
        
    </form>
 <script src="${pageContext.request.contextPath}/JS/validacion.js"></script>
</body>
</html>
