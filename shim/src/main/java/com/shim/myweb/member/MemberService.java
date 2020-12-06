package com.shim.myweb.member;


import java.util.List;
import java.util.Map;

public interface MemberService {
	List<MemberDto> selectList();
	
	int getTotalRecord(Map map);
	
	// 로그인
	MemberDto selectOne(MemberDto dto);
	
	// 회원정보
	MemberDto selectOneById(String userId);
	
	// CRUD
	int insert(MemberDto dto);
	int update(MemberDto dto);
	int delete(MemberDto dto);
	
	// 로그인 (아이디 비밀번호 맞는지 확인)
	boolean isMember(MemberDto dto);
	
	// 아이디 중복 확인
	int idCheck(String userId);	
	
	// 비밀번호 변경
	int pwUpdate(MemberDto dto);
	
	// 회원 탈퇴 (회원탈퇴 여부.. 플래그 Y/N 수정)
	int memberWithDraw(String userId);
	
}

