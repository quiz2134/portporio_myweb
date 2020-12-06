package com.shim.myweb.board;

public class BoardDto {
	
	private int bno;						// 게시판번호(PK)
	private String id;						// 작성자ID
	private String writer;				// 작성자 이름 member.name - left join별칭
	private int replyCnt;					// 댓글 개수 - 해당 bno로 달려있는 reply 테이블 레코드 수 
	
	private String category;			// 카테고리(notice / free / qna ...)
	private String title;					// 제목
	private String contents;			// 내용
	private int hit_cnt;					// 조회수
	private String reg_dt;				// 작성일
	
	private int grp_no;					// 그룹 번호(원본글 bno)
	private int seq;						// 같은 그룹내 순서
	private int lvl;							// 글 depth (원본글 0 / 답글 1 / 답글의답글 2 ....)
		
	
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getHit_cnt() {
		return hit_cnt;
	}
	public void setHit_cnt(int hit_cnt) {
		this.hit_cnt = hit_cnt;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public int getGrp_no() {
		return grp_no;
	}
	public void setGrp_no(int grp_no) {
		this.grp_no = grp_no;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getLvl() {
		return lvl;
	}
	public void setLvl(int lvl) {
		this.lvl = lvl;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}
		
	
}
