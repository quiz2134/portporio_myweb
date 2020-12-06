<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- 날짜 데이터 포맷 -->

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
      /* margin-bottom: 50px; */
      border-radius: 0;
    }
          
     .container {
  	  min-height: 400px;   
    }
      
   
    footer {
      background-color: #f2f2f2;
      padding: 25px;     
    }      
  </style>
  
  <script>
	  $(document).on("click", "#btn_submit", function(){  	
			var title = $('#title').val();  	
			var contents = $('#contents').val();  	
					
			if(title == ""){						
				$('#title').focus();
				alert('입력 정보를 확인해주세요.');
				return false;
			} else if (contents == "") {
				$('#contents').focus();
				alert('입력 정보를 확인해주세요.');
				return false;
			}						
			
			// 모든 내용이 입력되었다면
			alert('등록 완료 :)');
		});
  
  </script>
   	
</head>
<body>


<!-- 유저 네비게이션 메뉴  -->
<jsp:include page="/WEB-INF/views/template/userNav.jsp"></jsp:include>

<!-- 컨텐츠 내용 -->
<div class="container">    
	<div>
		<h2 class="text-secondary" style="text-align:center">게시판 글쓰기</h2><hr>
	</div><br>		
	<form class="form-horizontal" action="<c:url value='/board/input.do'/>">
    	<div class="form-group">
	    	 	<!-- <label class="control-label col-sm-2" for="category">분류:</label> -->
	    		<div>
	        		<select class="form-control" id="sel1" name="category">
	        		    <option value="자유게시판" selected>자유게시판</option>	
				    	<option value="공지사항">공지사항</option>				    				 
					</select>
	      		</div>
    	</div>
	    <div class="form-group">
	    	<!-- <label class="control-label col-sm-2" for="title">제목:</label> -->
	      	<div>          
	        	<input type="text" class="form-control"  placeholder="제목을 입력하세요." name="title" id="title">
	      		<div class="check_font" id="title_check"></div>	<!-- div를 통해 경고문 공간을 만들어 놓는다.  -->
	      	</div>
	    </div>
	    <div class="form-group">        
	    	<!-- <label class="control-label col-sm-2" for="comment">내용:</label> -->
	    	<div>	    	
  				<textarea class="form-control" rows="10" id="contents" placeholder="내용을 입력하세요." name="contents"></textarea>
  			</div>
	   	</div>
	    <div class="form-group">        
	    	<div style="float:right;">
	        	<button type="submit" class="btn btn-primary" id="btn_submit" style="width:65px;">등록</button>	        	
	      	</div>
	    </div>
  </form>		
</div><br><br>


<!-- footer -->
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
 
 
 
</body>
</html>
