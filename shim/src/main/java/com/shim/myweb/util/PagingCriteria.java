package com.shim.myweb.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;


/**
 *  Criteria 클래스
 *      : 페이징 처리를 위해서 사용될 객체로, 페이지 번호와, 페이지당 출력할 개시글 수를 관리할 객체이다.
 */

public class PagingCriteria {
	private int pageNum=1;	//페이지 번호
	private int amount=10;	//페이지당 데이터 갯수
	
	// 검색 속성 추가
	private String searchType = "t";		// 검색 종류 (제목 / 내용 / 작성자)
	private String keyword = "";			// 검색 키워드

	

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	

	@Override
	public String toString() {		
		return "PagingCriteria [pageNum=" + pageNum + ", amount=" + amount + ", searchType=" + searchType + ", keyword=" + keyword +   "]";
	}
	
	
	public String getLink() {		  
		  UriComponents uriComponents = 
	        		UriComponentsBuilder.newInstance()
	        		.queryParam("pageNum", this.pageNum)
	                .queryParam("amount", this.getAmount())
	                .queryParam("searchType", this.getSearchType())
	                //.queryParam("keyword", this.getKeyword())					// 인코딩을 안해주면 한글이 제대로 나오지 않는다. (%20...) 
	                .queryParam("keyword", encoding(this.getKeyword()))
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