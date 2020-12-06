package com.shim.myweb.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {	
	private PagingCriteria cri;			// pageNum, amount 를 가지고 있음
	
    private int startPage;				// 게시글 번호에 따른 (보여지는)페이지의 시작 번호
	private int endPage;					// 게시글 번호에 따른 (보여지는)페이지의 마지막 번호
	private boolean prev;				// 이전 버튼을 누를 수 있는 경우/없는 경우 분류를 위한 변수
	private boolean next;				// 다음 버튼을 누를 수 있는 경우/없는 경우 분류를 위한 변수
	
	private int displayPageNum =5;// 화면 하단에 보여지는 페이지의 개수

	
		
	
	public PageMaker(PagingCriteria cri,int total){
		this.cri=cri;
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));		
		
		endPage = (int) (Math.ceil(cri.getPageNum() / (double) displayPageNum) * displayPageNum);		 
        startPage = (endPage - displayPageNum) +1;
		
		
		if(realEnd < this.endPage) {
			this.endPage=realEnd;
		}
		
		this.next = getEndPage() < realEnd;
		this.prev = getStartPage()>1;
		
	}
	
	public PagingCriteria getCri() {
		return cri;
	}

	public void setCri(PagingCriteria cri) {
		this.cri = cri;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	@Override
	public String toString() {
		return "PageMaker [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next + "]";
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	
	// UniComponent로 <a href="xxx.do?pageNum=1>에서 ? 이후 -> 쿼리문자열 작성 메소드
	public String makeQuery(int page) {		 
        UriComponents uriComponents = 
        		UriComponentsBuilder.newInstance()
        		.queryParam("pageNum", page)
                .queryParam("amount", cri.getAmount())
                .build(); 
        return uriComponents.toUriString();
    }
	
	
	// 검색 기능 추가 후 추가된 내용
	public String makeSearch(int page) {		 
        UriComponents uriComponents = 
        		UriComponentsBuilder.newInstance()
        		.queryParam("pageNum", page)
                .queryParam("amount", cri.getAmount())
                .queryParam("searchType", cri.getSearchType())
                .queryParam("keyword", encoding(cri.getKeyword()))
                .build(); 
        return uriComponents.toUriString();
    }
	
	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) { 
			return "";
		}		 
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch(UnsupportedEncodingException e) { 
			return ""; 
		}
	} 
	


}
