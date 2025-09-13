package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {
    
    @GetMapping("/")
    public String home() {
        return "Spring Boot Docker Demo Application is Running! (Java 17)";
    }
    
    @GetMapping("/health")
    public String health() {
        return "Application is Healthy!";
    }
    
    @GetMapping("/actuator/health")
    public String actuatorHealth() {
        return "{\"status\": \"UP\"}";
    }

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
