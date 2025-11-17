package com.example.ufo.controller;

import com.example.ufo.model.GameLogic;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RestartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        // Reiniciar solo el estado del juego, conservar nombre/ip/contador
        session.setAttribute("logic", new GameLogic());
        session.removeAttribute("lastResult");
        session.removeAttribute("message");

        response.sendRedirect("index.jsp");
    }
}
