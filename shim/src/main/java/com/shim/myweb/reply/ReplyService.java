package com.shim.myweb.reply;

import java.util.List;
import java.util.Map;

import com.shim.myweb.util.PagingCriteria;

public interface ReplyService {
			
	// 댓글 갯수
	int replyCnt();
	
	// 글 목록 조회
	List<ReplyDto> replyList(int bno);
		
	// 댓글 등록, 수정, 삭제
	int insert(ReplyDto dto);
	int update(ReplyDto dto);
	int delete(ReplyDto dto);
	
	// 대댓글 등록
	int addReplyInsert(ReplyDto dto);
	
}
