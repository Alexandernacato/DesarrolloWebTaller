package com.espe.sistemaregistroforestal.model;

public enum TipoActividad {
    REFORESTACION("Reforestación"),
    MONITOREO("Monitoreo"),
    CONTROL_ESPECIES_INVASORAS("Control de especies invasoras"),
    EDUCACION_AMBIENTAL("Educación ambiental"),
    OTRO("Otro");

    private final String displayName;

    TipoActividad(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
    
    public static TipoActividad fromString(String text) {
        if (text != null) {
            for (TipoActividad t : TipoActividad.values()) {
                if (text.equalsIgnoreCase(t.displayName) || text.equalsIgnoreCase(t.name())) {
                    return t;
                }
            }
        }
        return OTRO;
    }

    @Override
    public String toString() {
        return displayName;
    }
}
