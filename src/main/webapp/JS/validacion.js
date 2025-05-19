document.addEventListener("DOMContentLoaded", function () {

    const formularios = document.querySelectorAll("form");

    formularios.forEach(formulario => {
        formulario.addEventListener("submit", function (e) {
            let esValido = true; 

          
            const campos = formulario.querySelectorAll("[required]");

            
            for (let campo of campos) {
                let valor = campo.value.trim();
                let tipo = campo.getAttribute("type") || campo.tagName.toLowerCase();

              
                if (valor === "") {
                    alert(`El campo "${campo.name}" es obligatorio.`);
                    campo.focus();
                    esValido = false;
                    break;
                }

          
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

        
                if (tipo === "number" && (parseFloat(valor) <= 0 || isNaN(valor))) {
                    alert(`El campo "${campo.name}" debe ser un número positivo.`);
                    campo.focus();
                    esValido = false;
                    break;
                }

              
                if (tipo === "date" && !/^\d{4}-\d{2}-\d{2}$/.test(valor)) {
                    alert(`El campo "${campo.name}" debe tener una fecha válida (yyyy-mm-dd).`);
                    campo.focus();
                    esValido = false;
                    break;
                }

              
                if (tipo === "email" && !/^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$/.test(valor)) {
                    alert(`El campo "${campo.name}" debe ser un correo válido.`);
                    campo.focus();
                    esValido = false;
                    break;
                }
            }

    
            if (!esValido) {
                e.preventDefault();
            }
        });
    });
});
