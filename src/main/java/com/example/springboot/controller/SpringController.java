package com.example.springboot.controller;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SpringController {

	private transient Integer val = 0;
	
	@GetMapping(value = "/")
	public String getValue() {

		val++;
		String result = "Mr. DevOps" + val;
		return result;
	}
}
