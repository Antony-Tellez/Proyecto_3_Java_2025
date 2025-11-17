package com.example.ufo.controller;

import com.example.ufo.model.GameLogic;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class GameServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Si el formulario envía un nombre, actualizarlo en sesión (mantener último nombre ingresado)
        String paramName = request.getParameter("name");
        if (paramName != null && !paramName.trim().isEmpty()) {
            session.setAttribute("playerName", paramName.trim());
        }

        // Obtener o crear GameLogic por sesión (no compartir entre usuarios)
        GameLogic logic = (GameLogic) session.getAttribute("logic");
        if (logic == null) {
            logic = new GameLogic();
            session.setAttribute("logic", logic);
        }

        // Guardar IP en la sesión si aún no está
        String ipAddress = (String) session.getAttribute("ipAddress");
        if (ipAddress == null) {
            ipAddress = request.getRemoteAddr();
            session.setAttribute("ipAddress", ipAddress);
        }

        String player = (String) session.getAttribute("playerName");

        // Inicializar contador de juegos si no existe
        if (session.getAttribute("gamesPlayed") == null) {
            session.setAttribute("gamesPlayed", 0);
        }

        // --- Paso 2: Tomar la decisión del jugador ---
        String choice = request.getParameter("choice");

        // Si no hay elección aún, mostramos la primera pregunta en game.jsp
        if (choice == null) {
            request.setAttribute("message",
                    "Has perdido la memoria. ¿Aceptarás el desafío del OVNI?");
            request.getRequestDispatcher("game.jsp").forward(request, response);
            return;
        }

        // --- Paso 3: Procesar la decisión usando la lógica de la sesión ---
        String result = logic.nextStep(choice);

        // Re-guardar la lógica en la sesión para asegurar que JSP vea estado actualizado
        session.setAttribute("logic", logic);

        // Guardar mensaje en sesión (y en request antes del forward)
        session.setAttribute("message", result);
        request.setAttribute("message", result);

        // --- Paso 4: Verificar si el juego termina ---
        if (logic.isGameOver(result)) {
            Integer games = (Integer) session.getAttribute("gamesPlayed");
            if (games == null) games = 0;
            games = games + 1;
            session.setAttribute("gamesPlayed", games);
            session.setAttribute("lastResult", result);
            response.sendRedirect(request.getContextPath() + "/result.jsp");
        } else {
            request.getRequestDispatcher("/game.jsp").forward(request, response);
        }
    }
}