package com.shim.myweb.reply;


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

import com.shim.myweb.reply.ReplyDto;
import com.shim.myweb.reply.ReplyServiceImpl;
import com.shim.myweb.util.PageMaker;
import com.shim.myweb.util.PagingCriteria;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ReplyController {

	@Autowired
	private ReplyServiceImpl replyService;			
    
	
    //댓글 목록 조회
    @RequestMapping(value = "/reply/list.do"
    						  , method = {RequestMethod.GET, RequestMethod.POST}
                              , produces = "application/json; charset=utf8") 
    @ResponseBody
    private List<ReplyDto> replyList(@RequestParam("bno") int bno) throws Exception{
    	//List<ReplyDto> test = replyService.replyList(bno);    	
        return replyService.replyList(bno);
    }   
    
    
    //댓글 등록
    @RequestMapping(value = "/reply/insert.do", method = RequestMethod.POST)  	//  , produces = "application/json; charset=utf8"
    @ResponseBody
    private int replyInsert(ReplyDto dto) throws Exception{       
    	return replyService.insert(dto);    	
    }
    
    //대댓글 등록
    @RequestMapping(value = "/reply/addReplyInsert.do", method = RequestMethod.POST)
    @ResponseBody
    private int addReplyInsert(ReplyDto dto) throws Exception{            	
    	return replyService.addReplyInsert(dto);    	
    }
        
    
    // 댓글 수정
    @RequestMapping(value = "/reply/modify.do", method = RequestMethod.POST
    						  , produces = "application/json; charset=utf8")  
    @ResponseBody
    private int replyModify(ReplyDto dto) throws Exception{ 
    	//dto.setContents(dto.getContents().replace("\r\n","<br>"));
        return replyService.update(dto);
    }

    
    // 댓글 삭제
    @RequestMapping(value = "/reply/delete.do", method = RequestMethod.POST)  
    @ResponseBody
    private int replyDelete(ReplyDto dto) throws Exception{    	
        return replyService.delete(dto);
    }

	
}
