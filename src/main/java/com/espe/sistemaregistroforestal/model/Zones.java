package com.espe.sistemaregistroforestal.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Zones {
    private int id;
    private String nombre;
    private String ubicacion;
    private String provincia;
    private TipoBosque tipo_bosque; // MODIFICADO: de String a TipoBosque
    private BigDecimal area_ha;
    private String descripcion;
    private Date fecha_registro;

    // Constructor vacío - NECESARIO para instanciar desde ZonesDAO
    public Zones() {
        // Constructor vacío necesario
    }

    // Constructores
    public Zones(int id, String nombre, String ubicacion, String provincia, TipoBosque tipo_bosque, BigDecimal area_ha, String descripcion, Date fecha_registro) {
        this.id = id;
        this.nombre = nombre;
        this.ubicacion = ubicacion;
        this.provincia = provincia;
        this.tipo_bosque = tipo_bosque; // MODIFICADO
        this.area_ha = area_ha;
        this.descripcion = descripcion;
        this.fecha_registro = fecha_registro;
    }

    // Getters y Setters para todos los campos
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getUbicacion() { return ubicacion; }
    public void setUbicacion(String ubicacion) { this.ubicacion = ubicacion; }
    public String getProvincia() { return provincia; }
    public void setProvincia(String provincia) { this.provincia = provincia; }
    public TipoBosque getTipo_bosque() { return tipo_bosque; } // MODIFICADO: Devuelve Enum
    public void setTipo_bosque(TipoBosque tipo_bosque) { this.tipo_bosque = tipo_bosque; } // MODIFICADO: Acepta Enum
    public BigDecimal getArea_ha() { return area_ha; }
    public void setArea_ha(BigDecimal area_ha) { this.area_ha = area_ha; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public Date getFecha_registro() { return fecha_registro; }
    public void setFecha_registro(Date fecha_registro) { this.fecha_registro = fecha_registro; }
}