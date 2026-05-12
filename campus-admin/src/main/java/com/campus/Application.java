package com.campus;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author crazyLee
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class Application
{
    private static final Logger log = LoggerFactory.getLogger(Application.class);

    public static void main(String[] args) {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        var ctx =  SpringApplication.run(Application.class, args);

        String port = ctx.getEnvironment().getProperty("server.port", "8080");
        log.info("CrazyLee started successfully. Local: http://localhost:{}", port);
    }
}
