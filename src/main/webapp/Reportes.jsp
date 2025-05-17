<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="menu.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Reportes Forestales</title>

    <!-- Estilos y Fuentes -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
            padding-top: 70px;
        }
        .dashboard-container {
            padding: 25px;
            margin-top: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        .card-header {
            background-color: #e9ecef;
            border-bottom: 1px solid #dee2e6;
            padding: 15px 20px;
            font-weight: 600;
            font-size: 1.1rem;
            border-radius: 10px 10px 0 0 !important;
            color: #343a40;
        }
        .card-header i {
            color: #007bff;
            margin-right: 10px;
        }
        .table-responsive {
            margin-top: 10px;
        }
        .page-title {
            color: #343a40;
            margin-bottom: 30px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container dashboard-container">
        <h2 class="text-center page-title">Especies existentes en cada Zona</h2>

        <div class="card mt-4">
            <div class="card-header"><i class="fas fa-tree"></i> Especies Registradas por Zona</div>
            <div class="card-body">
                <div class="table-responsive">
                    <c:choose>
                        <c:when test="${not empty reporteEspeciesZonaFijo}">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                  <tr>
                                    <th>Zona</th>
                                    <th>Especie</th>
                                    <th>Nombre Científico</th>
                                  </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="fila" items="${reporteEspeciesZonaFijo}">
                                        <tr>
                                            <c:forEach var="dato" items="${fila.values()}">
                                                <td><c:out value="${dato}" /></td>
                                            </c:forEach>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p class="text-center text-muted">No hay datos de especies por zona disponibles.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
