package com.shim.myweb;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shim.myweb.board.BoardDto;
import com.shim.myweb.board.BoardServiceImpl;


@Controller
public class HomeController {
	
	@Autowired
	private BoardServiceImpl service;
	
	
	//메인 페이지
	@RequestMapping(value = "/")
	public String home(Model model) {	
		// 인기글 top 조회
		List<BoardDto> mainList = service.selectMainList();		
		model.addAttribute("mainList",mainList);
		
		// 최신글 top 조회
		List<BoardDto> newList = service.selectNewList();		
		model.addAttribute("newList",newList);
		
		return "home";
	}
		
	
}
