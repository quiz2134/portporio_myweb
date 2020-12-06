package com.shim.myweb.member;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDao  implements MemberService{

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate template;

	
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
		return template.selectOne("memberSelectOne", dto);
	}

	@Override
	public int insert(MemberDto dto) {		
		return template.insert("memberInsert", dto);
	}

	@Override
	public int update(MemberDto dto) {		
		return template.update("memberUpdate", dto);
	}

	@Override
	public int delete(MemberDto dto) {		
		return 0;
	}

	@Override
	public boolean isMember(MemberDto dto) {		
		int count = template.selectOne("isMember", dto);
		if(count == 1) return true;
		return false;
	}

	@Override
	public int idCheck(String userId) {		
		return template.selectOne("idCheck", userId);
	}

	@Override
	public MemberDto selectOneById(String userId) {		
		return template.selectOne("selectOneById", userId);
	}

	@Override
	public int pwUpdate(MemberDto dto) {		
		return template.update("pwUpdate", dto);
	}

	@Override
	public int memberWithDraw(String userId) {		
		return template.update("memberWithDraw", userId);
	}	
	
	
	
}
