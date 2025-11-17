package com.example.ufo.model;

public class GameLogic {
    private int step;              // Indica la etapa del juego
    private boolean exploredShip;  // Si exploró la nave
    private boolean askedQuestion; // Si desbloqueó la opción secreta
    private boolean gameOver;      // Si el juego terminó

    public GameLogic() {
        reset();
    }

    public void reset() {
        step = 0;
        exploredShip = false;
        askedQuestion = false;
        gameOver = false;
    }

    /**
     * Procesa la elección del jugador y devuelve un mensaje clave esperado por los JSP.
     * @param choice opción enviada desde el JSP
     * @return clave de mensaje (ej: "challenge_accepted", "step1_puente", "victoria", "derrota", ...)
     */
    public String nextStep(String choice) {
        if (choice == null || choice.trim().isEmpty()) {
            return "select_none";
        }

        choice = choice.toLowerCase().trim();

        if (gameOver) {
            return "game_over";
        }

        switch (step) {
            case 0: // Desafío inicial
                if (choice.contains("acept") || choice.contains("accept")) {
                    step = 1;
                    return "challenge_accepted";
                } else if (choice.contains("rechaz") || choice.contains("reject")) {
                    gameOver = true;
                    return "derrota";
                } else {
                    return "invalid_choice_0";
                }

            case 1: // Decisión inicial después de aceptar
                if (choice.contains("puente")) {
                    step = 2;
                    return "step1_puente";
                } else if (choice.contains("explor")) {
                    exploredShip = true;
                    step = 2;
                    return "step1_explorar";
                } else if (choice.contains("negar") || choice.contains("rechaz")) {
                    gameOver = true;
                    return "derrota";
                } else {
                    return "invalid_choice_1";
                }

            case 2: // Puente del capitán
                if (choice.contains("verdad")) {
                    gameOver = true;
                    return "victoria";
                } else if (choice.contains("mentir") || choice.contains("menti")) {
                    gameOver = true;
                    return "derrota_tragica";
                } else if (exploredShip && choice.contains("pregunt")) {
                    askedQuestion = true;
                    step = 3;
                    return "step2_pregunta";
                } else {
                    return "invalid_choice_2";
                }

            case 3: // Pregunta secreta
                if (choice.contains("pacif")) {
                    step = 4;
                    return "step3_ayuda";
                } else if (choice.contains("prueba")) {
                    step = 4;
                    return "step3_prueba";
                } else if (choice.contains("escap")) {
                    gameOver = true;
                    return "derrota";
                } else {
                    return "invalid_choice_3";
                }

            case 4: // Desenlace final
                if (choice.contains("ayuda")) {
                    gameOver = true;
                    return "victoria_pacifica";
                } else if (choice.contains("qued") || choice.contains("quedarte")) {
                    gameOver = true;
                    return "final_alianza";
                } else if (choice.contains("sabotar") || choice.contains("desconfi") || choice.contains("sabot")) {
                    gameOver = true;
                    return "derrota_tragica";
                } else {
                    return "invalid_choice_4";
                }

            default:
                return "game_over";
        }
    }

    /**
     * Indica si un resultado corresponde a un estado final del juego.
     * @param result clave devuelta por nextStep
     * @return true si el juego terminó
     */
    public boolean isGameOver(String result) {
        if (gameOver) return true;
        if (result == null) return false;
        switch (result) {
            case "derrota":
            case "derrota_tragica":
            case "victoria":
            case "victoria_pacifica":
            case "final_alianza":
            case "game_over":
                return true;
            default:
                return false;
        }
    }

    // Getters para JSP si quieres mostrar estado adicional
    public int getStep() { return step; }
    public boolean isExploredShip() { return exploredShip; }
    public boolean isAskedQuestion() { return askedQuestion; }
}