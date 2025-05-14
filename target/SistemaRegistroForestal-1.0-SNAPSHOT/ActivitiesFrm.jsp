<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.espe.sistemaregistroforestal.model.ConservationActivities" %>
<%@ page import="com.espe.sistemaregistroforestal.service.ConservativonActivitiesService" %>
<%@ page import="com.espe.sistemaregistroforestal.model.TipoActividad" %>

<%
    String idParam = request.getParameter("id");
    ConservationActivities actividad = null;
    if (idParam != null) {
        int id = Integer.parseInt(idParam);
        ConservativonActivitiesService service = new ConservativonActivitiesService();
        actividad = service.obtenerPorId(id);
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= actividad == null ? "Agregar Nueva" : "Editar" %> Actividad de Conservación</title>
</head>
<body>
    <h1><%= actividad == null ? "Agregar Nueva" : "Editar" %> Actividad de Conservación</h1>
    <form action="ConservationActivities" method="POST">
        <input type="hidden" name="id" value="<%= actividad != null ? actividad.getId() : "" %>">
        
        <label for="nombreActividad">Nombre de la Actividad:</label>
        <input type="text" id="nombreActividad" name="nombreActividad" 
               value="<%= actividad != null ? actividad.getNombreActividad() : "" %>" required>
        <br><br>

        <label for="fechaActividad">Fecha:</label>
        <input type="date" id="fechaActividad" name="fechaActividad" 
               value="<%= actividad != null ? actividad.getFechaActividad() : "" %>" required>
        <br><br>

        <label for="responsable">Responsable:</label>
        <input type="text" id="responsable" name="responsable" 
               value="<%= actividad != null ? actividad.getResponsable() : "" %>" required>
        <br><br>

        <label for="tipoActividad">Tipo de Actividad:</label>
        <select id="tipoActividad" name="tipoActividad">
            <option value="REFORESTACION" <%= actividad != null && actividad.getTipoActividad().toString().equals("REFORESTACION") ? "selected" : "" %>>Reforestación</option>
            <option value="MANTENIMIENTO" <%= actividad != null && actividad.getTipoActividad().toString().equals("MANTENIMIENTO") ? "selected" : "" %>>Mantenimiento</option>
            <option value="MONITOREO" <%= actividad != null && actividad.getTipoActividad().toString().equals("MONITOREO") ? "selected" : "" %>>Monitoreo</option>
            <option value="OTRO" <%= actividad != null && actividad.getTipoActividad().toString().equals("OTRO") ? "selected" : "" %>>Otro</option>
        </select>
        <br><br>

        <label for="descripcion">Descripción:</label>
        <textarea id="descripcion" name="descripcion" required><%= actividad != null ? actividad.getDescripcion() : "" %></textarea>
        <br><br>

        <label for="zonaId">Zona ID:</label>
        <input type="number" id="zonaId" name="zonaId" 
               value="<%= actividad != null ? actividad.getZonaId() : "" %>" required>
        <br><br>

        <input type="submit" value="<%= actividad == null ? "Agregar" : "Actualizar" %>">
    </form>
    <br>
    <a href="ConservationActivities?option=findAll">Volver al listado</a>
</body>
</html>
