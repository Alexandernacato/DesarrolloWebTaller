<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Menú Principal</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/material-design-iconic-font@2.2.0/dist/css/material-design-iconic-font.min.css">
  <style>
    /* Estilo base del menú */
    body {
      margin: 0;
      font-family: Arial, sans-serif;
    }

    #viewport {
      display: flex;
      height: 100vh;
    }

    #sidebar {
      width: 250px;
      background-color: #333;
      color: #fff;
      padding: 20px;
      position: fixed;
      height: 100%;
    }

    #sidebar header {
      font-size: 24px;
      font-weight: bold;
      color: #fff;
    }

    .nav {
      list-style: none;
      padding: 0;
    }

    .nav li {
      margin: 15px 0;
    }

    .nav li a {
      color: #fff;
      text-decoration: none;
      font-size: 18px;
      display: flex;
      align-items: center;
    }

    .nav li a:hover {
      text-decoration: underline;
    }

    /* Íconos del menú */
    .nav li a i {
      margin-right: 10px;
    }

    /* Estilo para el contenido */
    #content {
      margin-left: 250px;
      padding: 20px;
      width: 100%;
    }

    /* Estilos del icono de menú en pantallas pequeñas */
    #menu-icon {
      display: none;
      background: #333;
      width: 30px;
      height: 30px;
      position: absolute;
      top: 15px;
      right: 20px;
      cursor: pointer;
    }

    #menu-icon span {
      background: white;
      display: block;
      height: 4px;
      margin: 5px 0;
      width: 100%;
    }

    /* Responsive */
    @media screen and (max-width: 768px) {
      #sidebar {
        width: 200px;
      }

      #content {
        margin-left: 0;
      }

      #menu-icon {
        display: block;
      }

      #sidebar {
        display: none;
      }

      #sidebar.active {
        display: block;
      }
    }
  </style>
</head>
<body>
  <div id="viewport">
    <!-- Sidebar -->
    <div id="sidebar">
      <header>
        <a href="index.jsp">Mi App</a>
      </header>
      <ul class="nav">
        <li><a href="index.jsp"><i class="zmdi zmdi-view-dashboard"></i> Inicio</a></li>
        <li><a href="Activities.jsp"><i class="zmdi zmdi-calendar"></i> Actividades</a></li>
        <li><a href="TreeSpecies.jsp"><i class="zmdi zmdi-nature-people"></i> Especies</a></li>
        <li><a href="Zones.jsp"><i class="zmdi zmdi-map"></i> Zonas</a></li>
      </ul>
    </div>
    
    <!-- Contenido -->
    <div id="content">
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="#"><i class="zmdi zmdi-notifications text-danger"></i></a></li>
            <li><a href="#">Usuario</a></li>
          </ul>
        </div>
      </nav>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $('#header').prepend('<div id="menu-icon"><span class="first"></span><span class="second"></span><span class="third"></span></div>');
    $("#menu-icon").on("click", function(){
      $("nav").slideToggle();
      $(this).toggleClass("active");
    });
  </script>
</body>
      <!-- Aquí irá el contenido principal de cada página -->
