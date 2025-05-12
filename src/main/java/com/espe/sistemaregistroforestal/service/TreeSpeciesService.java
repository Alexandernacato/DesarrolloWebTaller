/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.espe.sistemaregistroforestal.service;

import com.espe.sistemaregistroforestal.dao.TreeSpeciesDAO;
import com.espe.sistemaregistroforestal.model.TreeSpecies;
import java.util.List;

/**
 *
 * @author alexa
 */
public class TreeSpeciesService {
      private final TreeSpeciesDAO treeSpeciesDAO;

    public TreeSpeciesService() {
        this.treeSpeciesDAO = new TreeSpeciesDAO();
    }

    public List<TreeSpecies> listarEspecies() {
        return treeSpeciesDAO.listarEspecies();
    }

    public TreeSpecies obtenerPorId(int id) {
        return treeSpeciesDAO.obtenerPorId(id);
    }

    public void insertarEspecie(TreeSpecies treeSpecies) {
        treeSpeciesDAO.insertarEspecie(treeSpecies);
    }

    public void actualizarEspecie(TreeSpecies treeSpecies) {
        treeSpeciesDAO.actualizarEspecie(treeSpecies);
    }

    public void eliminarEspecie(int id) {
        treeSpeciesDAO.eliminarEspecie(id);
    }
}
