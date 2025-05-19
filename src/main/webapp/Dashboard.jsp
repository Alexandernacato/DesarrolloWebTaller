<%@page import="java.util.Map"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard - Actividades de Conservación</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Dashboard: Cantidad de Zonas por Tipo de Actividad</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Tipo de Actividad</th>
                    <th>Cantidad de Zonas</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Map<String, Integer> datos = (Map<String, Integer>) request.getAttribute("datosDashboard");
                    if (datos != null) {
                        for (Map.Entry<String, Integer> entry : datos.entrySet()) {
                %>
                <tr>
                    <td><%= entry.getKey() %></td>
                    <td><%= entry.getValue() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
