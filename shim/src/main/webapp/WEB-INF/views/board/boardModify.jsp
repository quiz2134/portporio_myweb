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
    
    .affix {
	    top: 0;
	    width: 100%;
	    z-index: 9999 !important;
	}
  </style>
  
  <script> 	  
	  $(document).ready(function(){
		  // 해당 bno에 저장된 분류(category)값을 가져온다.
		  var category_val = '${board.category}';	
		  // 저장된 category 값과 같은 옵션을 selected 상태로 
		  $('#category').val(category_val).prop("selected",true);	
		  
		  var formObj = $("form[role='form']");
		  
		  
		  // 수정 버튼 클릭 시
		  $(document).on("click", "#btn_modify", function(){  	
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
								
				formObj.attr("action","<c:url value='/board/modify.do'/>");
				formObj.submit();	
				 
				// 모든 내용이 입력되었다면
				alert('수정 완료 :)');
		  });	 		  
	  	  	 
		  $(document).on("click", "#btn_cancel", function(){ 
			  	formObj.attr("action","<c:url value='/board/view.do'/>?pageNum=${cri.pageNum}&bno=${board.bno}&searchType=${cri.searchType}&keyword=${cri.keyword}");
			  	formObj.submit();
		  });
		  
	  }); 		
	  
  </script>
   	
</head>
<body>


<!-- 유저 네비게이션 메뉴  -->
<jsp:include page="/WEB-INF/views/template/userNav.jsp"></jsp:include>

<!-- 컨텐츠 내용 -->
<div class="container">    
	<div>
		<h2 class="text-secondary" style="text-align:center">게시글 수정</h2><hr>
	</div><br>			
	
	<form role="form" method="post" action="">	
	   	<div class="form-group">
	   			<!-- 숨김값으로 보내줘야 할 값들 : 현재 페이지 번호, 페이지당 게시글수  -->
	   			<input type='hidden' name='bno' value="${board.bno}"/>
	    	 	<input type="hidden" name="pageNum" value="${cri.pageNum }" />
				<input type="hidden" name="amount" value="${cri.amount }" />
				<!-- 검색 hidden 추가 -->
		    	<input type="hidden" name="searchType" value="${cri.searchType }" />
		    	<input type="hidden" name="keyword" value="${cri.keyword }" />
		
	
	    		<div class="s_test">
	        		<select class="form-control" id="category" name="category">			    	
				    	<option value="자유게시판" class="category">자유게시판</option>
				    	<option value="공지사항" class="category">공지사항</option>						    				    					 
					</select>
	      		</div>      		
	   	</div>
	    <div class="form-group">
	    	<!-- <label class="control-label col-sm-2" for="title">제목:</label> -->
	      	<div>          
	        	<input type="text" class="form-control"  placeholder="제목을 입력하세요." 
	        	           name="title" id="title" value="${board.title}"/>	        	      		
	      	</div>
	    </div>
	    <div class="form-group">
	    	<div>	    	
	 				<textarea class="form-control" rows="10" id="contents" placeholder="내용을 입력하세요." name="contents">${board.contents}</textarea>
	 		</div>
	   	</div>  	
	   	
	    <div class="form-group">        
	    	<div style="float:right;">
	        	<button type="submit" class="btn btn-primary" id="btn_modify" style="width:65px;">수정</button>
	        	<button type="submit" class="btn btn-primary" id="btn_cancel" style="width:65px;">취소</button>			 	
	      	</div>
	    </div>
    
    </form>
    
  
</div><br><br>

<!-- footer -->
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
 
 
 
 
</body>
</html>
