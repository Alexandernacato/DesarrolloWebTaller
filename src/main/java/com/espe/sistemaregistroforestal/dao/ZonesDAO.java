/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.espe.sistemaregistroforestal.dao;

import com.espe.sistemaregistroforestal.model.Zones;
import com.espe.sistemaregistroforestal.model.TipoBosque; // IMPORTAR Enum
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

import java.sql.SQLException;

/**
 *
 * @author alexa
 */
public class ZonesDAO {

    public static boolean crear(Zones zona) {
        String sql = "INSERT INTO zones (nombre, ubicacion, provincia, tipo_bosque, area_ha, descripcion, fecha_registro) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, zona.getNombre());
            pstmt.setString(2, zona.getUbicacion());
            pstmt.setString(3, zona.getProvincia());
            pstmt.setString(4, zona.getTipo_bosque() != null ? zona.getTipo_bosque().getDisplayName() : TipoBosque.OTRO.getDisplayName()); // MODIFICADO
            pstmt.setBigDecimal(5, zona.getArea_ha());
            pstmt.setString(6, zona.getDescripcion());
            if (zona.getFecha_registro() != null) {
                pstmt.setDate(7, zona.getFecha_registro());
            } else {
                // Si la BD tiene DEFAULT CURDATE(), no es necesario enviarlo si es null.
                // O puedes establecerlo explícitamente si es necesario:
                 pstmt.setDate(7, new Date(System.currentTimeMillis()));
            }
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static Zones obtenerPorId(int id) {
        String sql = "SELECT * FROM zones WHERE id = ?";
        Zones zona = null;
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                zona = new Zones();
                zona.setId(rs.getInt("id"));
                zona.setNombre(rs.getString("nombre"));
                zona.setUbicacion(rs.getString("ubicacion"));
                zona.setProvincia(rs.getString("provincia"));
                zona.setTipo_bosque(TipoBosque.fromString(rs.getString("tipo_bosque"))); // MODIFICADO
                zona.setArea_ha(rs.getBigDecimal("area_ha"));
                zona.setDescripcion(rs.getString("descripcion"));
                zona.setFecha_registro(rs.getDate("fecha_registro"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return zona;
    }

        public static List<Zones> obtenerTodos() {
            List<Zones> zonas = new ArrayList<>();
            String sql = "SELECT id, nombre, ubicacion, provincia, tipo_bosque, area_ha, descripcion, fecha_registro FROM zones";
            try (Connection conn = ConnectionBdd.getConexion();
                 PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                System.out.println("Ejecutando obtenerTodos() de zones");
                while (rs.next()) {
                    Zones zona = new Zones();
                    zona.setId(rs.getInt("id"));
                    zona.setNombre(rs.getString("nombre"));
                    zona.setUbicacion(rs.getString("ubicacion"));
                    zona.setProvincia(rs.getString("provincia"));

                    String tipoBosqueStr = rs.getString("tipo_bosque");
                    if (tipoBosqueStr != null) {
                        try {
                            zona.setTipo_bosque(TipoBosque.fromString(tipoBosqueStr));
                        } catch (Exception e) {
                            System.err.println("Error al convertir tipo_bosque: " + e.getMessage());
                            zona.setTipo_bosque(TipoBosque.OTRO); // Valor predeterminado
                        }
                    } else {
                        zona.setTipo_bosque(TipoBosque.OTRO); // Valor predeterminado si es null
                    }

                    zona.setArea_ha(rs.getBigDecimal("area_ha"));
                    zona.setDescripcion(rs.getString("descripcion"));
                    zona.setFecha_registro(rs.getDate("fecha_registro"));

                    zonas.add(zona);
                }
                System.out.println("Total zonas recuperadas: " + zonas.size());
            } catch (SQLException e) {
                System.err.println("Error en obtenerTodos de ZonesDAO: " + e.getMessage());
                e.printStackTrace();
            }
            return zonas;
        }

    public static boolean actualizar(Zones zona) {
        String sql = "UPDATE zones SET nombre = ?, ubicacion = ?, provincia = ?, tipo_bosque = ?, area_ha = ?, descripcion = ?, fecha_registro = ? WHERE id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, zona.getNombre());
            pstmt.setString(2, zona.getUbicacion());
            pstmt.setString(3, zona.getProvincia());
            pstmt.setString(4, zona.getTipo_bosque() != null ? zona.getTipo_bosque().getDisplayName() : TipoBosque.OTRO.getDisplayName()); // MODIFICADO
            pstmt.setBigDecimal(5, zona.getArea_ha());
            pstmt.setString(6, zona.getDescripcion());
            pstmt.setDate(7, zona.getFecha_registro());
            pstmt.setInt(8, zona.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM zones WHERE id = ?";
        try (Connection conn = ConnectionBdd.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

