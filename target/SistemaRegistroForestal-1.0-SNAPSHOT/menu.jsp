<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
/* === Variables base === */
:root {
    --sidebar-bg: #1e2a38;
    --sidebar-hover: #273747;
    --accent-color: #00b894;
    --text-color: #ecf0f1;
    --transition: 0.3s ease;
    --header-height: 60px;
}

/* Reset básico */
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f4f6f8;
    transition: margin-left var(--transition);
}

.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    width: 240px;
    background-color: var(--sidebar-bg);
    padding-top: var(--header-height);
    transition: transform var(--transition);
    z-index: 1000;
    box-shadow: 2px 0 6px rgba(0, 0, 0, 0.1);
}

.sidebar-header {
    position: fixed;
    top: 0;
    left: 0;
    height: var(--header-height);
    width: 240px;
    background-color: #162029;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--text-color);
    font-size: 18px;
    font-weight: bold;
    border-bottom: 1px solid #111;
    z-index: 1100;
}

.sidebar a {
    display: flex;
    align-items: center;
    padding: 14px 20px;
    text-decoration: none;
    color: var(--text-color);
    transition: background var(--transition);
    font-size: 15px;
}

.sidebar a:hover {
    background-color: var(--sidebar-hover);
}

.sidebar a svg {
    margin-right: 12px;
    width: 20px;
    height: 20px;
    fill: var(--accent-color);
    transition: fill var(--transition);
}

.sidebar a:hover svg {
    fill: #ffffff;
}

.menu-toggle {
    display: none;
    position: fixed;
    top: 15px;
    left: 15px;
    z-index: 1200;
    cursor: pointer;
    flex-direction: column;
}

.menu-toggle span {
    height: 3px;
    width: 25px;
    background: var(--sidebar-bg);
    margin: 5px 0;
    border-radius: 2px;
    transition: background var(--transition);
}

@media (max-width: 768px) {
    .sidebar {
        transform: translateX(-100%);
    }

    .sidebar.active {
        transform: translateX(0);
    }

    .menu-toggle {
        display: flex;
    }

    body.menu-open {
        margin-left: 240px;
    }
}

@media (min-width: 769px) {
    body {
        margin-left: 240px;
    }
}
</style>

<!-- Botón hamburguesa -->
<div class="menu-toggle" onclick="toggleSidebar()">
    <span></span>
    <span></span>
    <span></span>
</div>

<!-- Sidebar completo -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        🌿 EcoGestión
    </div>
    <a href="${pageContext.request.contextPath}/index.jsp">
        <svg viewBox="0 0 24 24"><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg>
        Inicio
    </a>
    <a href="${pageContext.request.contextPath}/zones">
        <svg viewBox="0 0 24 24"><path d="M4 4h6v6H4V4zm0 10h6v6H4v-6zm10 0h6v6h-6v-6zm0-10h6v6h-6V4z"/></svg>
        Zonas
    </a>
    <a href="${pageContext.request.contextPath}/TreeSpecies">
        <svg viewBox="0 0 24 24"><path d="M12 2a10 10 0 0 1 10 10A10 10 0 0 1 12 22A10 10 0 0 1 2 12A10 10 0 0 1 12 2z"/></svg>
        Especies
    </a>
    <a href="${pageContext.request.contextPath}//ConservationActivities">
        <svg viewBox="0 0 24 24"><path d="M3 13h2v-2H3v2zm4 0h14v-2H7v2zm-4 4h2v-2H3v2zm4 0h14v-2H7v2z"/></svg>
        Actividades
    </a>
</div>

<!-- Script -->
<script>
function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    sidebar.classList.toggle("active");
    document.body.classList.toggle("menu-open");
}


</script>
