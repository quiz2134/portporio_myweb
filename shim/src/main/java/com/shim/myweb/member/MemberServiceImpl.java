package com.shim.myweb.member;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Resource(name="memberDao")
	private MemberDao dao;
	
	
	
	@Override
	public List<MemberDto> selectList() {		
		return null;
	}

	@Override
	public int getTotalRecord(Map map) {		
		return 0;
	}

	@Override
	public MemberDto selectOne(MemberDto dto) {		
		return dao.selectOne(dto);
	}

	@Override
	public int insert(MemberDto dto) {		
		return dao.insert(dto);
	}

	@Override
	public int update(MemberDto dto) {		
		return dao.update(dto);
	}

	@Override
	public int delete(MemberDto dto) {		
		return 0;
	}

	@Override
	public boolean isMember(MemberDto dto) {		
		return dao.isMember(dto);
	}

	@Override
	public int idCheck(String userId) {		
		return dao.idCheck(userId);
	}

	@Override
	public MemberDto selectOneById(String userId) {		
		return dao.selectOneById(userId);
	}

	@Override
	public int pwUpdate(MemberDto dto) {		
		return dao.pwUpdate(dto);
	}

	@Override
	public int memberWithDraw(String userId) {		
		return dao.memberWithDraw(userId);
	}

}
