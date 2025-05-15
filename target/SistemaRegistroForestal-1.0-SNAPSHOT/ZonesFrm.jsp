
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
    <form action="${pageContext.request.contextPath}/zones" method="post">
        <%-- El campo ID se maneja mejor si es 0 para nuevo, o el ID existente para editar --%>
        <input type="hidden" name="id" value="${empty zone.id ? 0 : zone.id}">
        
        <label for="nombre">Nombre:</label><br>
        <input type="text" id="nombre" name="nombre" value="<c:out value='${zone.nombre}'/>" required><br><br>
        
        <label for="ubicacion">Ubicación:</label><br>
        <input type="text" id="ubicacion" name="ubicacion" value="<c:out value='${zone.ubicacion}'/>" required><br><br>
        
        <label for="provincia">Provincia:</label><br>
        <input type="text" id="provincia" name="provincia" value="<c:out value='${zone.provincia}'/>"><br><br>
        
        <label for="tipo_bosque">Tipo de Bosque:</label><br>
        <select id="tipo_bosque" name="tipo_bosque">
            <%-- Iterar sobre los valores del Enum pasados desde el Controller --%>
            <c:forEach var="tipo" items="${tiposBosque}">
                <option value="${tipo.displayName}" ${zone.tipo_bosque == tipo ? 'selected' : ''}>
                    <c:out value="${tipo.displayName}"/>
                </option>
            </c:forEach>
        </select><br><br>
        
        <label for="area_ha">Área (ha):</label><br>
        <input type="number" step="0.01" id="area_ha" name="area_ha" value="<c:out value='${zone.area_ha}'/>" required><br><br>
        
        <label for="descripcion">Descripción:</label><br>
        <textarea id="descripcion" name="descripcion"><c:out value='${zone.descripcion}'/></textarea><br><br>
        
        <label for="fecha_registro">Fecha Registro:</label><br>
        <%-- Formatear la fecha para el input type="date" --%>
        <fmt:formatDate value="${zone.fecha_registro}" pattern="yyyy-MM-dd" var="formattedFechaRegistro"/>
        <input type="date" id="fecha_registro" name="fecha_registro" value="${formattedFechaRegistro}"><br><br>
        
        <input type="submit" value="${empty zone.id || zone.id == 0 ? 'Guardar' : 'Actualizar'}">
        <a href="${pageContext.request.contextPath}/zones?action=list">Cancelar</a>
    </form>
</body>
</html>
