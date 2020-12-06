package com.shim.myweb.member;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MemberController {	
	
	@Resource(name="memberService")
	private MemberServiceImpl service;
	
	
	//회원가입 페이지
	@RequestMapping("/member/inputPage.do")
	public String memberInput(){				
		return "member/memberInput";
	}
	
	//로그인 페이지
	@RequestMapping("/member/loginPage.do")
	public String memberLoginPage(){				
		return "member/memberLogin";
	}	
	
	
	// 회원 insert	
	@RequestMapping(value = "/member/input.do", method = RequestMethod.POST)
	public String memberInput(MemberDto dto) throws Exception {		
		if (dto.getName() == null)  return "member/memberInput";		
		//if(dto.getReceive_flag() == null) dto.setReceive_flag("N");		
		service.insert(dto);			
		
		return "redirect:/";
	}
	
	
	// 아이디 중복 체크	
	// @ResponseBody  return 값을 응답의 결과로 사용하라는 것 (페이지 이동 x)     
	// @RequestMapping - 한글 넘길거면 인코딩 파라미터도 추가 ,produces = "text/plain;charset=utf-8;"   
	@RequestMapping(value = "/member/idCheck.do", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String idCheck(@RequestParam("userId") String userId) throws Exception {	
		// 중복 아이디 존재한다면 
		if (service.idCheck(userId) == 1) return "exist";
		// 중복 아니면 "ok" 리턴		
		return "ok";
	}
	
	
	
	// 로그인
	@RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
	public String login(HttpServletRequest req, HttpServletResponse res, HttpSession session, MemberDto dto) throws Exception{
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");			
		
		// 아이디 비밀번호 일치 여부 확인 (성공시 로그인 세션 처리 후 메인페이지 / 실패시 알림창 후 return)
		boolean bFlag = service.isMember(dto);					
		
		if(bFlag){			
			String name = service.selectOne(dto).getName();
			
			session.setAttribute("userId", id);
			session.setAttribute("userName", name);
		} else {
			// 로그인 실패			
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();		
			
			out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); history.go(-1);</script>");			
            out.flush();
            
            return "member/memberLogin";			
		}
		
		return "forward:/";
	}
	
	// 로그아웃
	@RequestMapping("/member/logout.do")
	public String loginout(HttpSession session){	
		//session.removeAttribute("userId");
		session.invalidate();
		return "redirect:/";
	}
	
	
	// 마이페이지
	@RequestMapping("/member/myPage.do")
	public String memberMyPage(HttpSession session, Model model, HttpServletResponse res) throws Exception{
			
		try {			
			// 세션 UserID 가져오기 // 로그인 상태 확인
			String userId = session.getAttribute("userId").toString();		
			// UserId로 DTO 객체 가져오기
			MemberDto member = service.selectOneById(userId);
			// 마이페이지에 member 정보를 넘긴다.
			model.addAttribute("member", member);
		
		} catch(NullPointerException e) {	// 로그인 했다가 세션 아웃 된 상태 라면			
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();					
			out.println("<script>alert('로그인이 필요합니다.');</script>");			
            out.flush();   
            return "/";
		}		
		
		return "member/memberMyPage";
	}
	
	
	// 회원정보 수정
	@RequestMapping("/member/infoModify.do")
	public String memberModify(MemberDto dto, HttpSession session) throws Exception {	
		
		service.update(dto);		
		
		// 이름 변경했다면		
		if (!session.getAttribute("userName").equals(dto.getName())) {
			// 세션에 저장해놨던 userName 변경
			session.setAttribute("userName", dto.getName());			
		}		
		return "redirect:/member/myPage.do";
	}

	
	// 비밀번호 변경 (비밀번호 변경 시 확인용)
	@RequestMapping(value = "/member/pwCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String pwCheck(HttpServletRequest req) throws Exception {	
		
		String id = req.getParameter("id");
		String inputPw = req.getParameter("pw"); 					// 입력받은 비밀번호
		String originalPw = service.selectOneById(id).getPw();	// 기존 비밀번호
		
		// 기존 비밀번호와 입력받은 확인용 비밀번호가 맞다면 "accord" 반환	
		if(originalPw.equals(inputPw)) {	       
            return "accord";           
		} 		
		
		return "discord";		
	}	
	
	
	// 비밀번호 변경 (비밀번호 변경 시 확인용)
	@RequestMapping(value = "/member/pwModify.do", method = RequestMethod.POST)	
	public String pwModify(HttpServletRequest req) throws Exception {		
		
		String id = req.getParameter("id");
		String changePw = req.getParameter("changePw"); 		// 변경할 비밀번호
		
		MemberDto dto = new MemberDto();
		
		dto.setId(id);
		dto.setPw(changePw);
		
		// modify service ^^
		service.pwUpdate(dto);		
		
		return "forward:/member/myPage.do";
	}
	
	
	// 세션 아이디 가져오기
	public String getSessionId(HttpServletResponse res, HttpSession session) throws Exception {		
		String sessionUserId;
		
		try {
			// 세션 UserID 가져오기 // 로그인 상태 확인
			sessionUserId = session.getAttribute("userId").toString();
		} catch (NullPointerException e) { // 로그인 했다가 오랜시간 지나 세션 아웃 된 상태 라면
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>alert('로그인이 필요합니다.');</script>");
			out.flush();			
			return "NullPointException";			
		}
		
		// 중복 아이디 존재한다면 //if (service.idCheck(userId) == 1) return "exist"; // 중복 아니면
		// "ok" 리턴
		return sessionUserId;
	}
	
	
	// 회원 탈퇴
	@RequestMapping(value = "/member/withDraw.do", method = RequestMethod.GET)	
	public String memberWithDraw(HttpServletRequest req, HttpSession session) throws Exception {				
		String id = req.getParameter("id");
		
		// 실제 delete 처리가 아닌 withdraw_yn 플래그 update.. (탈퇴여부 Y/N)
		service.memberWithDraw(id);		
		session.invalidate();
		
		return "redirect:/";
	}
	
		
	
}
