/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.espe.sistemaregistroforestal;

import com.espe.sistemaregistroforestal.dao.ConnectionBdd;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author alexa
 */
public class TestConnection {
      public static void main(String[] args) {
        try (Connection conn = ConnectionBdd.getConexion()) {
            if (conn != null) {
                System.out.println("Conexión exitosa a la base de datos.");
            }
        } catch (SQLException e) {
            System.err.println("Error al conectar a la base de datos.");
            e.printStackTrace();
        }
    }
    
}
