package com.example.ufo;

import com.example.ufo.model.GameLogic;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class GameLogicTest {

    @Test
    public void testVictoryCondition() {
        GameLogic logic = new GameLogic();
        assertEquals("challenge_accepted", logic.nextStep("aceptar"));
        assertEquals("step1_puente", logic.nextStep("puente"));
        String finalResult = logic.nextStep("verdad");
        assertEquals("victoria", finalResult);
        assertTrue(logic.isGameOver(finalResult));
    }

    @Test
    public void testDefeatCondition() {
        GameLogic logic = new GameLogic();
        assertEquals("challenge_accepted", logic.nextStep("accept")); // inglés también funciona
        assertEquals("step1_puente", logic.nextStep("puente"));
        String finalResult = logic.nextStep("mentir");
        assertEquals("derrota_tragica", finalResult);
        assertTrue(logic.isGameOver(finalResult));
    }
}
