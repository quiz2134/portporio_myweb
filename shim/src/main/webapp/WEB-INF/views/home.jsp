<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
      margin-bottom: 50px;
      border-radius: 0;
    }
    
    /* Remove the jumbotron's default bottom margin */ 
     .jumbotron {
      margin-bottom: 0;
    }
   
    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #f2f2f2;
      padding: 25px;     
    }             
    
    /* 네비 메뉴 상단 고정 - 홈 화면에서는 스크롤 내려가서 화면 밖으로 올라가려 할 때 Top에 affix */
    .affix {
	    top: 0;
	    width: 100%;
	    z-index: 9999 !important;
	}

	.affix + .container-fluid {
	    padding-top: 70px;
	}	
    
  </style>

	
</head>
<body>
	<div class="jumbotron">
	  <div class="container text-center">	    
	    <h1>Ready</h1>	    
	  </div>
	</div>
	
	
	<!-- 유저 네비게이션 메뉴  -->
	<jsp:include page="/WEB-INF/views/template/userNav.jsp"></jsp:include>
	
	
	<!-- <div class="contents"> -->
	<div class="container">
		<!-- 1행 -->
		<div class="row">
			<!-- 1행 1열  -->			
			<div class="col-md-6">
				<div class="panel panel-info">
					<div class="panel-heading">
						<b>인기 게시글</b> <span style="cursor: pointer;" class="pull-right"
							onclick="location.href='<c:url value="/board/list.do"/>' ">더보기</span>
					</div>
					<div class="panel-body">
						<table class="table">						
							<tbody>
								<c:choose>
									<c:when test="${!empty mainList}">
										<c:forEach items="${mainList }" var="list">
											<c:set var="replyCnt" value="${list.replyCnt }" />
											<tr>
												<td align="left"><a style="color: black;"
													href="<c:url value='/board/view.do?bno=${list.bno}'/>">
														${list.title }<c:if test="${replyCnt > 0}">
															<b style="color: blue;"> &nbsp[${replyCnt}]</b>
														</c:if>
												</a></td>
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
					</div>
					<div class="panel-footer">조회수 및 댓글 기준</div>
				</div>
			</div> <!-- 1행 1열  -->
			
			<!-- 1행 2열 -->
			<div class="col-md-6">
				<div class="panel panel-info">				
					<div class="panel-heading">
						<b>최신 게시글</b> <span style="cursor: pointer;" class="pull-right"
							onclick="location.href='<c:url value="/board/list.do"/>' ">더보기</span>
					</div>
					<div class="panel-body">
						<table class="table">						
							<tbody>
								<c:choose>
									<c:when test="${!empty newList}">
										<c:forEach items="${newList }" var="newList">
											<c:set var="replyCnt" value="${newList.replyCnt }" />
											<tr>
												<td align="left"><a style="color: black;"
													href="<c:url value='/board/view.do?bno=${newList.bno}'/>">
														${newList.title }<c:if test="${replyCnt > 0}">
															<b style="color: blue;"> &nbsp[${replyCnt}]</b>
														</c:if>
												</a></td>
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
					</div>
					<div class="panel-footer">　</div>
				</div>
			</div> <!-- 1행 2열  -->
			
		</div>	<!-- 1행  -->	
		
		
		
	</div>	<!-- container div -->
	<br><br><br><br>
	

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
		

</body>
</html>
