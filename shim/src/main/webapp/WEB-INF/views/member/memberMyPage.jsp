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
    	
    	
    	footer {
	      background-color: #f2f2f2;
	      padding: 25px;     
	    }      
    	
    
		.title {
      		text-align:center;
      		font-size:40px;
      		font-family:verdana;      		
	  	} 
	  	
	  	.affix {
		    top: 0;
		    width: 100%;
		    z-index: 9999 !important;
		}
	  	
	  	#submit_btn, #submit_pwBtn, #btn_withDraw {
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
  	
  	// 이름 정규식
  	//var nameChk = /^[가-힣]{2,6}$/;
  	//var nameCheck = /[a-zA-Z가-힝]/; 	//	한글, 영어만
	var nameChk = /[a-zA-Z가-힝]{2,20}$/;

  	// 이메일 검사 정규식
  	var mailChk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

  	// 휴대폰 번호 정규식
  	var phoneChk = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/; 
  	//////////////////////////////////////////////////////////////////////////////////////////////////////
  	
  	 // 아이디 중복 여부 플래그 submit 버튼 때 사용 
  	var pwFlag = 0;	// (0: 기존 비번 불일치   1:기존 비번 일치)
  	
	
 	// 이름 유효성 검사
  	$(document).on("blur", "#name", function(){
  		var name = $('#name').val();
  		
  		if(nameChk.test(name)){
			// 0 : 아이디 길이 / 문자열 검사
			$("#name_check").text("");							
			$('#name').css('border-color', '#5cb85c');							

		} else if(name == ""){							
			$('#name_check').text('이름을 입력해주세요');
			$('#name_check').css('color', 'red');
			$('#name').css('border-color', '#a94442');											
			
		} else {							
			$('#name_check').text("한글/영문으로 2글자 이상 입력해주세요.");
			$('#name_check').css('color', 'red');
			$('#name').css('border-color', '#a94442')	;					
		}		  		
  	});
 	
 	
 	// 회원정보 변경 버튼 클릭 시 전체 유효성 검사
  	$(document).on("click", "#submit_btn", function(){  	
  		var user_id = $('#id').val().toLowerCase();  	
  		var pw = $('#pw').val().toLowerCase();  	
  		var name = $('#name').val(); 		  	  		
		
		
  		// 이름 유효성 검사
  		if(nameChk.test(name)){
			// ok
		} else if(name == ""){							
			$('#name_check').text('이름을 입력해주세요');
			$('#name_check').css('color', 'red');
			$('#name').css('border-color', '#a94442');
			$('#name').focus();			
			return false;			
		} else {							
			$('#name_check').text("한글/영문으로 2글자 이상 입력해주세요.");
			$('#name_check').css('color', 'red');
			$('#name').css('border-color', '#a94442')	;
			$('#name').focus();			
			return false;
		}		
  		
  		// 모든 유효성 검사 통과
  		alert('회원정보 변경 완료 :)');
  	});
  	
  	
  	
  	
 	// 비밀번호 유효성 검사
  	$(document).on("blur", "#pw", function(){  		
  		var userId = $('#id').val().toLowerCase();
  		var pw = $('#pw').val().toLowerCase();
  		
  		
  		if (pw == ""){	// 기존 비밀번호에 입력을 안했다면			 
  			$('#pw_check').text('비밀번호를 입력해주세요');
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;					
			return false;
  		} else {
  			$("#pw_check").text("");							
			$('#pw').css('border-color', '');
  		}
  		
  		
  		// 기존 비밀번호 맞게 입력했는지 확인 후 flag 수정
  		$.ajax({  		
			url : '${pageContext.request.contextPath}/member/pwCheck.do',			
			type : 'post',
			data : {'id':userId , 	'pw':pw
			          },				
			success : function(data) {				
				if (data == 'accord') {
					return pwFlag = 1	// 기존 비밀번호 일치 한다면 pwFlag 1로 변경					
				} 
				return pwFlag = 0;		// 불일치 pwFlag = 0		
				
			}, error : function() {
					console.log("실패");
			} // success : function(data) {  END
		}); // ajax  END  		
  		
  	});
 	
 	
 	// 변경 비밀번호 유효성 검사
  	$(document).on("blur", "#changePw", function(){
  		var changePw = $('#changePw').val().toLowerCase();
  		
  		if(pwChk.test(changePw)){
			// 0 : 아이디 길이 / 문자열 검사
			$("#changePw_check").text("");							
			$('#changePw').css('border-color', '#5cb85c');							

		} else if(pw == ""){							
			$('#changePw_check').text('비밀번호를 입력해주세요');
			$('#changePw_check').css('color', 'red');
			$('#changePw').css('border-color', '#a94442')	;							
			
		} else {							
			$('#changePw_check').text("문자 숫자 조합 5~12자리 가능합니다.");
			$('#changePw_check').css('color', 'red');
			$('#changePw').css('border-color', '#a94442')	;						
		}		  		
  	});
 	
  	
 	// 변경 비밀번호 유효성 검사
  	$(document).on("blur", "#changePwConfirm", function(){
  		var changePwConfirm = $('#changePwConfirm').val().toLowerCase();
  		
  		if(pwChk.test(changePwConfirm)){
			// 0 : 아이디 길이 / 문자열 검사
			$("#changePwConfirm_check").text("");							
			$('#changePwConfirm').css('border-color', '#5cb85c');							

		} else if(pw == ""){							
			$('#changePwConfirm_check').text('비밀번호를 입력해주세요');
			$('#changePwConfirm_check').css('color', 'red');
			$('#changePwConfirm').css('border-color', '#a94442')	;							
			
		} else {							
			$('#changePwConfirm_check').text("문자 숫자 조합 5~12자리 가능합니다.");
			$('#changePwConfirm_check').css('color', 'red');
			$('#changePwConfirm').css('border-color', '#a94442')	;						
		}		  		
  	});
 	
 	
 	
 	
	 // 비밀번호 변경 버튼 클릭 시 전체 유효성 검사
  	$(document).on("click", "#submit_pwBtn", function(){  	
  		var userId = $('#id').val().toLowerCase();  											// 로그인 아이디
  		var pw = $('#pw').val().toLowerCase();												// 기존 비밀번호  		
  		var changePw = $('#changePw').val().toLowerCase();							// 변경 비밀번호
  		var changePwConfirm = $('#changePwConfirm').val().toLowerCase();	// 변경 비밀번호 확인
  		
  		// 1. 기존 비밀번호 유효성 검사
  		if (pw == ""){	// 기존 비밀번호에 입력을 안했다면			 
  			$('#pw_check').text('비밀번호를 입력해주세요');
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;
			$('#pw').focus();		
			return false;
  		} else if (pwFlag == 0) {	// 입력한 기존 비밀번호가 불일치 한다면  			
			$('#pw_check').text('입력하신 기존 비밀번호가 틀렸습니다.');
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;			
			$('#pw').focus();			
			return false;			
  		} else {
  			$("#pw_check").text("");							
			$('#pw').css('border-color', '');
  		}
  		
  		
  		// 2. 변경 비밀번호 유효성 검사
  		if(pwChk.test(changePw)){			
			$("#changePw_check").text("");							
			$('#changePw').css('border-color', '#5cb85c');							

		} else if(pw == ""){							
			$('#changePw_check').text('비밀번호를 입력해주세요');
			$('#changePw_check').css('color', 'red');
			$('#changePw').css('border-color', '#a94442');	
			return false;			
		} else {							
			$('#changePw_check').text("문자 숫자 조합 5~12자리 가능합니다.");
			$('#changePw_check').css('color', 'red');
			$('#changePw').css('border-color', '#a94442');
			return false;
		}	
  		
  		
  		// 3. 변경 비밀번호 확인 유효성 검사
  		if(pwChk.test(changePwConfirm)){
			// 0 : 아이디 길이 / 문자열 검사
			$("#changePwConfirm_check").text("");							
			$('#changePwConfirm').css('border-color', '#5cb85c');							

		} else if(pw == ""){							
			$('#changePwConfirm_check').text('비밀번호를 입력해주세요');
			$('#changePwConfirm_check').css('color', 'red');
			$('#changePwConfirm').css('border-color', '#a94442');
			return false;			
		} else {							
			$('#changePwConfirm_check').text("문자 숫자 조합 5~12자리 가능합니다.");
			$('#changePwConfirm_check').css('color', 'red');
			$('#changePwConfirm').css('border-color', '#a94442');
			return false;
		}		
  		
  		
  		// 변경 비밀번호, 변경 비밀번호 확인 같은지 비교
  		if(changePw !== changePwConfirm){
  			alert("변경 비밀번호가 같지 않습니다.");
			$("#changePw").val("").focus();
			$("#changePwConfirm").val("");
			return false;
  		} 		 	
  		
  		alert('비밀번호 변경 완료 :)');
  	});
  	
  	
  	// 회원탈퇴 버튼 클릭 시 
  	$(document).on("click", "#btn_withDraw", function(){ 
  		if(confirm("탈퇴 하시겠습니까?")){  			
  			location.href= "<c:url value='/member/withDraw.do'/>?id=${member.id}";
  		};
  	});
  	
		
 	</script>
  
  

</head>
<body>


<!-- 유저 네비게이션 메뉴  -->
<jsp:include page="/WEB-INF/views/template/userNav.jsp"></jsp:include>



	<div class="container">
		<h2 class="title">마이페이지</h2>
		<br>
		<br> <!-- <form action="/action_page.php"> -->
		<form action="<c:url value='/member/infoModify.do' />" method="post">
			<div class="form-group">
				<h3>회원정보 수정</h3>
				<br>
				<label for="id">아이디:</label> <input type="text" class="form-control"
					id="id" name="id" value="${member.id}" readonly>
				<div class="check_font" id="id_check"></div>
				<!-- div를 통해 경고문 공간을 만들어 놓는다.  -->
			</div>


			<div class="form-group">
				<label for="name">이름:</label> <input type="text"
					class="form-control" id="name" placeholder="이름" name="name"
					maxlength="20" value="${member.name}">
				<div class="check_font" id="name_check"></div>
			</div>

			<div class="form-button">
				<br>
				<input type="submit" class="btn btn-primary form-control"
					id="submit_btn" value="회원정보 변경">
			</div>
		</form>


		<br>
		<br>
		<form action="<c:url value='/member/pwModify.do' />" method="post">			
		<!-- <form id= pwForm method="post"> -->	
			<input type="hidden" id="idCheck" name="id" value="${member.id}">
			<div class="form-group">
				<label for="pwd">기존 비밀번호:</label> <input type="password"
					class="form-control" id="pw" placeholder="기존 비밀번호 " name="pw"
					maxlength="20">
				<div class="check_font" id="pw_check"></div>
			</div>

			<div class="form-group">
				<label for="pwd">변경 비밀번호:</label> <input type="password"
					class="form-control" id="changePw"
					placeholder="변경 비밀번호 (문자 숫자 조합 5~12자리)" name="changePw" maxlength="20">
				<div class="check_font" id="changePw_check"></div>
			</div>

			<div class="form-group">
				<label for="pwd">변경 비밀번호 확인:</label> <input type="password"
					class="form-control" id="changePwConfirm" placeholder="변경 비밀번호 확인"
					name="changePwConfirm" maxlength="20">
				<div class="check_font" id="changePwConfirm_check"></div>
			</div>

			<div class="form-button">
				<br>
				<input type="submit" class="btn btn-primary form-control"
					id="submit_pwBtn" value="비밀번호 변경">
			</div>
		</form>
		
		<br>	<br><h3>회원 탈퇴</h3>
		<br>
		<button type="button" class="btn btn-danger btn-block" id="btn_withDraw">회원 탈퇴</button>
		<%-- <button type="button" class="btn btn-danger btn-block" id="btn_withDraw" 
		              onclick="location.href ='<c:url value="/member/withDraw.do?id=${member.id}"/>'">회원 탈퇴</button> --%>		
		<br><br><br><br><br><br><br>

	</div>


	<!-- footer -->
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

</body>
</html>
