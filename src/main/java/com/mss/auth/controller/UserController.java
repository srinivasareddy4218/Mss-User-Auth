package com.mss.auth.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController()
public class UserController {

    @Value("${spring.security.user.name}")
    private String userName;

    @GetMapping("/")
    public String userHello(){
        return "Hello " + userName.toUpperCase();
    }
}
