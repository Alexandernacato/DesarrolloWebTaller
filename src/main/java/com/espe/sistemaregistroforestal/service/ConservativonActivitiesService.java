package com.espe.sistemaregistroforestal.service;

import com.espe.sistemaregistroforestal.dao.ConservationActivitiesDAO;
import com.espe.sistemaregistroforestal.model.ConservationActivities;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

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
    
    // Borrado lógico de actividad
    public void borrarActividadLogica(int id) {
        conservationActivitiesDAO.borrarActividadLogica(id);
    }
      public boolean validarZonaExistente(int zonaId) {
        return conservationActivitiesDAO.validarZonaExistente(zonaId);
    }
   
}
