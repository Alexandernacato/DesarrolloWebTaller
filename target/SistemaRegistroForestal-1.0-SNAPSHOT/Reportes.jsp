<%-- ... (código JSP existente, incluyendo el filtro de actividades y su tabla, y el reporte de especies por zona fijo) ... --%>

        <!-- NUEVO Reporte 1: Conteo de Especies por Estado de Conservación (Tabla) -->
        <div class="card mt-4">
            <div class="card-header"><i class="fas fa-shield-alt"></i> Conteo de Especies por Estado de Conservación</div>
            <div class="card-body">
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${not empty reporteConteoEspeciesEstado}">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <c:forEach var="columnName" items="${reporteConteoEspeciesEstado[0].keySet()}">
                                            <th><c:out value="${columnName}"/></th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${reporteConteoEspeciesEstado}">
                                        <tr>
                                            <c:forEach var="cell" items="${row.values()}">
                                                <td><c:out value="${cell}"/></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center">No hay datos de conteo de especies por estado para mostrar.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- NUEVO Reporte 2: Zonas con Área y Conteo de Especies -->
        <div class="card mt-4">
            <div class="card-header"><i class="fas fa-map-marked-alt"></i> Detalles de Zonas Registradas</div>
            <div class="card-body">
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${not empty reporteZonasConDetalles}">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <c:forEach var="columnName" items="${reporteZonasConDetalles[0].keySet()}">
                                            <th><c:out value="${columnName}"/></th>
                                        </c:forEach>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${reporteZonasConDetalles}">
                                        <tr>
                                            <c:forEach var="cell" items="${row.values()}">
                                                <td><c:out value="${cell}"/></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center">No hay detalles de zonas para mostrar.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <%-- Aquí puedes añadir más secciones para otros reportes --%>
        <%-- No olvides el cierre del div.container.dashboard-container y los scripts --%>
    </div>
    <%-- Tus scripts de Bootstrap, jQuery, DataTables, etc. --%>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
    <%-- Si usas ChartJS para el gráfico de estado de conservación, asegúrate que los datos se pasen correctamente --%>
    <%-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> --%>
    <%-- <script>
        // Lógica para ChartJS si la mantienes
    </script> --%>
</body>
</html>