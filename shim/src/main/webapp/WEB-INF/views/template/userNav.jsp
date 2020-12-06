<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
  <div class="container-fluid">
    <div class="navbar-header">
      <!-- 모바일 사이즈 크기로 웹이 줄어들면 네비 메뉴가 = 버튼으로 대체됨 -->
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      
      <a class="navbar-brand" href="<c:url value='/'/>">HOME</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">      
        <li><a href="<c:url value='/board/list.do'/>">게시판</a></li>           
      </ul>
      <ul class="nav navbar-nav navbar-right">      
      	<c:choose>  
        	<c:when test="${empty sessionScope.userId}">
				<li><a href="<c:url value='/member/loginPage.do'/>"> 로그인</a></li>
        		<li><a href="<c:url value='/member/inputPage.do'/>"> 회원가입</a></li>				
			</c:when>
			<c:otherwise>
				<li class="dropdown">
			        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><%=(String)session.getAttribute("userName") %>
			        <span class="caret"></span></a>
			        <ul class="dropdown-menu">
			          <li><a href="<c:url value='/member/myPage.do'/>">마이페이지</a></li>
			          <li><a href="<c:url value='/member/logout.do'/>">로그아웃</a></li>			          
			        </ul>
			    </li>										
			</c:otherwise>	
        </c:choose>
      </ul>
    </div>
  </div>
  
</nav>





