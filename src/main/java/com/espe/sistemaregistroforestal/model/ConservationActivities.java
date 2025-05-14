package com.espe.sistemaregistroforestal.model;

import java.time.LocalDate;

public class ConservationActivities {
    private int id;
    private String nombreActividad;
    private LocalDate fechaActividad;
    private String responsable;
    private TipoActividad tipoActividad;
    private String descripcion;
    private int zonaId;

    public ConservationActivities() {
    }

    public ConservationActivities(int id, String nombreActividad, LocalDate fechaActividad, String responsable, TipoActividad tipoActividad, String descripcion, int zonaId) {
        this.id = id;
        this.nombreActividad = nombreActividad;
        this.fechaActividad = fechaActividad;
        this.responsable = responsable;
        this.tipoActividad = tipoActividad;
        this.descripcion = descripcion;
        this.zonaId = zonaId;
    }

    public TipoActividad getTipoActividad() {
        return tipoActividad;
    }

    public void setTipoActividad(TipoActividad tipoActividad) {
        this.tipoActividad = tipoActividad;
    }
        
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombreActividad() {
        return nombreActividad;
    }

    public void setNombreActividad(String nombreActividad) {
        this.nombreActividad = nombreActividad;
    }

    public LocalDate getFechaActividad() {
        return fechaActividad;
    }

    public void setFechaActividad(LocalDate fechaActividad) {
        this.fechaActividad = fechaActividad;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getZonaId() {
        return zonaId;
    }

    public void setZonaId(int zonaId) {
        this.zonaId = zonaId;
    }
}
