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
        
        String action = request.getParameter("action"); // Para determinar qué reporte mostrar o filtrar
        String zonaIdParam = request.getParameter("zonaId_filter_actividades"); // Parámetro específico para el filtro de actividades

        try (Connection conn = ConnectionBdd.getConexion()) {
            // Cargar siempre la lista de zonas para el selector
            List<Zones> todasLasZonas = zonesDAO.getAllZonesSimple(); // Asume que este método existe en ZonesDAO
            request.setAttribute("zonasParaFiltro", todasLasZonas);
            if (zonaIdParam != null && !zonaIdParam.isEmpty()) {
                 request.setAttribute("selectedZonaIdActividades", Integer.parseInt(zonaIdParam));
            }


            // Reporte 1: Actividades de Conservación por Zona (Dinámico)
            if ("ver_actividades_por_zona".equals(action) && zonaIdParam != null && !zonaIdParam.isEmpty()) {
                int zonaId = Integer.parseInt(zonaIdParam);
                List<ConservationActivities> actividadesPorZona = getActividadesPorZonaId(conn, zonaId);
                request.setAttribute("actividadesPorZonaReporte", actividadesPorZona);
                request.setAttribute("zonaSeleccionadaNombre", obtenerNombreZona(conn, zonaId)); // Para mostrar el nombre de la zona
            }

            // Reporte 2: Especies por Zona (Consulta Fija como ejemplo)
            // Puedes hacerla dinámica de forma similar si lo necesitas
            List<Map<String, Object>> especiesPorZonaFijo = getGenericReportData(conn, "especiesPorZonaSimple");
            request.setAttribute("reporteEspeciesZonaFijo", especiesPorZonaFijo);
            
            // Aquí puedes añadir lógica para más reportes basados en 'action' u otros parámetros

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
}