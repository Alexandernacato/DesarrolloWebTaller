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

    // Método para convertir un String de la BD/Formulario al Enum
    public static TipoBosque fromString(String text) {
        if (text != null) {
            for (TipoBosque b : TipoBosque.values()) {
                // Compara con el nombre del enum o con su displayName
                if (text.equalsIgnoreCase(b.displayName) || text.equalsIgnoreCase(b.name())) {
                    return b;
                }
            }
        }
        // Retorna OTRO por defecto si no se encuentra o el texto es nulo,
        // o podrías lanzar IllegalArgumentException si prefieres un manejo de error estricto.
        return OTRO;
    }

    @Override
    public String toString() {
        return displayName;
    }
}
