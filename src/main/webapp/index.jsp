<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Desafío del OVNI - Inicio</title>
    <style>
        body { font-family: Arial, sans-serif; background:#001; color:#fff; text-align:center; padding:40px; }
        .panel { background: rgba(255,255,255,0.03); padding:30px; border-radius:12px; width:720px; margin:0 auto; box-shadow:0 0 30px rgba(0,200,255,0.08); }
        h1 { color:#00e0ff; }
        .btn { display:block; width:70%; margin:10px auto; padding:12px; border-radius:8px; border:none; background:#00e0ff; color:#000; font-weight:600; cursor:pointer; }
        .btn:hover { background:#00c4d4; transform:translateY(-2px); }
        .danger { background:#ff6b6b; color:#fff; }
        input[name="name"] { padding:10px; width:60%; border-radius:6px; border:1px solid #ccc; }
        .small { font-size:14px; color:#cfeafb; margin-top:8px; }
    </style>
</head>
<body>
<div class="panel">
    <h1>👽 Desafío del OVNI 👽</h1>
    <p class="small">Has perdido la memoria. Introduce tu nombre y decide si aceptas el desafío.</p>

    <form action="game" method="post">
        <input type="text" name="name" placeholder="Tu nombre" value="${sessionScope.playerName}" required />
        <br><br>
        <button type="submit" name="choice" value="aceptar" class="btn">✅ Aceptar el desafío</button>
        <button type="submit" name="choice" value="rechazar" class="btn danger">❌ Rechazar el desafío</button>
    </form>

    <div class="small" style="margin-top:18px;">
        <p>Si ya jugaste, tu IP y contador se guardan en la sesión.</p>
    </div>
</div>
</body>
</html>