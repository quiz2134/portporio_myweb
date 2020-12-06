<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
  <title>MyWeb</title>
  <meta charset="utf-8">
  <!-- 접속한 device에 맞춰서 크기 조정 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <style>   
		.container {
      		max-width: 650px;      
    	}                  
    
		.title {
      		text-align:center;
      		font-size:40px;      	   			
	  	} 
	  	
	  	.affix {
		    top: 0;
		    width: 100%;
		    z-index: 9999 !important;
		}
	  	
	  	#submit_btn {
	  		font-size:16px;
	  	}	  	
	  	
  </style>
  
  	<script>	 

  	/****************** 유효성 검사 정규식 ******************/
  	//모든 공백 체크 정규식
  	var empChk = /\s/g;
  	
  	//아이디 정규식	: 문자로 시작하며, 그뒤에 문자 or 숫자 2글자이상 12자이하
  	var idChk = /^[a-zA-Z][a-zA-Z0-9]{2,12}$/;
  	
  	// 비밀번호 정규식 문자나 숫자 4~12자
  	//var pwJ = /^[A-Za-z0-9]{4,12}$/; 
	//	최소 4 자 최대 12자, 최소 하나의 문자 및 하나의 숫자
  	var pwChk = /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,12}$/;  	
  	
  	//////////////////////////////////////////////////////////////////////////////////////////////////////  	  	
  	
  	
  	
  	// 아이디 중복 체크 및 유효성 검사
  	$(document).on("blur", "#id", function(){
  		var user_id = $('#id').val().toLowerCase().replace(/\s/g, "");  	// 대문자는 소문자로, 스페이스 공백은 "" 전환
  				  
		if (user_id == "") {				
			$("#id_check").text("아이디를 입력해주세요");
			$("#id_check").css("color", "red");
			$('#id').css('border-color', '#a94442');
				return false;
		} else {
			$("#id_check").text("");							
			$('#id').css('border-color', '');
		}
  	}); 
  		
  		
  	// 비밀번호 유효성 검사
  	$(document).on("blur", "#pw", function(){
  		var pw = $('#pw').val().toLowerCase();
  		
  		if (pw == "") {			
			$('#pw_check').text('비밀번호를 입력해주세요');
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;
			return false;
		} else {
			$("#pw_check").text("");							
			$('#pw').css('border-color', '');
		} 		
  	});
  	 
	
 	
 	// 회원가입 버튼 클릭 시 전체 유효성 검사
  	$(document).on("click", "#submit_btn", function(){  	
  		var user_id = $('#id').val().toLowerCase().replace(/\s/g, "");  	
  		var pw = $('#pw').val().toLowerCase();    		
  		
  		  		
		// 아이디, 비밀번호 유효성 검사 
		if (user_id == "") {				
			$("#id_check").text("아이디를 입력해주세요");
			$("#id_check").css("color", "red");
			$('#id').css('border-color', '#a94442');
			return false;
		} else if (pw == "") {			
			$('#pw_check').text('비밀번호를 입력해주세요');
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;
			return false;
		} 			
		
		// 모든 유효성 검사 통과
		// isMember ajax 성공 여부에 따라 알림창.. (x)-> 컨트롤러에서 처리		
  	
  	});
 	
 	
		
 	</script>
  
  

</head>
<body>


<!-- 유저 네비게이션 메뉴  -->
<jsp:include page="/WEB-INF/views/template/userNav.jsp"></jsp:include>



<div class="container">
  <h2 class="title">로그인</h2> <br><br>  
  <form action="<c:url value='/member/login.do' />"  method="post">
    <div class="form-group">
      <label for="id">아이디:</label>
      <input type="text" class="form-control" id="id" placeholder="아이디 " name="id" maxlength="20">      
      <div class="check_font" id="id_check"></div>	<!-- div를 통해 경고문 공간을 만들어 놓는다.  -->      
    </div>    

    
    <div class="form-group">
      <label for="pwd">비밀번호:</label>
      <input type="password" class="form-control" id="pw" placeholder="비밀번호" name="pw" maxlength="20">
      <div class="check_font" id="pw_check"></div>
    </div>
  
  	<br>
    <input type="submit" class="btn btn-primary form-control" id="submit_btn" value="로그인" />
  </form>
</div>




</body>
</html>
