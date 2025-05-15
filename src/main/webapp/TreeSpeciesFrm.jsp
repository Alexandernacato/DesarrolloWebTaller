<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty zone.id || zone.id == 0 ? 'Agregar' : 'Editar'} Zona</title>
</head>
<body>
    <h1>${empty zone.id || zone.id == 0 ? 'Agregar Nueva Zona' : 'Editar Zona'}</h1>

    <form action="${pageContext.request.contextPath}/zones" method="post">
        <!-- Campo ID (oculto) -->
        <input type="hidden" name="id" value="${empty zone.id ? 0 : zone.id}">

        <!-- Nombre -->
        <label for="nombre">Nombre:</label><br>
        <input type="text" id="nombre" name="nombre" value="${zone.nombre}" required><br><br>

        <!-- Ubicación -->
        <label for="ubicacion">Ubicación:</label><br>
        <input type="text" id="ubicacion" name="ubicacion" value="${zone.ubicacion}" required><br><br>

        <!-- Provincia -->
        <label for="provincia">Provincia:</label><br>
        <input type="text" id="provincia" name="provincia" value="${zone.provincia}"><br><br>

        <!-- Tipo de Bosque -->
        <label for="tipo_bosque">Tipo de Bosque:</label><br>
        <select id="tipo_bosque" name="tipo_bosque" required>
            <c:forEach var="tipo" items="${tiposBosque}">
                <option value="${tipo.name()}" ${zone.tipo_bosque.name() == tipo.name() ? 'selected' : ''}>
                    <c:out value="${tipo.displayName}"/>
                </option>
            </c:forEach>
        </select><br><br>

        <!-- Área en hectáreas -->
        <label for="area_ha">Área (ha):</label><br>
        <input type="number" step="0.01" id="area_ha" name="area_ha" value="${zone.area_ha}" required><br><br>

        <!-- Descripción -->
        <label for="descripcion">Descripción:</label><br>
        <textarea id="descripcion" name="descripcion" rows="4" cols="50">${zone.descripcion}</textarea><br><br>

        <!-- Fecha de Registro -->
        <label for="fecha_registro">Fecha Registro:</label><br>
        <fmt:formatDate value="${zone.fecha_registro}" pattern="yyyy-MM-dd" var="formattedFechaRegistro"/>
        <input type="date" id="fecha_registro" name="fecha_registro" value="${formattedFechaRegistro}"><br><br>

        <!-- Botones -->
        <input type="submit" value="${empty zone.id || zone.id == 0 ? 'Guardar' : 'Actualizar'}">
        <a href="${pageContext.request.contextPath}/zones">Cancelar</a>
    </form>
</body>
</html>
