
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="modal-header">
    <h5 class="modal-title">${treeSpecies != null ? "Editar Especie" : "Nueva Especie"}</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
</div>


<form action="${pageContext.request.contextPath}/TreeSpecies" method="post">
    <div class="modal-body">
        <c:if test="${treeSpecies != null}">
            <input type="hidden" name="id" value="${treeSpecies.id}" />
        </c:if>

        <div class="mb-3">
            <label class="form-label">Nombre Común:</label>
            <input type="text" class="form-control" name="nombreComun" value="${treeSpecies != null ? treeSpecies.nombreComun : ''}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Nombre Científico:</label>
            <input type="text" class="form-control" name="nombreCientifico" value="${treeSpecies != null ? treeSpecies.nombreCientifico : ''}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Familia Botánica:</label>
            <input type="text" class="form-control" name="familiaBotanica" value="${treeSpecies != null ? treeSpecies.familiaBotanica : ''}" required />
        </div>

        <div class="mb-3">
            <label class="form-label" for="estadoConservacion">Estado de Conservación</label>
            <select name="estadoConservacion" id="estadoConservacion" class="form-select">
                <option value="No Evaluado">No Evaluado</option>
                <option value="Preocupación Menor">Preocupación Menor</option>
                <option value="Vulnerable">Vulnerable</option>
                <option value="En Peligro">En Peligro</option>
                <option value="En Peligro Crítico">En Peligro Crítico</option>
                <option value="Extinto">Extinto</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Uso Principal:</label>
            <input type="text" class="form-control" name="usoPrincipal" value="${treeSpecies != null ? treeSpecies.usoPrincipal : ''}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Altura Máxima (m):</label>
            <input type="number" step="0.1" class="form-control" name="alturaMaximaM" value="${treeSpecies != null ? treeSpecies.alturaMaximaM : ''}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">ID de Zona:</label>
            <input type="number" class="form-control" name="zonaId" value="${treeSpecies != null ? treeSpecies.zonaId : ''}" required />
        </div>
    </div>


    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-primary">Guardar</button>
    </div>
    
</form>
 <script src="${pageContext.request.contextPath}/JS/validacion.js"></script>