<%@ include file="menu.jsp" %> <!-- Incluye el menú principal -->

<div class="container mt-5">
  <div class="row mb-4">
    <div class="col">
      <div class="card shadow rounded-4 border-0">
        <div class="card-body">
          <h1 class="card-title mb-3 text-primary">Sistema de Registro Forestal</h1>
          <p class="lead">Bienvenido al sistema de gestión y conservación de zonas forestales del Ecuador.</p>
        </div>
      </div>
    </div>
  </div>

  <div class="row g-4">
    <!-- ¿Qué es este sistema? -->
    <div class="col-md-6">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-header bg-success text-white rounded-top-4">
          <h5 class="mb-0">¿Qué es este sistema?</h5>
        </div>
        <div class="card-body">
          <p>
            Esta aplicación web permite registrar, consultar y gestionar información relacionada con zonas forestales,
            especies de árboles y actividades de conservación. Está diseñada para apoyar a organizaciones ambientales,
            instituciones gubernamentales y comunidades interesadas en la preservación de nuestros ecosistemas.
          </p>
        </div>
      </div>
    </div>

    <!-- Tecnologías utilizadas -->
    <div class="col-md-6">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-header bg-primary text-white rounded-top-4">
          <h5 class="mb-0">Tecnologías utilizadas</h5>
        </div>
        <div class="card-body">
          <ul>
            <li><strong>Java EE (JSP/Servlets):</strong> Lógica del lado del servidor.</li>
            <li><strong>MySQL:</strong> Base de datos para zonas, especies y actividades.</li>
            <li><strong>HTML5, CSS3 y Bootstrap:</strong> Interfaz moderna y responsiva.</li>
            <li><strong>JavaScript:</strong> Interacción dinámica.</li>
            <li><strong>Git y GitHub:</strong> Control de versiones y colaboración.</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Funcionalidades del sistema -->
    <div class="col-md-6">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-header bg-info text-white rounded-top-4">
          <h5 class="mb-0">Principales funcionalidades</h5>
        </div>
        <div class="card-body">
          <ul>
            <li>Registro y gestión de zonas forestales.</li>
            <li>Catálogo de especies con información científica.</li>
            <li>Registro de actividades como reforestaciones.</li>
            <li>Consultas filtradas y generación de reportes.</li>
            <li>Interfaz amigable y navegación sencilla.</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Créditos -->
    <div class="col-md-6">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-header bg-secondary text-white rounded-top-4">
          <h5 class="mb-0">Créditos y desarrollo</h5>
        </div>
        <div class="card-body">
          <p>
            Este sistema fue desarrollado como parte del proyecto académico de <strong>Desarrollo Web</strong>
            en la carrera de Ingeniería en Software. El objetivo es combinar la tecnología con la sostenibilidad
            ambiental, promoviendo el cuidado y monitoreo de los recursos forestales del país.
          </p>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>
