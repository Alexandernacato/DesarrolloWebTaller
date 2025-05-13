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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ZonesController", urlPatterns = {"/zones"})
public class ZonesController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ZonesController.class.getName());
    private final ZonesService zonesService = new ZonesService();

    @Override
    public void init() throws ServletException {
        super.init();
        // Inicializar el servicio. Es crucial que esto funcione.
        // Si ZonesService o su dependencia ZonesDAO fallan en sus constructores,
        // la aplicación tendrá problemas.
        try {
            LOGGER.info("ZonesService inicializado correctamente en ZonesController.");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error crítico al inicializar ZonesService en ZonesController. La funcionalidad de Zonas estará deshabilitada.", e);
            // Lanzar la excepción puede ser una opción para detener la carga del servlet si es un error irrecuperable.
            throw new ServletException("No se pudo inicializar ZonesService. Verifique la conexión a la base de datos y la configuración del DAO.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                request.setAttribute("zone", new Zones());
                request.setAttribute("tiposBosque", TipoBosque.values());
                request.getRequestDispatcher("/WEB-INF/jsp/ZonesFrm.jsp").forward(request, response);
                break;
            case "edit":
                int id = Integer.parseInt(request.getParameter("id"));
                Zones zone = zonesService.obtenerPorId(id);
                if (zone == null) {
                    LOGGER.log(Level.WARNING, "No se encontró la zona con ID: {0} para editar.", id);
                    response.sendRedirect(request.getContextPath() + "/zones?action=list&error=notFound");
                    return;
                }
                request.setAttribute("zone", zone);
                request.setAttribute("tiposBosque", TipoBosque.values());
                request.getRequestDispatcher("/WEB-INF/jsp/ZonesFrm.jsp").forward(request, response);
                break;
            case "delete":
                int idDelete = Integer.parseInt(request.getParameter("id"));
                zonesService.eliminarZona(idDelete);
                response.sendRedirect(request.getContextPath() + "/zones?action=list&success=delete");
                break;
            default:
                List<Zones> zonesList = zonesService.listarZonas();
                request.setAttribute("zonesList", zonesList);
                request.getRequestDispatcher("/WEB-INF/jsp/Zones.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String ubicacion = request.getParameter("ubicacion");
        String provincia = request.getParameter("provincia");
        String tipoBosque = request.getParameter("tipo_bosque");
        String areaHa = request.getParameter("area_ha");
        String descripcion = request.getParameter("descripcion");
        String fechaRegistro = request.getParameter("fecha_registro");

        Zones zone = new Zones();
        if (idParam != null && !idParam.isEmpty()) {
            zone.setId(Integer.parseInt(idParam));
        }
        zone.setNombre(nombre);
        zone.setUbicacion(ubicacion);
        zone.setProvincia(provincia);
        zone.setTipo_bosque(TipoBosque.valueOf(tipoBosque));
        zone.setArea_ha(new BigDecimal(areaHa));
        zone.setDescripcion(descripcion);
        zone.setFecha_registro(Date.valueOf(fechaRegistro));

        if (idParam == null || idParam.isEmpty()) {
            zonesService.insertarZona(zone);
        } else {
            zonesService.actualizarZona(zone);
        }

        response.sendRedirect(request.getContextPath() + "/zones");
    }

    @Override
    public String getServletInfo() {
        return "Controller para la gestión de Zonas Forestales";
    }
}