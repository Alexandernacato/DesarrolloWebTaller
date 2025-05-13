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
    private ZonesService zonesService;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.zonesService = new ZonesService();
            LOGGER.info("ZonesService inicializado correctamente en ZonesController.");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error crítico al inicializar ZonesService en ZonesController.", e);
            throw new ServletException("No se pudo inicializar ZonesService. Verifique la configuración y la conexión a la base de datos.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (this.zonesService == null) {
            LOGGER.severe("ZonesService no está inicializado en doGet.");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "El servicio de Zonas no está disponible.");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }
        LOGGER.log(Level.INFO, "ZonesController - doGet - action: {0}", action);

        String targetPage;
        try {
            switch (action) {
                case "new":
                    request.setAttribute("zone", new Zones());
                    request.setAttribute("tiposBosque", TipoBosque.values());
                    targetPage = "/WEB-INF/jsp/ZonesFrm.jsp";
                    break;
                case "edit":
                    String idEditParam = request.getParameter("id");
                    if (idEditParam == null || idEditParam.trim().isEmpty()) {
                        LOGGER.warning("ID para editar no proporcionado.");
                        response.sendRedirect(request.getContextPath() + "/zones?action=list&error=missingId");
                        return;
                    }
                    int idEdit = Integer.parseInt(idEditParam);
                    Zones zoneToEdit = zonesService.obtenerPorId(idEdit); // CORREGIDO: Usar obtenerPorId
                    if (zoneToEdit == null) {
                        LOGGER.log(Level.WARNING, "No se encontró la zona con ID: {0} para editar.", idEdit);
                        response.sendRedirect(request.getContextPath() + "/zones?action=list&error=notFound");
                        return;
                    }
                    request.setAttribute("zone", zoneToEdit);
                    request.setAttribute("tiposBosque", TipoBosque.values());
                    targetPage = "/WEB-INF/jsp/ZonesFrm.jsp";
                    break;
                case "delete":
                    handleDeleteAction(request, response);
                    return;
                case "list":
                default:
                    List<Zones> zonesList = zonesService.listarZonas(); // CORREGIDO: Usar listarZonas
                    request.setAttribute("zonesList", zonesList);
                    targetPage = "/WEB-INF/jsp/Zones.jsp";
                    break;
            }
            request.getRequestDispatcher(targetPage).forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Error de formato de número en doGet (ID inválido): {0}", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/zones?action=list&error=invalidIdFormat");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error inesperado en doGet de ZonesController", e);
            throw new ServletException("Error procesando la solicitud GET: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (this.zonesService == null) {
            LOGGER.severe("ZonesService no está inicializado en doPost.");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "El servicio de Zonas no está disponible.");
            return;
        }
        request.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String ubicacion = request.getParameter("ubicacion");
        String provincia = request.getParameter("provincia");
        String tipoBosqueParam = request.getParameter("tipo_bosque");
        String areaHaParam = request.getParameter("area_ha");
        String descripcion = request.getParameter("descripcion");
        String fechaRegistroParam = request.getParameter("fecha_registro");

        LOGGER.log(Level.INFO, "ZonesController - doPost - id: {0}, nombre: {1}", new Object[]{idParam, nombre});

        try {
            Zones zone = new Zones();
            boolean isUpdate = idParam != null && !idParam.trim().isEmpty() && !idParam.equals("0");

            if (isUpdate) {
                zone.setId(Integer.parseInt(idParam));
            }

            if (nombre == null || nombre.trim().isEmpty()) {
                throw new IllegalArgumentException("El nombre de la zona es obligatorio.");
            }
            if (ubicacion == null || ubicacion.trim().isEmpty()) {
                throw new IllegalArgumentException("La ubicación de la zona es obligatoria.");
            }
            if (areaHaParam == null || areaHaParam.trim().isEmpty()) {
                throw new IllegalArgumentException("El área en hectáreas es obligatoria.");
            }

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
            }

            String successMessage;
            if (isUpdate) {
                zonesService.actualizarZona(zone); // CORREGIDO: Usar actualizarZona
                successMessage = "Zona actualizada exitosamente.";
                LOGGER.log(Level.INFO, "Zona actualizada: {0}", zone.getNombre());
            } else {
                zonesService.insertarZona(zone); // CORREGIDO: Usar insertarZona
                successMessage = "Zona insertada exitosamente.";
                LOGGER.log(Level.INFO, "Zona insertada: {0}", zone.getNombre());
            }
            response.sendRedirect(request.getContextPath() + "/zones?action=list&successMessage=" + java.net.URLEncoder.encode(successMessage, "UTF-8"));

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Error de formato de número en doPost (ID o Área): {0}", e.getMessage());
            request.setAttribute("errorMessage", "Error en el formato de los números (ID o Área).");
            request.setAttribute("zone", recreateZoneFromParameters(request));
            request.setAttribute("tiposBosque", TipoBosque.values());
            request.getRequestDispatcher("/WEB-INF/jsp/ZonesFrm.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Error en argumentos en doPost: {0}", e.getMessage());
            request.setAttribute("errorMessage", "Error en los datos ingresados: " + e.getMessage());
            request.setAttribute("zone", recreateZoneFromParameters(request));
            request.setAttribute("tiposBosque", TipoBosque.values());
            request.getRequestDispatcher("/WEB-INF/jsp/ZonesFrm.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error inesperado en doPost de ZonesController", e);
            request.setAttribute("errorMessage", "Ocurrió un error inesperado: " + e.getMessage());
            request.setAttribute("zone", recreateZoneFromParameters(request));
            request.setAttribute("tiposBosque", TipoBosque.values());
            request.getRequestDispatcher("/WEB-INF/jsp/ZonesFrm.jsp").forward(request, response);
        }
    }

    private void handleDeleteAction(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String idDeleteParam = request.getParameter("id");
            if (idDeleteParam == null || idDeleteParam.trim().isEmpty()) {
                LOGGER.warning("ID para eliminar no proporcionado.");
                response.sendRedirect(request.getContextPath() + "/zones?action=list&error=missingIdDelete");
                return;
            }
            int idDelete = Integer.parseInt(idDeleteParam);
            LOGGER.log(Level.INFO, "Intentando eliminar zona con ID: {0}", idDelete);
            zonesService.eliminarZona(idDelete); // CORREGIDO: Usar eliminarZona (ya estaba bien)
            LOGGER.log(Level.INFO, "Zona eliminada exitosamente con ID: {0}", idDelete);
            response.sendRedirect(request.getContextPath() + "/zones?action=list&successMessage=" + java.net.URLEncoder.encode("Zona eliminada exitosamente.", "UTF-8"));
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Error de formato de número al intentar eliminar (ID inválido): {0}", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/zones?action=list&error=invalidIdFormatDelete");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error inesperado al eliminar zona", e);
            response.sendRedirect(request.getContextPath() + "/zones?action=list&errorMessage=" + java.net.URLEncoder.encode("Error al eliminar la zona: " + e.getMessage(), "UTF-8"));
        }
    }

    private Zones recreateZoneFromParameters(HttpServletRequest request) {
        Zones zone = new Zones();
        String idParam = request.getParameter("id");
         if (idParam != null && !idParam.isEmpty() && !idParam.equals("0")) {
            try { zone.setId(Integer.parseInt(idParam)); } catch (NumberFormatException ignored) {
                LOGGER.finest("Error al parsear ID en recreateZoneFromParameters, se ignora.");
            }
        }
        zone.setNombre(request.getParameter("nombre"));
        zone.setUbicacion(request.getParameter("ubicacion"));
        zone.setProvincia(request.getParameter("provincia"));
        zone.setTipo_bosque(TipoBosque.fromString(request.getParameter("tipo_bosque")));
        String areaHaParam = request.getParameter("area_ha");
        if (areaHaParam != null && !areaHaParam.isEmpty()) {
            try { zone.setArea_ha(new BigDecimal(areaHaParam.replace(",", "."))); } catch (NumberFormatException ignored) {
                 LOGGER.finest("Error al parsear area_ha en recreateZoneFromParameters, se ignora.");
            }
        }
        zone.setDescripcion(request.getParameter("descripcion"));
        String fechaRegistroParam = request.getParameter("fecha_registro");
        if (fechaRegistroParam != null && !fechaRegistroParam.isEmpty()) {
            try { zone.setFecha_registro(Date.valueOf(fechaRegistroParam)); } catch (IllegalArgumentException ignored) {
                LOGGER.finest("Error al parsear fecha_registro en recreateZoneFromParameters, se ignora.");
            }
        }
        return zone;
    }

    @Override
    public String getServletInfo() {
        return "Controller para la gestión de Zonas Forestales";
    }
}