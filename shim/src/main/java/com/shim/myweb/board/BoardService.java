package com.shim.myweb.board;

import java.util.List;
import java.util.Map;

import com.shim.myweb.util.PagingCriteria;

public interface BoardService {	
	
	// 글 갯수
	int totalCnt(PagingCriteria cri);
	
	// 글 목록 조회
	List<BoardDto> selectList(PagingCriteria cri);
	
	// 글 상세 조회
	BoardDto selectOne(BoardDto dto);

	// 글 등록, 수정, 삭제
	int insert(BoardDto dto);
	int update(BoardDto dto);
	int delete(BoardDto dto);	
	
	// 조회수 증가
	int viewHitCnt(int bno);
	
	
	// 답글 순서 수정 (답글을 등록하기 전 기존에 등록된 답글들 순서 수정)
	int commentSeqUpdate(BoardDto dto);	
	// 답글 등록
	int commentInsert(BoardDto dto);
	// 답글 삭제 (원글 삭제는 grp_no 단위로 삭제 처리 / 답글은 bno 단위로 삭제)
	int commentDelete(BoardDto dto);
	
	
	// 인기글 top 5 - 메인화면	
	List<BoardDto> selectMainList();
	
	// 최신글 top 5 - 메인화면	
	List<BoardDto> selectNewList();
	
	
}
