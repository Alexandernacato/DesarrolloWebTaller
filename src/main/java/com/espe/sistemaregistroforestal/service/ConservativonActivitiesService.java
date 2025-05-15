package com.espe.sistemaregistroforestal.service;

import com.espe.sistemaregistroforestal.dao.ConservationActivitiesDAO;
import com.espe.sistemaregistroforestal.model.ConservationActivities;
import java.util.List;

public class ConservativonActivitiesService {
    
    private final ConservationActivitiesDAO conservationActivitiesDAO;

    public ConservativonActivitiesService() {
        this.conservationActivitiesDAO = new ConservationActivitiesDAO();
    }

    // Listar todas las actividades de conservación
    public List<ConservationActivities> listarActividades() {
        return conservationActivitiesDAO.listarActividades();
    }

    // Obtener actividad por ID
    public ConservationActivities obtenerPorId(int id) {
        return conservationActivitiesDAO.obtenerPorId(id);
    }

    // Insertar una nueva actividad
    public void insertarActividad(ConservationActivities actividad) {
        conservationActivitiesDAO.insertarActividad(actividad);
    }

    // Actualizar una actividad existente
    public void actualizarActividad(ConservationActivities actividad) {
        conservationActivitiesDAO.actualizarActividad(actividad);
    }
}
