package com.boot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/centers")
public class CentersController {

    @GetMapping("/about")
    public String about() {
        // JSP 파일 경로: /WEB-INF/views/centers/about.jsp
        return "centers/about";
    }
}