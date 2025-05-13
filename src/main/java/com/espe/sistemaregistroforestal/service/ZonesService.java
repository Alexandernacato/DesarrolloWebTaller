package com.espe.sistemaregistroforestal.service;

import com.espe.sistemaregistroforestal.dao.ZonesDAO;
import com.espe.sistemaregistroforestal.model.Zones;
import java.util.List;

public class ZonesService {
    private final ZonesDAO zonesDAO;

    public ZonesService() {
        this.zonesDAO = new ZonesDAO();
    }

    public List<Zones> listarZonas() {
        return zonesDAO.listarZonas();
    }

    public Zones obtenerPorId(int id) {
        return zonesDAO.obtenerPorId(id);
    }

    public void insertarZona(Zones zone) {
        zonesDAO.insertarZona(zone);
    }

    public void actualizarZona(Zones zone) {
        zonesDAO.actualizarZona(zone);
    }

    public void eliminarZona(int id) {
        zonesDAO.eliminarZona(id);
    }
}
