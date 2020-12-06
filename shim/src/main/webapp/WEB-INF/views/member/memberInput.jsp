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
  	var idFlag = 1;	// (0: 중복아님   1:중복)
  	
  	
  	
  	// 아이디 중복 체크 및 유효성 검사
  	$(document).on("blur", "#id", function(){
  		var user_id = $('#id').val().toLowerCase().replace(/\s/g, "");  	// 대문자는 소문자로, 스페이스 공백은 "" 전환
  		//alert(user_id);	  		
  		$.ajax({   			
			url : '${pageContext.request.contextPath}/member/idCheck.do',			
			type : 'post',
			data : {'userId':user_id},	
			
			success : function(data) {				
				if (data == 'exist') {
						// 1 : 아이디가 중복되는 문구
						$("#id_check").text("사용중인 아이디입니다.");
						$("#id_check").css("color", "red");
						$('#id').css('border-color', '#a94442');
						return idFlag = 1;
						//$("#reg_submit").attr("disabled", true);
				} else {					
						if(idChk.test(user_id)){
							// 0 : 아이디 길이 / 문자열 검사							
							$("#id_check").text("");							
							$('#id').css('border-color', '#5cb85c');
							return idFlag = 0; 	// 아이디 중복도 아니면서, 유효성 통과라면 idFlag = 0으로 설정				
						} else if(user_id == ""){											
							$('#id_check').text('아이디를 입력해주세요');
							$('#id_check').css('color', 'red');
							$('#id').css('border-color', '#a94442');											
							
						} else {							
							$('#id_check').text("아이디는 문자로 시작되며, 문자 숫자로 이루어진 3~12자리 가능합니다.");
							$('#id_check').css('color', 'red');
							$('#id').css('border-color', '#a94442');							
						}						
				}
			}, error : function() {
					console.log("실패");
			} // success : function(data) {  END
		}); // ajax  END  		
  	}); // $(document).on("blur", "#id", function(){       END
  		
  		
  	// 비밀번호 유효성 검사
  	$(document).on("blur", "#pw", function(){
  		var pw = $('#pw').val().toLowerCase();
  		
  		if(pwChk.test(pw)){
			// 0 : 아이디 길이 / 문자열 검사
			$("#pw_check").text("");							
			$('#pw').css('border-color', '#5cb85c');							

		} else if(pw == ""){							
			$('#pw_check').text('비밀번호를 입력해주세요');
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;							
			
		} else {							
			$('#pw_check').text("문자 숫자 조합 5~12자리 가능합니다.");
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;						
		}		  		
  	});
  	 
	
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
 	
 	
 	// 회원가입 버튼 클릭 시 전체 유효성 검사
  	$(document).on("click", "#submit_btn", function(){  	
  		var user_id = $('#id').val().toLowerCase();  	
  		var pw = $('#pw').val().toLowerCase();  	
  		var name = $('#name').val(); 		
  				 
		// 아이디 유효성 검사 
  		if(idChk.test(user_id)){							
			// 칸이 비어있지 않고, 아이디 중복 체크 flag  0 (중복아님) 이라면 ok
			if (idFlag == 1) {				
				$("#id_check").text("사용중인 아이디입니다.");
				$("#id_check").css("color", "red");
				$('#id').css('border-color', '#a94442');
				return false;
			}
			// idChk 통과 및 idFlag == 0   : 유효성 통과			
			
		} else if(user_id == ""){							
			$('#id_check').text('아이디를 입력해주세요');
			$('#id_check').css('color', 'red');
			$('#id').css('border-color', '#a94442');
			$('#id').focus();						
			//var result = $('#id').attr('text');
			//alert(result);
			return false;							
		} else {							
			$('#id_check').text("아이디는 문자로 시작되며, 문자 숫자로 이루어진 3~12자리 가능합니다.");
			$('#id_check').css('color', 'red');
			$('#id').css('border-color', '#a94442');
			$('#id').focus();					
			return false;						
		}						
		
		 
		
		// 비밀번호 유효성 검사
  		if(pwChk.test(pw)){										
			// ok
		} else if(pw == ""){							
			$('#pw_check').text('비밀번호를 입력해주세요');
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;
			$('#pw').focus();			
			return false;
		} else {							
			$('#pw_check').text("문자 숫자 조합 5~12자리 가능합니다.");
			$('#pw_check').css('color', 'red');
			$('#pw').css('border-color', '#a94442')	;
			$('#pw').focus();
			return false;
		}
		
		
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
  		alert('회원가입 완료 :)');
  	});
 	
 	
		
 	</script>
  
  

</head>
<body>


<!-- 유저 네비게이션 메뉴  -->
<jsp:include page="/WEB-INF/views/template/userNav.jsp"></jsp:include>



<div class="container">
  <h2 class="title">회원 가입</h2> <br><br>  
  <!-- <form action="/action_page.php"> -->
  <form action="<c:url value='/member/input.do' />"  method="post"> 
    <div class="form-group">
      <label for="id">아이디:</label>
      <input type="text" class="form-control" id="id" placeholder="아이디 (문자로 시작되며, 문자 숫자로 이루어진 3~12자리)" name="id" maxlength="20">      
      <div class="check_font" id="id_check"></div>	<!-- div를 통해 경고문 공간을 만들어 놓는다.  -->      
    </div>    

    
    <div class="form-group">
      <label for="pwd">비밀번호:</label>
      <input type="password" class="form-control" id="pw" placeholder="비밀번호 (문자 숫자 조합 5~12자리)" name="pw" maxlength="20">
      <div class="check_font" id="pw_check"></div>
    </div>
        
    <div class="form-group">
      <label for="name">이름:</label>
      <input type="text" class="form-control" id="name" placeholder="이름" name="name" maxlength="20">
      <div class="check_font" id="name_check"></div>
    </div>    

    <br>
    <!-- <button type="submit" class="btn btn-default">Submit</button> -->
    <input type="submit" class="btn btn-primary form-control" id="submit_btn" value="가입하기" >
  </form>
</div>




</body>
</html>
