/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.espe.sistemaregistroforestal.model;

/**
 *
 * @author alexa
 */
public class TreeSpecies {
    private int id;
    private String nombreComun;
    private String nombreCientifico;
    private String familiaBotanica;
    private String estadoConservacion;
    private String usoPrincipal;
    private double alturaMaximaM;
    private int zonaId;

  
    public TreeSpecies() {
    }

    public TreeSpecies(int id, String nombreComun, String nombreCientifico, String familiaBotanica,
                       String estadoConservacion, String usoPrincipal, double alturaMaximaM, int zonaId) {
        this.id = id;
        this.nombreComun = nombreComun;
        this.nombreCientifico = nombreCientifico;
        this.familiaBotanica = familiaBotanica;
        this.estadoConservacion = estadoConservacion;
        this.usoPrincipal = usoPrincipal;
        this.alturaMaximaM = alturaMaximaM;
        this.zonaId = zonaId;
    }

  

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombreComun() {
        return nombreComun;
    }

    public void setNombreComun(String nombreComun) {
        this.nombreComun = nombreComun;
    }

    public String getNombreCientifico() {
        return nombreCientifico;
    }

    public void setNombreCientifico(String nombreCientifico) {
        this.nombreCientifico = nombreCientifico;
    }

    public String getFamiliaBotanica() {
        return familiaBotanica;
    }

    public void setFamiliaBotanica(String familiaBotanica) {
        this.familiaBotanica = familiaBotanica;
    }

    public String getEstadoConservacion() {
        return estadoConservacion;
    }

    public void setEstadoConservacion(String estadoConservacion) {
        this.estadoConservacion = estadoConservacion;
    }

    public String getUsoPrincipal() {
        return usoPrincipal;
    }

    public void setUsoPrincipal(String usoPrincipal) {
        this.usoPrincipal = usoPrincipal;
    }

    public double getAlturaMaximaM() {
        return alturaMaximaM;
    }

    public void setAlturaMaximaM(double alturaMaximaM) {
        this.alturaMaximaM = alturaMaximaM;
    }

    public int getZonaId() {
        return zonaId;
    }

    public void setZonaId(int zonaId) {
        this.zonaId = zonaId;
    }
    
}
