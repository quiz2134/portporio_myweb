package com.shim.myweb.reply;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shim.myweb.member.MemberDao;
import com.shim.myweb.util.PagingCriteria;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyDao replyDao;

	
	@Override
	public int replyCnt() {		
		return 0;
	}

	@Override
	public List<ReplyDto> replyList(int bno) {		
		return replyDao.replyList(bno);
	}

	@Override
	public int insert(ReplyDto dto) {		
		return replyDao.insert(dto);
	}

	@Override
	public int update(ReplyDto dto) {		
		return replyDao.update(dto);
	}

	@Override
	public int delete(ReplyDto dto) {		
		return replyDao.delete(dto);
	}

	@Override
	public int addReplyInsert(ReplyDto dto) {		
		return replyDao.addReplyInsert(dto);
	}
	
	

	

}
