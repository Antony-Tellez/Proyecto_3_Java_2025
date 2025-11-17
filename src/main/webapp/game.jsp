<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Desafío del OVNI</title>
    <style>
        body { font-family: Arial, sans-serif; background:#001; color:#fff; text-align:center; padding:40px; }
        .panel { background: rgba(255,255,255,0.03); padding:30px; border-radius:12px; width:720px; margin:0 auto; box-shadow:0 0 30px rgba(0,200,255,0.08); }
        h1 { color:#00e0ff; }
        .msg { margin:18px 0; font-size:16px; white-space:pre-wrap; }
        .btn { display:block; width:70%; margin:10px auto; padding:12px; border-radius:8px; border:none; background:#00e0ff; color:#000; font-weight:600; cursor:pointer; }
        .btn:hover { background:#00c4d4; transform:translateY(-2px); }
        .danger { background:#ff6b6b; color:#fff; }
        .info { margin-top:20px; background:rgba(255,255,255,0.02); padding:12px; border-radius:8px; text-align:left; color:#cfeafb; }
        input[name="name"] { padding:10px; width:60%; border-radius:6px; border:1px solid #ccc; }
    </style>
</head>
<body>
<div class="panel">
    <h1>👽 Desafío del OVNI 👽</h1>

    <div class="msg">
        <c:choose>
            <c:when test="${message == 'start'}">
                <p>Bienvenido al juego. Introduce tu nombre para empezar:</p>
                <form action="game" method="post">
                    <input type="text" name="name" placeholder="Tu nombre" required/>
                    <br><br>
                    <button type="submit" name="choice" value="aceptar" class="btn">✅ Aceptar el desafío</button>
                    <button type="submit" name="choice" value="rechazar" class="btn danger">❌ Rechazar el desafío</button>
                </form>
            </c:when>

            <c:when test="${message == 'challenge_accepted'}">
                <p>Has aceptado el desafío. ¿Qué harás primero?</p>
                <form action="game" method="post">
                    <button type="submit" name="choice" value="puente" class="btn">Ir al puente del capitán</button>
                    <button type="submit" name="choice" value="explorar" class="btn">Explorar la nave antes de subir</button>
                    <button type="submit" name="choice" value="negarse" class="btn danger">Negarte a subir</button>
                </form>
            </c:when>

            <c:when test="${message == 'step1_puente' || message == 'step1_explorar'}">
                <p>Subiste al puente del capitán. ¿Quién eres tú?</p>
                <form action="game" method="post">
                    <button type="submit" name="choice" value="verdad" class="btn">Decir la verdad</button>
                    <button type="submit" name="choice" value="mentir" class="btn danger">Mentir sobre tu identidad</button>
                    <c:if test="${sessionScope.logic.exploredShip}">
                        <button type="submit" name="choice" value="pregunta" class="btn">Responder con otra pregunta</button>
                    </c:if>
                </form>
            </c:when>

            <c:when test="${message == 'step2_pregunta'}">
                <p>¿Por qué deberíamos confiar en ti?</p>
                <form action="game" method="post">
                    <button type="submit" name="choice" value="pacifico" class="btn">Demostrar intenciones pacíficas</button>
                    <button type="submit" name="choice" value="escapar" class="btn danger">Intentar escapar</button>
                    <button type="submit" name="choice" value="prueba" class="btn">Pedir pruebas de buena voluntad</button>
                </form>
            </c:when>

            <c:when test="${message == 'step3_ayuda' || message == 'step3_prueba'}">
                <p>Ahora recuerdas parte de quién eres. ¿Qué harás?</p>
                <form action="game" method="post">
                    <button type="submit" name="choice" value="ayuda" class="btn">Aceptar su ayuda</button>
                    <button type="submit" name="choice" value="quedarte" class="btn">Quedarte con ellos</button>
                    <button type="submit" name="choice" value="sabotear" class="btn danger">Desconfiar y sabotear</button>
                </form>
            </c:when>

            <c:when test="${message == 'victoria' || message == 'victoria_pacifica' || message == 'final_alianza'}">
                <p>🏆 ¡Victoria o final alternativo alcanzado!</p>
                <form action="restart" method="get">
                    <button type="submit" class="btn">Reiniciar juego</button>
                </form>
            </c:when>

            <c:when test="${message == 'derrota' || message == 'derrota_tragica' || message == 'game_over'}">
                <p>❌ Derrota</p>
                <form action="restart" method="get">
                    <button type="submit" class="btn">Reiniciar juego</button>
                </form>
            </c:when>

            <c:otherwise>
                <p>⚠️ Opción inválida. Por favor selecciona una de las opciones disponibles.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="info">
            <p><strong>Información del jugador:</strong></p>
            <p>Nombre: <c:out value="${sessionScope.playerName}" /></p>
            <p>Juegos jugados: <c:out value="${sessionScope.gamesPlayed}" /></p>
            <p>IP: <c:out value="${sessionScope.ipAddress}" /></p>
        </div>
</div>
</body>
</html>
