package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boot.dto.ComplainDTO;
import com.boot.service.ComplainService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ComplainController {
	
	@Autowired
	private ComplainService service;
	
	
	
	@RequestMapping("/complain_write")
	public String write(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# complain_write");
		log.info("@# param=>"+param);
		
		service.complain_write(param);
		
		return "redirect:complain_list";
	}
	
	
	@RequestMapping("/complain_write_view")
	public String write_view() {
		log.info("@# complain_write_view");
		
		return "complain_write_view";
	}

	@RequestMapping("/complain_content_view")
	public String complain_content_view(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# complain_content_view()");
		log.info("@# param=>"+param);
		
		ComplainDTO dto = service.contentView(param);
		model.addAttribute("content_view", dto);
		
		return "complain_content_view";
	}
	
	@RequestMapping("/complain_list")
	public String complain_list(Model model, HttpServletRequest request) {
		log.info("@# complain_list");
		
			
		ArrayList<ComplainDTO> list = service.complain_list();
		model.addAttribute("list", list);
		
		return "complain_list";
	}

	@RequestMapping("/complain_content_modify")
	public String complain_content_modify(@RequestParam HashMap<String, String> param, RedirectAttributes rttr, Model model) {
		log.info("@# complain_content_modify()");
		log.info("@# param=>"+param);
		
		ArrayList<ComplainDTO> find_modify_content = service.find_modify_content(param);
		model.addAttribute("m_param", find_modify_content);
		
		
		return "complain_content_modify";
	}
	
	@RequestMapping("/complain_modify")
		public String complain_modify(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
			log.info("@# complain_modify()");
			log.info("@# param=>"+param);
			
			service.complain_modify(param);
			
			return "redirect:complain_list";
	}
	
	@RequestMapping("/complain_delete")
	public String complain_delete(@RequestParam HashMap<String, String> param, RedirectAttributes rttr) {
		log.info("@# comp;ain_delete()");
		log.info("@# report_id=>"+param.get("report_id"));


		service.complain_delete(param);
		
		
		return "redirect:complain_list";
	}

}
