package com.shim.myweb.board;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.shim.myweb.util.PageMaker;
import com.shim.myweb.util.PagingCriteria;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	
	@Autowired
	private BoardServiceImpl service;
	
		
	// 글 목록 조회
	@RequestMapping(value="/board/list.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String boardList(PagingCriteria cri, Model model) throws Exception {		
		//  커맨드 객체로 Criteria를 매개변수로 넣어줘, 넘어오는 pageNum와 amount 정보를 받는다.		
		List<BoardDto> boardList = service.selectList(cri);		
		
		// 글 갯수 (검색 기능 추가 후 수정)		// 기존: int total = service.totalCnt();
		int total = service.totalCnt(cri);
		
		        
		model.addAttribute("boardList",boardList);
		// /views/board/listPage.jsp 에서 페이징 처리를 하기 위해 PageMaker 객체를 저장
		model.addAttribute("pageMaker",new PageMaker(cri,total));		
		
		// 검색 - 게시글 상세 조회 후 돌아올 때 검색조건, 검색어 그대로 가져올 수 있도록 
		model.addAttribute("cri",cri);
		
		return "board/boardList";		
	}
				
	
	// 글 쓰기 페이지로 이동
	@RequestMapping("/board/inputPage.do") 
	public String boardInsertPage(HttpSession session, HttpServletResponse res) throws Exception{
		try {
			// 로그인 상태인지 확인
			session.getAttribute("userId").toString();
		}
		catch(NullPointerException e) { // 로그인 상태가 아니라면			
			//e.printStackTrace();
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();					
			out.println("<script>alert('로그인이 필요합니다.'); history.go(-1);</script>");			
            out.flush();   
            return "board/boardList";
		}
		
		return "board/boardInput"; 
	}
	
	// 글 등록 (DB)
	@RequestMapping(value="/board/input.do", method= {RequestMethod.POST, RequestMethod.GET}) 
	public String boardInsert(BoardDto dto, HttpSession session) throws IOException {		
			dto.setId(session.getAttribute("userId").toString());		
			service.insert(dto);
			
			return "redirect:/board/list.do"; 
	}
	
	
	// 글 상세 조회
	@RequestMapping("/board/view.do")
	public String boardViewPage(BoardDto dto, Model model, PagingCriteria cri, HttpSession session, HttpServletRequest req) {			
		BoardDto board = service.selectOne(dto);		
		String loginId = "";		// 로그인 id		
		
		try {
			// 로그인 상태인지 확인
			loginId = session.getAttribute("userId").toString();			
			
			// 글작성자와 로그인id 비교 - 다르다면 조회수 증가			
			if(!loginId.equals(board.getId())) {	
				// 조회수 증가
				service.viewHitCnt(board.getBno());
				// 조회수 증가 반영 상태로 상세보기
				board = service.selectOne(dto);
			}			
		}
		catch(NullPointerException e) { // 로그인 상태가 아니라면 조회수 증가 x
			//System.out.println(loginId + "로그인 상태 아님");
		}							
		
		model.addAttribute("cri",cri);						// pageNum, amount, searchType, keyword
		model.addAttribute("board", board);
		
		return "board/boardView"; // View 이름 리턴
	}
	
	// 글 수정 페이지로 이동
    @RequestMapping(value ="/board/modifyPage.do", method = {RequestMethod.GET, RequestMethod.POST})
    public String boardModifyPage(BoardDto dto, Model model, PagingCriteria cri) {         
    	BoardDto board = service.selectOne(dto);		
    	
		model.addAttribute("cri",cri);						// pageNum, amount, searchType, keyword
		model.addAttribute("board", board);        
 
        return "board/boardModify";// 수정 폼으로 이동
    }


    // 글 수정 (DB)
    @RequestMapping(value ="/board/modify.do", method = RequestMethod.POST)
    public String boardModify(BoardDto dto, PagingCriteria cri, RedirectAttributes rttr) {  
    	String b_no = Integer.toString(dto.getBno());
    	
        try {        	
        	service.update(dto);// db에 수정 작업하도록 서비스 클래스 수행        	
        }catch (Exception e) {
        	e.printStackTrace();           	  	
        }  
        
        // 1. RedirectAttributes에 pageNum, amount, searchType, keyword 을 추가해서 넘겨주는 방법       
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("searchType", cri.getSearchType());
        rttr.addAttribute("keyword", cri.getKeyword());
        
        return "redirect:/board/view.do?&bno="+b_no;
         
        // 2. 뒤에 &amount=10&keyword=임시&pageNum=1&searchType=t 직접 붙여주는 방법
        //return "redirect:/board/view.do"+cri.getLink()+"&bno="+b_no;                   
    }
    
    
    // 글 삭제  (DB)
    @RequestMapping(value ="/board/remove.do", method = RequestMethod.POST)
    public String boardRemove(BoardDto dto, PagingCriteria cri) {
    	// redirect시에는 Model 객체가 전달되지 않기 때문에 page, perPageNum 정보를 담기 위해서 RedirectAttribute 객체를 사용합니다.
    	BoardDto board;
    	
	    try {	    		    	
	    	// lvl에 따라 원본글인지 답글인지 판단 후 삭제 처리
	    	if(dto.getLvl() == 0) {
	    		// 원본글 : grp_no 단위로 삭제
	    		service.delete(dto);
	    	} else {
	    		// 답글 : bno 단위로 삭제
	    		service.commentDelete(dto);
	    	}
	    	
	    }catch (Exception e) {
	       	e.printStackTrace();
	    }    
	    
	    // 검색 기능 추가 후 cri.getLink() [검색종류, 검색어 정보 등 페이지 정보]추가
	    return "redirect:/board/list.do"+cri.getLink();
    }
    
    
    // 답글쓰기 페이지로 이동
    @RequestMapping(value ="/board/commentInputPage.do", method = RequestMethod.POST)
    public String boardCommentInputPage(BoardDto dto, PagingCriteria cri, Model model) {         
    	BoardDto board = service.selectOne(dto);		
		model.addAttribute("cri",cri);						// pageNum, amount, searchType, keyword
		model.addAttribute("board", board);        
 
        return "board/boardCommentInput";// 수정 폼으로 이동
    }
    
    
    // 답글쓰기 등록 (DB)
 	@RequestMapping(value="/board/commentInput.do", method= {RequestMethod.POST, RequestMethod.GET}) 
 	public String boardCommentInsert(BoardDto dto, PagingCriteria cri, HttpSession session) throws IOException { 		
			dto.setId(session.getAttribute("userId").toString()); 						
 			
 			// update (해당 그룹번호의 답글 순서 seq 수정) 
 			service.commentSeqUpdate(dto);
 			// insert (받아온 bno의 seq + 1 / lvl + 1 한 뒤 insert) 
 			service.commentInsert(dto);
 			
 			//return "redirect:/board/list.do?pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
 			// 검색 기능 추가 후 cri.getLink() [검색종류, 검색어 정보 등 페이지 정보]추가
 			return "redirect:/board/list.do"+cri.getLink();
 	}
        
  
	
}
