package com.espe.sistemaregistroforestal.dao;

import com.espe.sistemaregistroforestal.model.ConservationActivities;
import com.espe.sistemaregistroforestal.model.TipoActividad;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ConservationActivitiesDAO {
    
     public List<ConservationActivities> listarActividades() {
        List<ConservationActivities> lista = new ArrayList<>();
        String sql = "SELECT * FROM conservation_activities";

        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ConservationActivities actividad = new ConservationActivities();
                actividad.setId(rs.getInt("id"));
                actividad.setNombreActividad(rs.getString("nombre_actividad"));
                actividad.setFechaActividad(rs.getDate("fecha_actividad").toLocalDate());
                actividad.setResponsable(rs.getString("responsable"));

                // Conversión String -> Enum
                String tipoStr = rs.getString("tipo_actividad");
                actividad.setTipoActividad(TipoActividad.fromString(tipoStr));

                actividad.setDescripcion(rs.getString("descripcion"));
                actividad.setZonaId(rs.getInt("zona_id"));

                lista.add(actividad);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public void insertarActividad(ConservationActivities actividad) {
        String sql = "INSERT INTO conservation_activities (nombre_actividad, fecha_actividad, responsable, tipo_actividad, descripcion, zona_id) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, actividad.getNombreActividad());
            stmt.setDate(2, java.sql.Date.valueOf(actividad.getFechaActividad()));
            stmt.setString(3, actividad.getResponsable());

            // Enum -> String para la BD
            stmt.setString(4, actividad.getTipoActividad().getDisplayName());

            stmt.setString(5, actividad.getDescripcion());
            stmt.setInt(6, actividad.getZonaId());

            stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int idGenerado = generatedKeys.getInt(1);
                System.out.println("ID insertado: " + idGenerado);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ConservationActivities obtenerPorId(int id) {
        ConservationActivities actividad = null;
        String sql = "SELECT * FROM conservation_activities WHERE id = ?";

        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                actividad = new ConservationActivities();
                actividad.setId(rs.getInt("id"));
                actividad.setNombreActividad(rs.getString("nombre_actividad"));
                actividad.setFechaActividad(rs.getDate("fecha_actividad").toLocalDate());
                actividad.setResponsable(rs.getString("responsable"));

                // Conversión String -> Enum
                actividad.setTipoActividad(TipoActividad.fromString(rs.getString("tipo_actividad")));

                actividad.setDescripcion(rs.getString("descripcion"));
                actividad.setZonaId(rs.getInt("zona_id"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return actividad;
    }

    public void actualizarActividad(ConservationActivities actividad) {
        String sql = "UPDATE conservation_activities SET nombre_actividad = ?, fecha_actividad = ?, responsable = ?, tipo_actividad = ?, descripcion = ?, zona_id = ? WHERE id = ?";

        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, actividad.getNombreActividad());
            stmt.setDate(2, java.sql.Date.valueOf(actividad.getFechaActividad()));
            stmt.setString(3, actividad.getResponsable());

            // Enum -> String para la BD
            stmt.setString(4, actividad.getTipoActividad().getDisplayName());

            stmt.setString(5, actividad.getDescripcion());
            stmt.setInt(6, actividad.getZonaId());
            stmt.setInt(7, actividad.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
