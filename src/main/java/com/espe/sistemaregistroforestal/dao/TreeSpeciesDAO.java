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
           
    String sql = "INSERT INTO tree_species (nombre_comun, nombre_cientifico, familia_botanica, estado_conservacion, uso_principal, altura_maxima_m, zona_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

    try (Connection conn = ConnectionBdd.getConexion();
         PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {  // Aquí agregamos RETURN_GENERATED_KEYS

        stmt.setString(1, especie.getNombreComun());
        stmt.setString(2, especie.getNombreCientifico());
        stmt.setString(3, especie.getFamiliaBotanica());
        stmt.setString(4, especie.getEstadoConservacion());
        stmt.setString(5, especie.getUsoPrincipal());
        stmt.setDouble(6, especie.getAlturaMaximaM());
        stmt.setInt(7, especie.getZonaId());

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
