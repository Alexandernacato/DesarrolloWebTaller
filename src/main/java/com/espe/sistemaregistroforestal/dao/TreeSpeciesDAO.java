    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
     */
    package com.espe.sistemaregistroforestal.dao;

    import com.espe.sistemaregistroforestal.model.TreeSpecies;
    import java.sql.Connection;
    import java.sql.PreparedStatement;
    import java.sql.ResultSet;
    import java.sql.SQLException;
import java.sql.Statement;
    import java.util.ArrayList;
    import java.util.List;

    /**
     *
     * @author alexa
     */
    public class TreeSpeciesDAO {
         public List<TreeSpecies> listarEspecies() {
            List<TreeSpecies> lista = new ArrayList<>();
            String sql = "SELECT * FROM tree_species";

            try (Connection conn = ConnectionBdd.getConexion();
                 PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    TreeSpecies especie = new TreeSpecies();
                    especie.setId(rs.getInt("id"));
                    especie.setNombreComun(rs.getString("nombre_comun"));
                    especie.setNombreCientifico(rs.getString("nombre_cientifico"));
                    especie.setFamiliaBotanica(rs.getString("familia_botanica"));
                    especie.setEstadoConservacion(rs.getString("estado_conservacion"));
                    especie.setUsoPrincipal(rs.getString("uso_principal"));
                  especie.setAlturaMaximaM(rs.getDouble("altura_maxima_m"));
                    especie.setZonaId(rs.getInt("zona_id"));

                    lista.add(especie);
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }

            return lista;
        }

        public void insertarEspecie(TreeSpecies especie) {
            String sqlEspecie = "INSERT INTO tree_species (nombre_comun, nombre_cientifico, familia_botanica, estado_conservacion, uso_principal, altura_maxima_m, zona_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            String sqlZonaEspecie = "INSERT INTO zona_especie (zona_id, especie_id) VALUES (?, ?)";

            try (Connection conn = ConnectionBdd.getConexion();
                 PreparedStatement stmtEspecie = conn.prepareStatement(sqlEspecie, Statement.RETURN_GENERATED_KEYS)) {

                // Insertar en tree_species
                stmtEspecie.setString(1, especie.getNombreComun());
                stmtEspecie.setString(2, especie.getNombreCientifico());
                stmtEspecie.setString(3, especie.getFamiliaBotanica());
                stmtEspecie.setString(4, especie.getEstadoConservacion());
                stmtEspecie.setString(5, especie.getUsoPrincipal());
                stmtEspecie.setDouble(6, especie.getAlturaMaximaM());
                stmtEspecie.setInt(7, especie.getZonaId());

                int affectedRows = stmtEspecie.executeUpdate();

                if (affectedRows == 0) {
                    throw new SQLException("Error al insertar la especie, no se generó ninguna fila.");
                }

                // Obtener el ID generado automáticamente
                try (ResultSet generatedKeys = stmtEspecie.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int idGenerado = generatedKeys.getInt(1);
                        System.out.println("ID insertado: " + idGenerado);

                        // Insertar en zona_especie la relación
                        try (PreparedStatement stmtZonaEspecie = conn.prepareStatement(sqlZonaEspecie)) {
                            stmtZonaEspecie.setInt(1, especie.getZonaId());
                            stmtZonaEspecie.setInt(2, idGenerado);
                            stmtZonaEspecie.executeUpdate();
                        }
                    } else {
                        throw new SQLException("Error al obtener el ID generado para la especie.");
                    }
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        public TreeSpecies obtenerPorId(int id) {
            TreeSpecies especie = null;
            String sql = "SELECT * FROM tree_species WHERE id = ?";

            try (Connection conn = ConnectionBdd.getConexion();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setInt(1, id);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    especie = new TreeSpecies();
                    especie.setId(rs.getInt("id"));
                    especie.setNombreComun(rs.getString("nombre_comun"));
                    especie.setNombreCientifico(rs.getString("nombre_cientifico"));
                    especie.setFamiliaBotanica(rs.getString("familia_botanica"));
                    especie.setEstadoConservacion(rs.getString("estado_conservacion"));
                    especie.setUsoPrincipal(rs.getString("uso_principal"));
                    especie.setAlturaMaximaM(rs.getDouble("altura_maxima_m"));
                    especie.setZonaId(rs.getInt("zona_id"));
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }

            return especie;
        }

        public void actualizarEspecie(TreeSpecies especie) {
            String sql = "UPDATE tree_species SET nombre_comun=?, nombre_cientifico=?, familia_botanica=?, estado_conservacion=?, uso_principal=?, altura_maxima_m=?, zona_id=? WHERE id=?";

            try (Connection conn = ConnectionBdd.getConexion();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, especie.getNombreComun());
                stmt.setString(2, especie.getNombreCientifico());
                stmt.setString(3, especie.getFamiliaBotanica());
                stmt.setString(4, especie.getEstadoConservacion());
                stmt.setString(5, especie.getUsoPrincipal());
                stmt.setDouble(6, especie.getAlturaMaximaM());
                stmt.setInt(7, especie.getZonaId());
                stmt.setInt(8, especie.getId());

                stmt.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        public void eliminarEspecie(int id) {
            String sql = "DELETE FROM tree_species WHERE id=?";

            try (Connection conn = ConnectionBdd.getConexion();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setInt(1, id);
                stmt.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }


