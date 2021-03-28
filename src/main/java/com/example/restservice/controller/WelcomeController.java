package com.example.restservice.controller;

import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

	@RequestMapping("/")
	public String home(@RequestParam(value = "name", defaultValue = "home") String name) {
		return "Welcome to Spring Boot";
	}

	@RequestMapping("/date")
	public String date() {
		LocalDateTime localDateTime = LocalDateTime.now();
		return localDateTime.toString();
	}
}