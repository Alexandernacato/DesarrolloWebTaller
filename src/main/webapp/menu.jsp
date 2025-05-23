<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
:root {
    --primary-color: #f8f9fa; 
    --primary-hover: #e9ecef; 
    --accent-color: #005f40; 
    --text-light: #ffffff;
    --text-dark: #333333;
    --transition: 0.3s ease;
}

body {
    font-family: 'Poppins', sans-serif;
    padding-top: 70px; 
}

/* Barra de navegación superior */
.navbar {
    background-color: var(--primary-color);
    padding: 0.7rem 1rem;
    box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
}

.navbar-brand {
    color: var(--accent-color) !important; 
    font-weight: 600;
    font-size: 1.4rem;
    display: flex;
    align-items: center;
}

.navbar-brand i {
    font-size: 1.5rem;
    margin-right: 10px;
    color: var(--accent-color); 
}

.navbar .navbar-toggler {
    border: none;
    color: var(--accent-color); 
}

.navbar .navbar-toggler:focus {
    box-shadow: none;
}

.navbar .navbar-toggler-icon {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3E%3Cpath stroke='rgba(0, 95, 64, 0.85)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E"); /* Cambiado a verde */
}

.navbar-nav .nav-link {
    color: var(--text-dark) !important; 
    font-weight: 500;
    padding: 0.8rem 1.2rem;
    border-radius: 4px;
    margin: 0 2px;
    position: relative;
    transition: var(--transition);
}

.navbar-nav .nav-link:hover,
.navbar-nav .nav-link.active {
    background-color: rgba(0, 95, 64, 0.1); 
    color: var(--accent-color) !important; 
}

.navbar-nav .nav-link.active::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 40px;
    height: 3px;
    background-color: var(--accent-color); 
    border-radius: 3px 3px 0 0;
}

.navbar-nav .nav-link i {
    margin-right: 6px;
    color: var(--accent-color);
}


@media (max-width: 992px) {
    .navbar-collapse {
        background-color: var(--primary-color);
        padding: 1rem;
        border-radius: 8px;
        margin-top: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }
    
    .navbar-nav .nav-link {
        padding: 0.8rem 1rem;
        margin: 4px 0;
    }
    
    .navbar-nav .nav-link.active::after {
        width: 6px;
        height: 80%;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        border-radius: 0 3px 3px 0;
    }
}
</style>


<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <!-- Logo y nombre del sistema -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/Index.jsp">
            <i class="fas fa-tree"></i>
            Conservación Forestal
        </a>
        

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                data-bs-target="#navbarMain" aria-controls="navbarMain" 
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
     
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath eq '/Index.jsp' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/Index.jsp">
                        <i class="fas fa-home"></i> Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/reportes">
                        <i class="fas fa-chart-column"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath eq '/zones' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/zones">
                        <i class="fas fa-map-marked-alt"></i> Zonas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.servletPath eq '/TreeSpecies' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/TreeSpecies">
                        <i class="fas fa-seedling"></i> Especies
                    </a>
                </li>               
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/ConservationActivities">
                        <i class="fas fa-book-open"></i> Actividades de Conservación
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
