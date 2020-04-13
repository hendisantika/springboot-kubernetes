package com.hendisantika.springbootkubernetes.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

/**
 * Created by IntelliJ IDEA.
 * Project : springboot-kubernetes
 * User: hendisantika
 * Email: hendisantika@gmail.com
 * Telegram : @hendisantika34
 * Date: 14/04/20
 * Time: 04.59
 */
@RestController
@RequestMapping
public class IndexController {
    @GetMapping("/")
    public String index() {
        return "Spring Boot Kubernetes Sample. " + LocalDateTime.now();
    }
}
