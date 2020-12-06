<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>

  <title>MyWeb</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default rounded borders and increase the bottom margin */ 
    .navbar {     
      border-radius: 0;
    }
         
     .container {
  	  min-height: 400px;   
    }      
   
    footer {
      background-color: #f2f2f2;
      padding: 25px;     
    }  
    
    .affix {
	    top: 0;
	    width: 100%;
	    z-index: 9999 !important;
	}
    
  </style>

<script>
	$(document).ready(function(){
		var pageNum = ${cri.pageNum}
		
		// 선택되어있는 페이지 번호 css		
		$(".index"+pageNum).attr("class","active");	
		
	});

	// 검색
	$(document).on("click", "#searchBtn", function(){
		self.location = "<c:url value='/board/list.do'/>" 
							+ '${pageMaker.makeQuery(1)}'
							+ "&searchType="
							+ $("#searchType option:selected").val() + "&keyword="
							+ encodeURIComponent($('#keywordInput').val());		
	});
	
	
	// 한 페이지 당 보여줄 게시글 수 (5/10/20)
	$(document).on("change", "#amount", function(){
		var amount = $("#amount option:selected").val();				
		
		self.location = "<c:url value='/board/list.do'/>"							
							+ "?pageNum=1"
						 	+ "&amount=" + amount
							+ "&searchType="
							+ $("#searchType option:selected").val() + "&keyword="
							+ encodeURIComponent($('#keywordInput').val());		 					
	});
	
</script>


</head>
<body>

	<!-- 유저 네비게이션 메뉴  -->
	<jsp:include page="/WEB-INF/views/template/userNav.jsp"></jsp:include>
	
	<!-- 컨텐츠 내용 -->
	<div class="container">    
		<div>
			<h2 class="text-secondary" style="text-align:center">게시글 목록</h2>
		</div><br>
	
		<div class="pull-right amountDiv"> 
			<select class="form-control" id="amount"> 
				<option value="5" <c:out value="${cri.amount eq 5 ? 'selected' : ''}"/>>5개씩</option>
				<option value="10" <c:out value="${cri.amount eq 10 ? 'selected' : ''}"/>>10개씩</option> 
				<option value="20" <c:out value="${cri.amount eq 20 ? 'selected' : ''}"/>>20개씩</option> 
			</select>
		</div><br><br>
	
	
	  	<table class="table">
				<thead>
					<tr class="text-center" style="background: #E6E6F2;">
						<th style="width: 10%">글번호</th>
						<th style="width: 45%">제목</th>
						<th style="width: 15%">작성자</th>
						<th style="width: 19%">작성일</th>
						<th style="width: 10%">조회수</th>
					</tr>
				</thead>
				<tbody>							
					<c:choose>
						<c:when test="${!empty boardList}">
							<c:forEach items="${boardList }" var="board">
								<c:set var="replyCnt" value="${board.replyCnt }" />
								<tr>
									<td>${board.bno }</td>
									<td align="left">
									
									<c:choose> 
										<c:when test="${board.lvl > 0}">
											<c:set var="comment" value="[RE]" />							 
											<c:forEach var="i" begin="1" end="${board.lvl}">
											 	<span>&nbsp;&nbsp;&nbsp;&nbsp;</span> 
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:set var="comment" value="" />									
										</c:otherwise>																		 
									</c:choose>								
									
									<a style="color:black;" href="<c:url value='/board/view.do${pageMaker.makeSearch(pageMaker.cri.pageNum)}&bno=${board.bno}'/>">										
											${comment} ${board.title }<c:if test="${replyCnt > 0}"><b style="color:blue;"> &nbsp[${replyCnt}]</b></c:if></a></td>								 
									
									<td>${board.writer }</td>								
									<td> ${board.reg_dt }</td>								
									<td>${board.hit_cnt }</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5">등록된 글이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>				
				</tbody>
		</table>			
		<button class="btn btn-success pull-right" onclick="location.href ='<c:url value="/board/inputPage.do"/>'">글쓰기</button>
		<br>	<br>
		<div id="pagingDiv" class="text-center">
			<ul class="pagination pagination-sm">
				<c:if test="${pageMaker.prev}">
					<!-- 이전 버튼 : makeQuery 메서드를 이용해서 쿼리문자열을 만들어 주는데, 
					       현재 페이지가 시작 페이지 -1이 되도록 지정 -->
					<li><a href="<c:url value='/board/list.do${pageMaker.makeSearch(pageMaker.startPage - 1)}'/>">이전</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="index">	        
			        <li class="index${index}"><a href="<c:url value='/board/list.do${pageMaker.makeSearch(index) }'/>">${index }</a></li>	        
			    </c:forEach>
				<c:if test="${pageMaker.next}">
					<li><a href="<c:url value='/board/list.do${pageMaker.makeSearch(pageMaker.endPage + 1)}'/>">다음</a></li>
				</c:if>
			</ul>
		</div>


		<form class="form-inline text-center" role="form">
			<div class="form-group">
				<select id="searchType" class="form-control">
					<%-- <option value="n" 	<c:out value="${cri.searchType == null ? 'selected' : ''}"/>>검색조건</option> --%>						
					<option value="t"
						<c:out value="${cri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
					<option value="c"
						<c:out value="${cri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
					<option value="w"
						<c:out value="${cri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
					<option value="tc"
						<c:out value="${cri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
			</select > 
			</div>
			<div class="form-group">
				<input class="form-control" type="text" name="keyword" id="keywordInput"
				value="${cri.keyword}" />
			</div>
			<button class="btn btn-default" id="searchBtn" type="button">검색</button>				
		</form>
		
	</div><br><br>



	<!-- footer -->
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
 
 
 
 
</body>
</html>
