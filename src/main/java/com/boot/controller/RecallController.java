package com.boot.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RecallController {
	@RequestMapping("/main")
	public String list(Model model, HttpServletRequest request) {
		
		return "main";
	}
}