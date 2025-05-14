package com.espe.sistemaregistroforestal.controller;

import com.espe.sistemaregistroforestal.model.ConservationActivities;
import com.espe.sistemaregistroforestal.model.TipoActividad;
import com.espe.sistemaregistroforestal.service.ConservativonActivitiesService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "ConservationActivitiesController", urlPatterns = {"/ConservationActivities"})
public class ConservationActivitiesController extends HttpServlet {

    private final ConservativonActivitiesService service = new ConservativonActivitiesService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String option = request.getParameter("option");
        if (option == null) option = "findAll";

        switch (option) {
            case "new":
                request.getRequestDispatcher("/ActivitiesFrm.jsp").forward(request, response);
                break;
            case "update":
                int id = Integer.parseInt(request.getParameter("id"));
                ConservationActivities actividad = service.obtenerPorId(id);
                request.setAttribute("actividad", actividad);
                request.getRequestDispatcher("/ActivitiesFrm.jsp").forward(request, response);
                break;
            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                service.borrarActividadLogica(deleteId); // Llamada al servicio para realizar el borrado lógico
                response.sendRedirect(request.getContextPath() + "/ConservationActivities"); // Redirigir de vuelta a la lista
                break;    
            default:
                List<ConservationActivities> lista = service.listarActividades();
                request.setAttribute("listaActividades", lista);
                request.getRequestDispatcher("/Activities.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombreActividad");
        String fechaStr = request.getParameter("fechaActividad");
        String responsable = request.getParameter("responsable");
        String tipoActividad = request.getParameter("tipoActividad");
        String descripcion = request.getParameter("descripcion");
        int zonaId = Integer.parseInt(request.getParameter("zonaId"));

        ConservationActivities actividad = new ConservationActivities();
        actividad.setNombreActividad(nombre);
        actividad.setFechaActividad(LocalDate.parse(fechaStr));
        actividad.setResponsable(responsable);
        actividad.setTipoActividad(TipoActividad.fromString(tipoActividad)); // Método que debes tener en el enum
        actividad.setDescripcion(descripcion);
        actividad.setZonaId(zonaId);

        if (idParam == null || idParam.isEmpty()) {
            service.insertarActividad(actividad);
        } else {
            actividad.setId(Integer.parseInt(idParam));
            service.actualizarActividad(actividad);
        }

        response.sendRedirect(request.getContextPath() + "/ConservationActivities");
    }

    @Override
    public String getServletInfo() {
        return "Controlador para las actividades de conservación";
    }
}
