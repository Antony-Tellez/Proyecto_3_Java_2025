package com.example.ufo.util;

public class GameState {
    private boolean challengeAccepted;
    private String message;

    public GameState() {
        this.challengeAccepted = false;
        this.message = "";
    }

    public boolean isChallengeAccepted() {
        return challengeAccepted;
    }

    public void setChallengeAccepted(boolean challengeAccepted) {
        this.challengeAccepted = challengeAccepted;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}