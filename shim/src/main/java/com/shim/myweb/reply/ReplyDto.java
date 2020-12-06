package com.shim.myweb.reply;

public class ReplyDto {
	
	private int cno;						// 댓글고유번호(PK)
	private int bno;						// 게시판번호(FK)
	private String id;						// 댓글작성자 ID
	private String writer;				// 작성자 이름 member.name - left join별칭
	
	private String contents;			// 내용	
	private String reg_dt;				// 작성일
	
	private int grp_no;					// 그룹 번호(댓글 그룹번호 - 대댓글 부모댓글번호)	
	private int lvl;							// 글 depth (원본글 0 / 댓글 1 / 대댓글 2 ....)
	
	
		
	
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
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
	public int getLvl() {
		return lvl;
	}
	public void setLvl(int lvl) {
		this.lvl = lvl;
	}
		
	
		
	
}
