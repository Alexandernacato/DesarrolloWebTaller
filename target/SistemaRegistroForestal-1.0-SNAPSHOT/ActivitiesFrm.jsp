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

<!-- Modal header -->
<div class="modal-header">
    <h5 class="modal-title"><%= actividad == null ? "Agregar Nueva" : "Editar" %> Actividad de Conservación</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
</div>

<!-- Formulario dentro del cuerpo del modal -->
<form action="ConservationActivities" method="POST">
    <div class="modal-body">
        <input type="hidden" name="id" value="<%= actividad != null ? actividad.getId() : "" %>">

        <div class="mb-3">
            <label for="nombreActividad" class="form-label">Nombre de la Actividad:</label>
            <input type="text" id="nombreActividad" name="nombreActividad" 
                   class="form-control"
                   value="<%= actividad != null ? actividad.getNombreActividad() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="fechaActividad" class="form-label">Fecha:</label>
            <input type="date" id="fechaActividad" name="fechaActividad" 
                   class="form-control"
                   value="<%= actividad != null ? actividad.getFechaActividad() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="responsable" class="form-label">Responsable:</label>
            <input type="text" id="responsable" name="responsable" 
                   class="form-control"
                   value="<%= actividad != null ? actividad.getResponsable() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="tipoActividad" class="form-label">Tipo de Actividad:</label>
            <select id="tipoActividad" name="tipoActividad" class="form-select">
                <option value="REFORESTACION" <%= actividad != null && actividad.getTipoActividad().toString().equals("REFORESTACION") ? "selected" : "" %>>Reforestación</option>
                <option value="MANTENIMIENTO" <%= actividad != null && actividad.getTipoActividad().toString().equals("MANTENIMIENTO") ? "selected" : "" %>>Mantenimiento</option>
                <option value="MONITOREO" <%= actividad != null && actividad.getTipoActividad().toString().equals("MONITOREO") ? "selected" : "" %>>Monitoreo</option>
                <option value="OTRO" <%= actividad != null && actividad.getTipoActividad().toString().equals("OTRO") ? "selected" : "" %>>Otro</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción:</label>
            <textarea id="descripcion" name="descripcion" class="form-control" rows="3" required><%= actividad != null ? actividad.getDescripcion() : "" %></textarea>
        </div>

        <div class="mb-3">
            <label for="zonaId" class="form-label">Zona ID:</label>
            <input type="number" id="zonaId" name="zonaId" 
                   class="form-control"
                   value="<%= actividad != null ? actividad.getZonaId() : "" %>" required>
        </div>
    </div>

    <!-- Modal footer -->
    <div class="modal-footer">
        <a href="ConservationActivities?option=findAll" class="btn btn-secondary">Volver al listado</a>
        <button type="submit" class="btn btn-primary"><%= actividad == null ? "Agregar" : "Actualizar" %></button>
    </div>
</form>
 <script src="${pageContext.request.contextPath}/JS/validacion.js"></script>