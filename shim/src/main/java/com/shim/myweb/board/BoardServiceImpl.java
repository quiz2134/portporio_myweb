package com.shim.myweb.board;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shim.myweb.member.MemberDao;
import com.shim.myweb.util.PagingCriteria;

@Service
public class BoardServiceImpl implements BoardService{
	
	//@Resource(name="boardDao")
	//private BoardDao dao;
	
	@Autowired
	private BoardDao boardDao;	
	

	@Override
	public List<BoardDto> selectList(PagingCriteria cri) {		
		return boardDao.selectList(cri);
	}
	

	@Override
	public BoardDto selectOne(BoardDto dto) {		
		return boardDao.selectOne(dto);
	}

	@Override
	public int insert(BoardDto dto) {
		return boardDao.insert(dto);
	}

	@Override
	public int update(BoardDto dto) {
		return boardDao.update(dto);
	}

	@Override
	public int delete(BoardDto dto) {
		return boardDao.delete(dto);
	}

	@Override
	public int viewHitCnt(int bno) {		
		return boardDao.viewHitCnt(bno);
	}

	@Override
	public int commentSeqUpdate(BoardDto dto) {		
		return boardDao.commentSeqUpdate(dto);
	}

	@Override
	public int commentInsert(BoardDto dto) {		
		return boardDao.commentInsert(dto);
	}

	@Override
	public int commentDelete(BoardDto dto) {		
		return boardDao.commentDelete(dto);
	}

	@Override
	public int totalCnt(PagingCriteria cri) {		
		return boardDao.totalCnt(cri);
	}

	@Override
	public List<BoardDto> selectMainList() {		
		return boardDao.selectMainList();
	}

	@Override
	public List<BoardDto> selectNewList() {		
		return boardDao.selectNewList();
	}

	

}
