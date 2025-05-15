package com.espe.sistemaregistroforestal.controller;

import com.espe.sistemaregistroforestal.model.Zones;
import com.espe.sistemaregistroforestal.model.TipoBosque;
import com.espe.sistemaregistroforestal.service.ZonesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ZonesController", urlPatterns = {"/zones"})
public class ZonesController extends HttpServlet {

    private final ZonesService zonesService = new ZonesService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String option = request.getParameter("option");
        if (option == null) option = "findAll";

        switch (option) {
            case "new":
                request.setAttribute("tiposBosque", TipoBosque.values());
                request.getRequestDispatcher("/ZonesFrm.jsp").forward(request, response);
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                Zones zone = zonesService.obtenerPorId(id);
                request.setAttribute("zone", zone);
                request.setAttribute("tiposBosque", TipoBosque.values());
                request.getRequestDispatcher("/ZonesFrm.jsp").forward(request, response);
                break;
            case "delete":
                int idDelete = Integer.parseInt(request.getParameter("id"));
                zonesService.eliminarZona(idDelete);
                response.sendRedirect(request.getContextPath() + "/zones");
                break;
            default:
                List<Zones> zonesList = zonesService.listarZonas();
                request.setAttribute("zonesList", zonesList);
                request.getRequestDispatcher("/Zones.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String option = request.getParameter("option");

        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String ubicacion = request.getParameter("ubicacion");
        String provincia = request.getParameter("provincia");
        String tipoBosqueParam = request.getParameter("tipo_bosque");
        String areaHaParam = request.getParameter("area_ha");
        String descripcion = request.getParameter("descripcion");
        String fechaRegistroParam = request.getParameter("fecha_registro");

        Zones zone = new Zones();
        zone.setNombre(nombre);
        zone.setUbicacion(ubicacion);
        zone.setProvincia(provincia);
        zone.setTipo_bosque(TipoBosque.fromString(tipoBosqueParam));
        
        if (areaHaParam != null && !areaHaParam.isEmpty()) {
            zone.setArea_ha(new BigDecimal(areaHaParam.replace(",", ".")));
        }
        
        zone.setDescripcion(descripcion);
        
        if (fechaRegistroParam != null && !fechaRegistroParam.isEmpty()) {
            zone.setFecha_registro(Date.valueOf(fechaRegistroParam));
        } else {
            zone.setFecha_registro(new Date(System.currentTimeMillis()));
        }

        if (idParam == null || idParam.isEmpty()) {
            zonesService.insertarZona(zone);
        } else {
            zone.setId(Integer.parseInt(idParam));
            zonesService.actualizarZona(zone);
        }

        if ("save".equals(option)) {
        if (idParam == null || idParam.isEmpty() || "0".equals(idParam)) {
            System.out.println("Insertando nueva zona: " + zone.getNombre());
            zonesService.insertarZona(zone);
        } else {
            System.out.println("Actualizando zona existente ID: " + idParam);
            zone.setId(Integer.parseInt(idParam));
            zonesService.actualizarZona(zone);
        }
        
        // Si la solicitud proviene de AJAX, envía una respuesta adecuada
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":true}");
            return;
        }
    }

        response.sendRedirect(request.getContextPath() + "/zones");
    }
}