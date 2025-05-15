package com.espe.sistemaregistroforestal.service;

import com.espe.sistemaregistroforestal.dao.ZonesDAO;
import com.espe.sistemaregistroforestal.model.Zones;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ZonesService {
    private final ZonesDAO zonesDAO;
    private static final Logger LOGGER = Logger.getLogger(ZonesService.class.getName());

    public ZonesService() {
        this.zonesDAO = new ZonesDAO();
        LOGGER.info("ZonesService inicializado");
    }

    public List<Zones> listarZonas() {
 
        return ZonesDAO.obtenerTodos();
    }

    public Zones obtenerPorId(int id) {
      
        return ZonesDAO.obtenerPorId(id);
    }

    public void insertarZona(Zones zone) {
        
        ZonesDAO.crear(zone);
    }

    public void actualizarZona(Zones zone) {
 
        ZonesDAO.actualizar(zone);
    }

    public void eliminarZona(int id) {
        
        zonesDAO.eliminar(id);
    }
}
