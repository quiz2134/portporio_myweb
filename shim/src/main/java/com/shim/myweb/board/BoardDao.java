package com.shim.myweb.board;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shim.myweb.util.PagingCriteria;

@Repository
public class BoardDao implements BoardService{
	
	//@Resource(name="sqlSessionTemplate")
	//private SqlSessionTemplate template;
	
	@Autowired
	private SqlSessionTemplate mybatis;	
	
	
	@Override
	public List<BoardDto> selectList(PagingCriteria cri) {		
		return mybatis.selectList("selectList", cri);
	}

	@Override
	public BoardDto selectOne(BoardDto dto) {		
		return mybatis.selectOne("selectOne", dto);
	}

	@Override
	public int insert(BoardDto dto) {		
		return mybatis.insert("boardInsert", dto);
	}

	@Override
	public int update(BoardDto dto) {		
		return mybatis.update("boardUpdate", dto);
	}

	@Override
	public int delete(BoardDto dto) {		
		return mybatis.delete("boardDelete", dto);
	}

	@Override
	public int viewHitCnt(int bno) {		
		return mybatis.update("boardViewHit", bno);
	}

	@Override
	public int commentSeqUpdate(BoardDto dto) {		
		return mybatis.update("commentSeqUpdate", dto);
	}

	@Override
	public int commentInsert(BoardDto dto) {		
		return mybatis.insert("commentInsert", dto);
	}

	@Override
	public int commentDelete(BoardDto dto) {		
		return mybatis.delete("commentDelete", dto);
	}

	@Override
	public int totalCnt(PagingCriteria cri) {		
		return mybatis.selectOne("totalCntBySearch", cri);
	}

	@Override
	public List<BoardDto> selectMainList() {		
		return mybatis.selectList("selectMainList");
	}

	@Override
	public List<BoardDto> selectNewList() {		
		return mybatis.selectList("selectNewList");
	}

	

}
