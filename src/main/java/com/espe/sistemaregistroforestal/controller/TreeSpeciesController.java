/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.espe.sistemaregistroforestal.controller;

import com.espe.sistemaregistroforestal.model.TreeSpecies;
import com.espe.sistemaregistroforestal.service.TreeSpeciesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;


@WebServlet(name = "TreeSpeciesController", urlPatterns = {"/TreeSpecies"})
public class TreeSpeciesController extends HttpServlet {

    private final TreeSpeciesService treeSpeciesService = new TreeSpeciesService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String option = request.getParameter("option");
        if (option == null) option = "findAll";

        switch (option) {
            case "new":
                request.getRequestDispatcher("/TreeSpeciesFrm.jsp").forward(request, response);
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                TreeSpecies treeSpecies = treeSpeciesService.obtenerPorId(id);
                request.setAttribute("treeSpecies", treeSpecies);
                request.getRequestDispatcher("/TreeSpeciesFrm.jsp").forward(request, response);
                break;
            case "delete":
                int idDelete = Integer.parseInt(request.getParameter("id"));
                treeSpeciesService.eliminarEspecie(idDelete);
                response.sendRedirect(request.getContextPath() + "/TreeSpecies");
                break;
            default:
                List<TreeSpecies> treeSpeciesList = treeSpeciesService.listarEspecies();
                request.setAttribute("treeSpeciesList", treeSpeciesList);
                request.getRequestDispatcher("/TreeSpecies.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String nombreComun = request.getParameter("nombreComun");
        String nombreCientifico = request.getParameter("nombreCientifico");
        String familiaBotanica = request.getParameter("familiaBotanica");
        String estadoConservacion = request.getParameter("estadoConservacion");
        String usoPrincipal = request.getParameter("usoPrincipal");
        double alturaMaximaM = Double.parseDouble(request.getParameter("alturaMaximaM"));
        int zonaId = Integer.parseInt(request.getParameter("zonaId"));
        
        System.out.println("Nombre común: " + nombreComun);
        System.out.println("Nombre científico: " + nombreCientifico);
        System.out.println("Familia botánica: " + familiaBotanica);
        System.out.println("Estado conservación: " + estadoConservacion);
        System.out.println("Uso principal: " + usoPrincipal);
        System.out.println("Altura máxima: " + alturaMaximaM);
        System.out.println("Zona ID: " + zonaId);

        TreeSpecies treeSpecies = new TreeSpecies();
        treeSpecies.setNombreComun(nombreComun);
        treeSpecies.setNombreCientifico(nombreCientifico);
        treeSpecies.setFamiliaBotanica(familiaBotanica);
        treeSpecies.setEstadoConservacion(estadoConservacion);
        treeSpecies.setUsoPrincipal(usoPrincipal);
        treeSpecies.setAlturaMaximaM(alturaMaximaM);
        treeSpecies.setZonaId(zonaId);

        if (idParam == null || idParam.isEmpty()) {
            treeSpeciesService.insertarEspecie(treeSpecies);
        } else {
            treeSpecies.setId(Integer.parseInt(idParam));
            treeSpeciesService.actualizarEspecie(treeSpecies);
        }

        response.sendRedirect(request.getContextPath() + "/TreeSpecies");
    }
}