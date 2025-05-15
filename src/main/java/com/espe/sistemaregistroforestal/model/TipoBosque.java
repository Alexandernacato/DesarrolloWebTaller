package com.espe.sistemaregistroforestal.model;

public enum TipoBosque {
    SECO("Seco"),
    HUMEDO_TROPICAL("Húmedo Tropical"),
    MONTANO("Montano"),
    MANGLAR("Manglar"),
    OTRO("Otro");

    private final String displayName;

    TipoBosque(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static TipoBosque fromString(String text) {
        for (TipoBosque tipo : TipoBosque.values()) {
            if (tipo.displayName.equalsIgnoreCase(text)) {
                return tipo;
            }
        }
        return OTRO; // Valor por defecto
    }
}
