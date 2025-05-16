package com.espe.sistemaregistroforestal.controller;

import com.espe.sistemaregistroforestal.dao.ConnectionBdd; // Asegúrate que esta clase de conexión exista y funcione
import com.espe.sistemaregistroforestal.model.ConservationActivities; // Si la usas para el reporte de actividades
import com.espe.sistemaregistroforestal.model.Zones; // Para el filtro de zonas
import com.espe.sistemaregistroforestal.dao.ZonesDAO; // Para obtener la lista de zonas

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Date; // Para fechas
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/reportes")
public class ReportesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ZonesDAO zonesDAO; // Para obtener la lista de zonas para el filtro

    @Override
    public void init() throws ServletException {
        zonesDAO = new ZonesDAO(); // Inicializa tu ZonesDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String zonaIdParamActividades = request.getParameter("zonaId_filter_actividades");

        try (Connection conn = ConnectionBdd.getConexion()) {
            
            List<Zones> todasLasZonas = ZonesDAO.obtenerTodos(); // CORRECCIÓN: Usar el método existente
            request.setAttribute("zonasParaFiltro", todasLasZonas);
            if (zonaIdParamActividades != null && !zonaIdParamActividades.isEmpty()) {
                 request.setAttribute("selectedZonaIdActividades", Integer.parseInt(zonaIdParamActividades));
            }

            // Reporte: Actividades de Conservación por Zona (Dinámico)
            if ("ver_actividades_por_zona".equals(action) && zonaIdParamActividades != null && !zonaIdParamActividades.isEmpty()) {
                int zonaId = Integer.parseInt(zonaIdParamActividades);
                List<ConservationActivities> actividadesPorZona = getActividadesPorZonaId(conn, zonaId);
                request.setAttribute("actividadesPorZonaReporte", actividadesPorZona);
                request.setAttribute("zonaSeleccionadaNombre", obtenerNombreZona(conn, zonaId));
            }

            // Reporte: Especies por Zona (Consulta Fija como ejemplo)
            List<Map<String, Object>> especiesPorZonaFijo = getGenericReportData(conn, "especiesPorZonaSimple");
            request.setAttribute("reporteEspeciesZonaFijo", especiesPorZonaFijo);
            
            // NUEVO Reporte 1: Conteo de Especies por Estado de Conservación (Tabla)
            List<Map<String, Object>> conteoEspeciesEstado = getConteoEspeciesPorEstadoConservacion(conn);
            request.setAttribute("reporteConteoEspeciesEstado", conteoEspeciesEstado);

            // NUEVO Reporte 2: Zonas con Área y Conteo de Especies
            List<Map<String, Object>> zonasConDetalles = getZonasConAreaYConteoEspecies(conn);
            request.setAttribute("reporteZonasConDetalles", zonasConDetalles);

            // Datos para el gráfico de estado de conservación (si aún lo usas y no lo obtienes de conteoEspeciesEstado)
            // Map<String, Integer> conservationCounts = getConservationStatusCountsForChart(conn); // Método adaptado
            // ... (código para preparar labels y data para el chart) ...
            // request.setAttribute("conservationLabelsJson", conservationLabelsJson);
            // request.setAttribute("conservationDataJson", conservationDataJson);


        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error de base de datos al generar reportes: " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error en el formato del ID de zona.");
        }

        request.getRequestDispatcher("/Reportes.jsp").forward(request, response);
    }

    // Método para obtener el nombre de una zona (puedes moverlo a ZonesDAO si prefieres)
    private String obtenerNombreZona(Connection conn, int zonaId) throws SQLException {
        String sql = "SELECT nombre FROM zones WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, zonaId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("nombre");
                }
            }
        }
        return "Desconocida";
    }


    // Método para obtener actividades (reutilizando tu modelo ConservationActivities)
    private List<ConservationActivities> getActividadesPorZonaId(Connection conn, int zonaId) throws SQLException {
        List<ConservationActivities> actividades = new ArrayList<>();
        String sql = "SELECT id, nombre_actividad, fecha_actividad, responsable, tipo_actividad, descripcion, zona_id, activo " +
                     "FROM conservation_activities " +
                     "WHERE zona_id = ? AND activo = TRUE";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, zonaId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ConservationActivities actividad = new ConservationActivities();
                actividad.setId(rs.getInt("id"));
                actividad.setNombreActividad(rs.getString("nombre_actividad"));
                Date fechaSql = rs.getDate("fecha_actividad");
                if (fechaSql != null) {
                    actividad.setFechaActividad(fechaSql.toLocalDate());
                }
                actividad.setResponsable(rs.getString("responsable"));
                // Asumiendo que tipo_actividad es un String en el modelo o tienes un setter adecuado
                // Si es un Enum, necesitas convertirlo. Ejemplo:
                // actividad.setTipoActividad(TipoActividad.valueOf(rs.getString("tipo_actividad").toUpperCase()));
                // Por ahora, si es un String en el modelo:
                // actividad.setTipoActividad(rs.getString("tipo_actividad"));
                // O si tienes un campo específico para el valor de la BD y otro para el Enum:
                // actividad.setTipoActividadDbValue(rs.getString("tipo_actividad"));
                // Para este ejemplo, asumiré que tienes un setter que toma String para tipo_actividad
                // o que lo manejas dentro del modelo. Si no, ajusta esta línea.
                // Si tu modelo ConservationActivities tiene un campo tipoActividad de tipo String:
                // actividad.setTipoActividad(rs.getString("tipo_actividad"));
                // Si es un Enum TipoActividad:
                // String tipoStr = rs.getString("tipo_actividad");
                // if (tipoStr != null) actividad.setTipoActividad(TipoActividad.valueOf(tipoStr.toUpperCase()));

                actividad.setDescripcion(rs.getString("descripcion"));
                actividad.setZonaId(rs.getInt("zona_id"));
                actividad.setActivo(rs.getBoolean("activo"));
                actividades.add(actividad);
            }
        }
        return actividades;
    }

    // Método genérico para otros reportes que devuelven List<Map<String, Object>>
    private List<Map<String, Object>> getGenericReportData(Connection conn, String reportIdentifier) throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = null;

        if ("especiesPorZonaSimple".equals(reportIdentifier)) {
            sql = "SELECT z.nombre AS \"Zona\", ts.nombre_comun AS \"Nombre Común\", ts.nombre_cientifico AS \"Nombre Científico\" " +
                  "FROM tree_species ts " +
                  "JOIN zones z ON ts.zona_id = z.id " + // Asume tree_species.zona_id
                  "ORDER BY z.nombre, ts.nombre_comun";
        }
        // Agrega más 'else if' para otros reportes
        // else if ("otroReporte".equals(reportIdentifier)) { sql = "SELECT ..."; }


        if (sql == null) return results; // Identificador no reconocido

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                for (int i = 1; i <= columnCount; i++) {
                    row.put(metaData.getColumnLabel(i), rs.getObject(i));
                }
                results.add(row);
            }
        }
        return results;
    }

    // NUEVO Método para Reporte 1: Conteo de Especies por Estado de Conservación
    private List<Map<String, Object>> getConteoEspeciesPorEstadoConservacion(Connection conn) throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = "SELECT estado_conservacion AS \"Estado de Conservación\", COUNT(*) AS \"Número de Especies\" " +
                     "FROM tree_species " +
                     "GROUP BY estado_conservacion " +
                     "ORDER BY CASE estado_conservacion " +
                     "    WHEN 'Extinto' THEN 1 " +
                     "    WHEN 'En Peligro Crítico' THEN 2 " +
                     "    WHEN 'En Peligro' THEN 3 " +
                     "    WHEN 'Vulnerable' THEN 4 " +
                     "    WHEN 'Preocupación Menor' THEN 5 " +
                     "    WHEN 'No Evaluado' THEN 6 " +
                     "    ELSE 7 END, estado_conservacion"; // Orden personalizado

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                for (int i = 1; i <= columnCount; i++) {
                    row.put(metaData.getColumnLabel(i), rs.getObject(i));
                }
                results.add(row);
            }
        }
        return results;
    }

    // NUEVO Método para Reporte 2: Zonas con Área y Conteo de Especies
    private List<Map<String, Object>> getZonasConAreaYConteoEspecies(Connection conn) throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        // Esta consulta asume que tienes una tabla 'zone_species' para la relación muchos-a-muchos
        // o que 'tree_species' tiene un 'zona_id' para una relación uno-a-muchos.
        // Ejemplo con 'tree_species.zona_id':
        String sql = "SELECT z.nombre AS \"Nombre Zona\", z.tipo_bosque AS \"Tipo de Bosque\", " +
                     "z.area_ha AS \"Área (ha)\", COUNT(ts.id) AS \"Número de Especies\" " +
                     "FROM zones z " +
                     "LEFT JOIN tree_species ts ON z.id = ts.zona_id " + // Asume que tree_species tiene zona_id
                     "GROUP BY z.id, z.nombre, z.tipo_bosque, z.area_ha " +
                     "ORDER BY z.nombre";
        
        // Si usaras una tabla 'zone_species' para muchos-a-muchos:
        /*
        String sql = "SELECT z.nombre AS \"Nombre Zona\", z.tipo_bosque AS \"Tipo de Bosque\", " +
                     "z.area_ha AS \"Área (ha)\", COUNT(zs.especie_id) AS \"Número de Especies\" " +
                     "FROM zones z " +
                     "LEFT JOIN zone_species zs ON z.id = zs.zona_id " +
                     "GROUP BY z.id, z.nombre, z.tipo_bosque, z.area_ha " +
                     "ORDER BY z.nombre";
        */

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                for (int i = 1; i <= columnCount; i++) {
                    // Formatear BigDecimal para el área si es necesario aquí o en el JSP
                    if ("Área (ha)".equals(metaData.getColumnLabel(i)) && rs.getObject(i) != null) {
                         row.put(metaData.getColumnLabel(i), String.format("%.2f", rs.getBigDecimal(i)));
                    } else {
                        row.put(metaData.getColumnLabel(i), rs.getObject(i));
                    }
                }
                results.add(row);
            }
        }
        return results;
    }

    // Si necesitas los datos para el ChartJS por separado y de forma específica:
    /*
    private Map<String, Integer> getConservationStatusCountsForChart(Connection conn) throws SQLException {
        Map<String, Integer> counts = new LinkedHashMap<>();
        String[] allStates = {"No Evaluado", "Preocupación Menor", "Vulnerable", "En Peligro", "En Peligro Crítico", "Extinto"};
        for (String state : allStates) {
            counts.put(state, 0);
        }
        String sql = "SELECT estado_conservacion, COUNT(*) as count FROM tree_species GROUP BY estado_conservacion";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String estado = rs.getString("estado_conservacion");
                if (estado != null && !estado.trim().isEmpty() && counts.containsKey(estado)) {
                    counts.put(estado, rs.getInt("count"));
                } else if (estado == null || estado.trim().isEmpty()) {
                    counts.put("No Evaluado", counts.getOrDefault("No Evaluado", 0) + rs.getInt("count"));
                }
            }
        }
        return counts;
    }
    */
}