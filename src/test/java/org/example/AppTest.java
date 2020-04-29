package org.example;

import static org.junit.Assert.assertTrue;

import lombok.SneakyThrows;
import org.junit.Test;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import java.io.FileReader;

/**
 * Unit test for simple App.
 */
public class AppTest {
    @SneakyThrows
    @Test
    public void shouldAnswerWithTrue() {
        ScriptEngine engine = new ScriptEngineManager().getEngineByName("nashorn");
        engine.eval(new FileReader("target/extra-resources/dist/Main.js"));

    }
}
