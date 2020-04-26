package org.example;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import java.io.FileReader;

/**
 * Hello world!
 *
 */
public class App 
{
    @lombok.SneakyThrows
    public static void main(String[] args )
    {
        System.out.println( "Hello World!" );

        ScriptEngine engine = new ScriptEngineManager().getEngineByName("nashorn");
        engine.eval(new FileReader("a.js"));

    }
}
