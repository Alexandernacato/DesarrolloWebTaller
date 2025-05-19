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

 
    public List<ConservationActivities> listarActividades() {
        return conservationActivitiesDAO.listarActividades();
    }


    public ConservationActivities obtenerPorId(int id) {
        return conservationActivitiesDAO.obtenerPorId(id);
    }

 
    public void insertarActividad(ConservationActivities actividad) {
        conservationActivitiesDAO.insertarActividad(actividad);
    }

    
    public void actualizarActividad(ConservationActivities actividad) {
        conservationActivitiesDAO.actualizarActividad(actividad);
    }
    

    public void borrarActividadLogica(int id) {
        conservationActivitiesDAO.borrarActividadLogica(id);
    }
      public boolean validarZonaExistente(int zonaId) {
        return conservationActivitiesDAO.validarZonaExistente(zonaId);
    }
   
}
