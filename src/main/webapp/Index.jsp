<%@ include file="menu.jsp" %> <!-- Incluye el men� principal -->

<div class="container mt-5">
  <div class="row mb-4">
    <div class="col">
      <div class="card shadow rounded-4 border-0">
        <div class="card-body">
          <h1 class="card-title mb-3 text-primary">Sistema de Registro Forestal</h1>
          <p class="lead">Bienvenido al sistema de gesti�n y conservaci�n de zonas forestales del Ecuador.</p>
        </div>
      </div>
    </div>
  </div>

  <div class="row g-4">
    <!-- �Qu� es este sistema? -->
    <div class="col-md-6">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-header bg-success text-white rounded-top-4">
          <h5 class="mb-0">�Qu� es este sistema?</h5>
        </div>
        <div class="card-body">
          <p>
            Esta aplicaci�n web permite registrar, consultar y gestionar informaci�n relacionada con zonas forestales,
            especies de �rboles y actividades de conservaci�n. Est� dise�ada para apoyar a organizaciones ambientales,
            instituciones gubernamentales y comunidades interesadas en la preservaci�n de nuestros ecosistemas.
          </p>
        </div>
      </div>
    </div>

    <!-- Tecnolog�as utilizadas -->
    <div class="col-md-6">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-header bg-primary text-white rounded-top-4">
          <h5 class="mb-0">Tecnolog�as utilizadas</h5>
        </div>
        <div class="card-body">
          <ul>
            <li><strong>Java EE (JSP/Servlets):</strong> L�gica del lado del servidor.</li>
            <li><strong>MySQL:</strong> Base de datos para zonas, especies y actividades.</li>
            <li><strong>HTML5, CSS3 y Bootstrap:</strong> Interfaz moderna y responsiva.</li>
            <li><strong>JavaScript:</strong> Interacci�n din�mica.</li>
            <li><strong>Git y GitHub:</strong> Control de versiones y colaboraci�n.</li>
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
            <li>Registro y gesti�n de zonas forestales.</li>
            <li>Cat�logo de especies con informaci�n cient�fica.</li>
            <li>Registro de actividades como reforestaciones.</li>
            <li>Consultas filtradas y generaci�n de reportes.</li>
            <li>Interfaz amigable y navegaci�n sencilla.</li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Cr�ditos -->
    <div class="col-md-6">
      <div class="card h-100 shadow-sm rounded-4">
        <div class="card-header bg-secondary text-white rounded-top-4">
          <h5 class="mb-0">Cr�ditos y desarrollo</h5>
        </div>
        <div class="card-body">
          <p>
            Este sistema fue desarrollado como parte del proyecto acad�mico de <strong>Desarrollo Web</strong>
            en la carrera de Ingenier�a en Software. El objetivo es combinar la tecnolog�a con la sostenibilidad
            ambiental, promoviendo el cuidado y monitoreo de los recursos forestales del pa�s.
          </p>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>
