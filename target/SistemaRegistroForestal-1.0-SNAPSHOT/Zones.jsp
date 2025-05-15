<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Zonas</title>
</head>
<body>
    <h1>Lista de Zonas</h1>
    <p><a href="${pageContext.request.contextPath}/zones?option=new">Agregar Nueva Zona</a></p>
    <table border="1">
        <thead>
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
                    <td><c:out value="${zone.tipo_bosque.displayName}"/></td> <%-- MODIFICADO --%>
                    <td><c:out value="${zone.area_ha}"/></td>
                    <td><c:out value="${zone.descripcion}"/></td>
                    <td><fmt:formatDate value="${zone.fecha_registro}" pattern="dd/MM/yyyy"/></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/zones?option=edit&id=${zone.id}">Editar</a>
                        <a href="${pageContext.request.contextPath}/zones?option=delete&id=${zone.id}" onclick="return confirm('¿Está seguro de eliminar esta zona?');">Eliminar</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
