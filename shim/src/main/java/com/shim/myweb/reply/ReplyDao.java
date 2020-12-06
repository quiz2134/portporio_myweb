package com.shim.myweb.reply;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shim.myweb.util.PagingCriteria;

@Repository
public class ReplyDao implements ReplyService{	

	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public int replyCnt() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ReplyDto> replyList(int bno) {
		return mybatis.selectList("replyList", bno);
	}

	@Override
	public int insert(ReplyDto dto) {		
		return mybatis.insert("replyInsert", dto);
	}

	@Override
	public int update(ReplyDto dto) {		
		return mybatis.update("replyUpdate", dto);
	}

	@Override
	public int delete(ReplyDto dto) {		
		return mybatis.delete("replyDelete", dto);
	}

	@Override
	public int addReplyInsert(ReplyDto dto) {		
		return mybatis.insert("addReplyInsert", dto);
	}

	
	
	

}
