package com.espe.sistemaregistroforestal.controller;

import com.espe.sistemaregistroforestal.dao.ConnectionBdd;
import com.espe.sistemaregistroforestal.model.ConservationActivities;
import com.espe.sistemaregistroforestal.model.Zones;
import com.espe.sistemaregistroforestal.dao.ZonesDAO;
import com.espe.sistemaregistroforestal.model.TipoActividad;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Date;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/reportes")
public class ReportesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String zonaIdParamActividades = request.getParameter("zonaId_filter_actividades");

        try (Connection conn = ConnectionBdd.getConexion()) {

            List<Zones> todasLasZonas = ZonesDAO.obtenerTodos();
            if (todasLasZonas == null || todasLasZonas.isEmpty()) {
                todasLasZonas = new ArrayList<>();
                Zones testZona = new Zones();
                testZona.setId(999);
                testZona.setNombre("ZONA DE PRUEBA");
                todasLasZonas.add(testZona);
            }
            request.setAttribute("zonasParaFiltro", todasLasZonas);

            if (zonaIdParamActividades != null && !zonaIdParamActividades.isEmpty()) {
                int zonaId = Integer.parseInt(zonaIdParamActividades);
                request.setAttribute("selectedZonaIdActividades", zonaId);

                if ("ver_actividades_por_zona".equals(action)) {
                    List<ConservationActivities> actividades = getActividadesPorZonaId(conn, zonaId);
                    request.setAttribute("actividadesPorZonaReporte", actividades);
                    request.setAttribute("zonaSeleccionadaNombre", obtenerNombreZona(conn, zonaId));
                }
            }

            request.setAttribute("reporteEspeciesZonaFijo", getGenericReportData(conn, "especiesPorZonaSimple"));
            request.setAttribute("reporteConteoEspeciesEstado", getConteoEspeciesPorEstadoConservacion(conn));
            request.setAttribute("reporteZonasConDetalles", getZonasConAreaYConteoEspecies(conn));

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }

        request.getRequestDispatcher("/Reportes.jsp").forward(request, response);
    }

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

    private List<ConservationActivities> getActividadesPorZonaId(Connection conn, int zonaId) throws SQLException {
        List<ConservationActivities> actividades = new ArrayList<>();
        String sql = "SELECT id, nombre_actividad, fecha_actividad, responsable, tipo_actividad, descripcion, zona_id, activo " +
                     "FROM conservation_activities WHERE zona_id = ? AND activo = TRUE";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, zonaId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ConservationActivities actividad = new ConservationActivities();
                    actividad.setId(rs.getInt("id"));
                    actividad.setNombreActividad(rs.getString("nombre_actividad"));
                    Date fechaSql = rs.getDate("fecha_actividad");
                    if (fechaSql != null) actividad.setFechaActividad(fechaSql.toLocalDate());
                    actividad.setResponsable(rs.getString("responsable"));
                    actividad.setTipoActividad(TipoActividad.fromString(rs.getString("tipo_actividad")));
                    actividad.setDescripcion(rs.getString("descripcion"));
                    actividad.setZonaId(rs.getInt("zona_id"));
                    actividad.setActivo(rs.getBoolean("activo"));
                    actividades.add(actividad);
                }
            }
        }
        return actividades;
    }

    private List<Map<String, Object>> getGenericReportData(Connection conn, String reportIdentifier) throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = null;

        if ("especiesPorZonaSimple".equals(reportIdentifier)) {
            sql = "SELECT z.nombre AS \"Zona\", ts.nombre_comun AS \"Nombre Común\", ts.nombre_cientifico AS \"Nombre Científico\" " +
                  "FROM tree_species ts JOIN zones z ON ts.zona_id = z.id ORDER BY z.nombre, ts.nombre_comun";
        }

        if (sql == null) return results;

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            ResultSetMetaData md = rs.getMetaData();
            int cols = md.getColumnCount();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                for (int i = 1; i <= cols; i++) {
                    row.put(md.getColumnLabel(i), rs.getObject(i));
                }
                results.add(row);
            }
        }
        return results;
    }

    private List<Map<String, Object>> getConteoEspeciesPorEstadoConservacion(Connection conn) throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = "SELECT estado_conservacion AS \"Estado de Conservación\", COUNT(*) AS \"Número de Especies\" " +
                     "FROM tree_species GROUP BY estado_conservacion ORDER BY CASE estado_conservacion " +
                     "WHEN 'Extinto' THEN 1 WHEN 'En Peligro Crítico' THEN 2 WHEN 'En Peligro' THEN 3 " +
                     "WHEN 'Vulnerable' THEN 4 WHEN 'Preocupación Menor' THEN 5 WHEN 'No Evaluado' THEN 6 ELSE 7 END";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            ResultSetMetaData md = rs.getMetaData();
            int cols = md.getColumnCount();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                for (int i = 1; i <= cols; i++) {
                    row.put(md.getColumnLabel(i), rs.getObject(i));
                }
                results.add(row);
            }
        }
        return results;
    }

    private List<Map<String, Object>> getZonasConAreaYConteoEspecies(Connection conn) throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = "SELECT z.nombre AS \"Nombre Zona\", z.tipo_bosque AS \"Tipo de Bosque\", " +
                     "z.area_ha AS \"Área (ha)\", COUNT(ts.id) AS \"Número de Especies\" " +
                     "FROM zones z LEFT JOIN tree_species ts ON z.id = ts.zona_id " +
                     "GROUP BY z.id, z.nombre, z.tipo_bosque, z.area_ha ORDER BY z.nombre";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            ResultSetMetaData md = rs.getMetaData();
            int cols = md.getColumnCount();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                for (int i = 1; i <= cols; i++) {
                    if ("Área (ha)".equals(md.getColumnLabel(i)) && rs.getObject(i) != null) {
                        row.put(md.getColumnLabel(i), String.format("%.2f", rs.getBigDecimal(i)));
                    } else {
                        row.put(md.getColumnLabel(i), rs.getObject(i));
                    }
                }
                results.add(row);
            }
        }
        return results;
    }
}
