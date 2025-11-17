<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultado - Desafío del OVNI</title>
    <style>
        body { font-family: Arial, sans-serif; background:#000814; color:#e6f0ff; display:flex; align-items:center; justify-content:center; height:100vh; margin:0; }
        .panel { width:820px; max-width:95%; background:linear-gradient(180deg, rgba(255,255,255,0.02), rgba(0,0,0,0.15)); padding:36px; border-radius:14px; box-shadow:0 10px 40px rgba(0,0,0,0.6); text-align:center; }
        .badge { width:160px; height:160px; margin:0 auto 20px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-weight:800; font-size:28px; text-transform:uppercase; color:#001; }
        .badge.win { background:linear-gradient(135deg,#7efcbf,#00d1b2); }
        .badge.lose { background:linear-gradient(135deg,#ff8b8b,#ff4b4b); color:#fff; }
        h1.result { margin:6px 0 10px; font-size:44px; letter-spacing:2px; text-transform:uppercase; }
        p.lead { margin:0 0 18px; color:#cfeafb; font-size:18px; }
        .details { text-align:left; background:rgba(255,255,255,0.02); padding:14px; border-radius:8px; color:#cfeafb; margin:18px auto; max-width:600px; }
        .btn { display:inline-block; padding:12px 22px; border-radius:8px; border:none; cursor:pointer; font-weight:700; text-decoration:none; color:#001; background:#00e0ff; margin-top:14px; }
        .btn.restart { background:#00e0ff; }
        .result-sub { font-size:13px; color:#a7d9ee; margin-top:8px; text-transform:none; }
        .neutral { background:linear-gradient(135deg,#98a8ff,#6e7bff); color:#fff; }
    </style>
</head>
<body>
<div class="panel">
    <c:set var="msg" value="${sessionScope.lastResult}" />
    <c:choose>
        <c:when test="${msg == 'victoria' || msg == 'victoria_pacifica' || msg == 'final_alianza'}">
            <div class="badge win">¡OK!</div>
            <h1 class="result">Victoria</h1>
            <p class="lead">Has alcanzado un final exitoso. ¡Bien hecho, explorador!</p>
            <p class="result-sub">Detalle: <c:out value="${msg}" /></p>
        </c:when>

        <c:when test="${msg == 'derrota' || msg == 'derrota_tragica' || msg == 'game_over'}">
            <div class="badge lose">✖</div>
            <h1 class="result">Derrota</h1>
            <p class="lead">No fue esta vez. Puedes intentarlo de nuevo.</p>
            <p class="result-sub">Detalle: <c:out value="${msg}" /></p>
        </c:when>

        <c:otherwise>
            <div class="badge neutral">?</div>
            <h1 class="result">Resultado</h1>
            <p class="lead">Estado desconocido.</p>
            <p class="result-sub">Clave: <c:out value="${msg}" /></p>
        </c:otherwise>
    </c:choose>

    <div class="details">
        <p><strong>Información del jugador</strong></p>
        <p>Nombre: <c:out value="${sessionScope.playerName}" default="(sin nombre)"/></p>
        <p>Juegos jugados: <c:out value="${sessionScope.gamesPlayed}" default="0"/></p>
        <p>IP: <c:out value="${sessionScope.ipAddress}" default="(no disponible)"/></p>
    </div>

    <div>
        <form action="restart" method="get" style="display:inline;">
            <button type="submit" class="btn restart">REINICIAR JUEGO</button>
        </form>
    </div>
</div>
</body>
</html>