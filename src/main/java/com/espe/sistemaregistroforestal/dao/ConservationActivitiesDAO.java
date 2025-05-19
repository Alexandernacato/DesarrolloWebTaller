package com.espe.sistemaregistroforestal.dao;

import com.espe.sistemaregistroforestal.model.ConservationActivities;
import com.espe.sistemaregistroforestal.model.TipoActividad;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ConservationActivitiesDAO {
    
     public List<ConservationActivities> listarActividades() {
        List<ConservationActivities> lista = new ArrayList<>();
        String sql = "SELECT * FROM conservation_activities WHERE activo = TRUE";

        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ConservationActivities actividad = new ConservationActivities();
                actividad.setId(rs.getInt("id"));
                actividad.setNombreActividad(rs.getString("nombre_actividad"));
                actividad.setFechaActividad(rs.getDate("fecha_actividad").toLocalDate());
                actividad.setResponsable(rs.getString("responsable"));

              
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
        String sqlActividad = "INSERT INTO conservation_activities (nombre_actividad, fecha_actividad, responsable, tipo_actividad, descripcion, zona_id, activo) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlConservacionZona = "INSERT INTO conservation_zona (conservation_id, zona_id) VALUES (?, ?)";

        try (Connection conn = ConnectionBdd.getConexion()) {
           
            try (PreparedStatement stmt = conn.prepareStatement(sqlActividad, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, actividad.getNombreActividad());
                stmt.setDate(2, java.sql.Date.valueOf(actividad.getFechaActividad()));
                stmt.setString(3, actividad.getResponsable());
                stmt.setString(4, actividad.getTipoActividad().getDisplayName());
                stmt.setString(5, actividad.getDescripcion());
                stmt.setInt(6, actividad.getZonaId());
                stmt.setBoolean(7, actividad.isActivo());
                stmt.executeUpdate();

                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int idGenerado = generatedKeys.getInt(1);
                    System.out.println("ID insertado: " + idGenerado);

                   
                    try (PreparedStatement stmtZona = conn.prepareStatement(sqlConservacionZona)) {
                        stmtZona.setInt(1, idGenerado);
                        stmtZona.setInt(2, actividad.getZonaId());
                        stmtZona.executeUpdate();
                        System.out.println("Insertado en conservation_zona: activity_id = " + idGenerado + ", zona_id = " + actividad.getZonaId());
                    }
                } else {
                    System.out.println("No se pudo obtener el ID generado para la actividad.");
                }
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

               
                actividad.setTipoActividad(TipoActividad.fromString(rs.getString("tipo_actividad")));

                actividad.setDescripcion(rs.getString("descripcion"));
                actividad.setZonaId(rs.getInt("zona_id"));
                actividad.setActivo(rs.getBoolean("activo"));
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

          
            stmt.setString(4, actividad.getTipoActividad().getDisplayName());

            stmt.setString(5, actividad.getDescripcion());
            stmt.setInt(6, actividad.getZonaId());
            stmt.setInt(7, actividad.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void borrarActividadLogica(int id) {
        String sql = "UPDATE conservation_activities SET activo = FALSE WHERE id = ?";

        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
public boolean validarZonaExistente(int zonaId) {
    String sql = "SELECT COUNT(*) FROM zones WHERE id = ?";
    
    try (Connection conn = ConnectionBdd.getConexion();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setInt(1, zonaId);  
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            int count = rs.getInt(1);  
            return count > 0;  
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return false;  
}

       
}
