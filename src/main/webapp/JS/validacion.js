document.addEventListener("DOMContentLoaded", function () {
    // Obtener todos los formularios en la página
    const formularios = document.querySelectorAll("form");

    formularios.forEach(formulario => {
        formulario.addEventListener("submit", function (e) {
            let esValido = true; // Suponemos que todo está bien

            // Obtener todos los campos requeridos dentro del formulario
            const campos = formulario.querySelectorAll("[required]");

            // Validar cada campo
            for (let campo of campos) {
                let valor = campo.value.trim();
                let tipo = campo.getAttribute("type") || campo.tagName.toLowerCase();

                // Validar campos obligatorios
                if (valor === "") {
                    alert(`El campo "${campo.name}" es obligatorio.`);
                    campo.focus();
                    esValido = false;
                    break;
                }

                // Validar caracteres permitidos para texto (solo letras, números y algunos caracteres especiales)
                if ((tipo === "text" || tipo === "textarea") && /\d/.test(valor)) {
                    alert(`El campo "${campo.name}" no puede contener números.`);
                    campo.focus();
                    esValido = false;
                    break;
                }

                if ((tipo === "text" || tipo === "textarea") && !/^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s.,-]*$/.test(valor)) {
                    alert(`El campo "${campo.name}" contiene caracteres no permitidos.`);
                    campo.focus();
                    esValido = false;
                    break;
                }

                // Validar números positivos (para el campo de área o cualquier número)
                if (tipo === "number" && (parseFloat(valor) <= 0 || isNaN(valor))) {
                    alert(`El campo "${campo.name}" debe ser un número positivo.`);
                    campo.focus();
                    esValido = false;
                    break;
                }

                // Validar que la fecha sea válida
                if (tipo === "date" && !/^\d{4}-\d{2}-\d{2}$/.test(valor)) {
                    alert(`El campo "${campo.name}" debe tener una fecha válida (yyyy-mm-dd).`);
                    campo.focus();
                    esValido = false;
                    break;
                }

                // Validar correo electrónico
                if (tipo === "email" && !/^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$/.test(valor)) {
                    alert(`El campo "${campo.name}" debe ser un correo válido.`);
                    campo.focus();
                    esValido = false;
                    break;
                }
            }

            // Si algo no es válido, evitamos el envío del formulario
            if (!esValido) {
                e.preventDefault();
            }
        });
    });
});
