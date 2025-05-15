<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.espe.sistemaregistroforestal.model.ConservationActivities" %>

<%
    List<ConservationActivities> actividades = (List<ConservationActivities>) request.getAttribute("listaActividades");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Actividades de Conservación</title>
</head>
<body>
    <h1>Listado de Actividades de Conservación</h1>
    <a href="ConservationActivities?option=new">Agregar Nueva Actividad</a>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre Actividad</th>
            <th>Fecha</th>
            <th>Responsable</th>
            <th>Tipo Actividad</th>
            <th>Descripción</th>
            <th>Acciones</th>
        </tr>
        <%
            for (ConservationActivities actividad : actividades) {
        %>
        <tr>
            <td><%= actividad.getId() %></td>
            <td><%= actividad.getNombreActividad() %></td>
            <td><%= actividad.getFechaActividad() %></td>
            <td><%= actividad.getResponsable() %></td>
            <td><%= actividad.getTipoActividad() %></td>
            <td><%= actividad.getDescripcion() %></td>
            <td>
                <a href="ConservationActivities?option=update&id=<%= actividad.getId() %>">Editar</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
