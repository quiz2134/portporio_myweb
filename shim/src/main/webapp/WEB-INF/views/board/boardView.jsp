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
  <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
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
		
	#replyList a {
	    color: gray;
	    font-size:12px;
	}			
		
    
  </style>
  <script>	
  $(document).ready(function(){	  	
		/********************** 게시글 본문 **********************/  		
		// form 태그를 꺼내온다.
	    var formObj = $("form[role='form']"); 		
	  
		// 수정 버튼 클릭 시
		$("#btn_modify").on("click", function(){
			// 위에서 hidden값들을 넘기기 위해 만들어놓은 form의 속성을 변경 - action 수정
	        formObj.attr("action","<c:url value='/board/modifyPage.do'/>");			
			// 폼을 전송함
	        formObj.submit(); 
	    });
		
		
		// 삭제 버튼 클릭 시
		$("#btn_remove").on("click", function(){
			if(confirm("삭제 하시겠습니까?")){
				formObj.attr("action","<c:url value='/board/remove.do'/>");			
		        formObj.submit();	
			}	         
	 	});	 		
		
		// 목록 버튼 클릭 시
		$("#btn_list").on("click", function(){						
	        //formObj.attr("action","<c:url value='/board/list.do'/>?pageNum=${cri.pageNum}&amount=${cri.amount}&searchType=${cri.searchType}&keyword=${cri.keyword}");
	        formObj.attr("action","<c:url value='/board/list.do'/>");
	        formObj.submit(); 
	 	});  		
		
		
		// 댓글 등록 버튼 클릭 시
		$("#btn_replyInsert").on("click", function(){	
			// 내용 null 인지 확인
			var cotents = $('#replyFormContents').val().replace(/\s/g, "");  	// 스페이스 공백은 "" 전환; 
			// 내용이 없거나 공백만 입력하고 등록 버튼을 눌렀다면 return false
			if(cotents == ""){							
				alert('내용을 입력해주세요.');	
				return false;			
			}		
			
			var replyInsertFormData = $("[name='replyForm']").serialize();	       	// replyForm input 데이터 ?id='aaa'&..... 형식으로 가져오기    // decodeURIComponent(replyInsertFormData); - 한글 깨짐 방지			  			  			
			replyInsert(replyInsertFormData);
	 	});	
		
		
		// 답글 버튼 클릭 시
		$("#btn_comment").on("click", function(){
			// 위에서 hidden값들을 넘기기 위해 만들어놓은 form의 속성을 변경 - action 수정
	        formObj.attr("action","<c:url value='/board/commentInputPage.do'/>");					
	        formObj.submit(); 
	    });
		
		
	});  //$(document).ready(function(){
		
  	
  	/********************** 게시글 댓글 **********************/  	
	var bno = '${board.bno}'; 						//게시글 번호
	var loginId = '${sessionScope.userId}'		// 세션 로그인 아이디
	var loginUserName	= '${sessionScope.userName}'		// 세션 로그인 유저명
	
	replyList(); // 페이지 로딩 시 댓글 목록 출력
	
	// 댓글 목록 조회	
	function replyList(){  			
		//alert(bno);		
		
		
		$.ajax({
	        url : '${pageContext.request.contextPath}/reply/list.do',
	        type : 'post',
	        data : {'bno':bno},  		      	
	        success : function(data){
	        	//alert(data.length);
	            var a = '';								// 변경할 html 변수
	            var depth = '';						// 댓글 깊이
	            
	            var replyCnt = data.length;	// 총 댓글 수	            
	            $("#replyCnt").text(replyCnt);	// 총 댓글 수 반영       
	            
	            
	            $.each(data, function(key, value){
	            		           
	            	// 댓글 lvl이 1이라면 댓글 깊이를 다르게 표현하기 위해, padding-left 추가
            		if (value.lvl == 1) {
            			depth = 'padding-left: 50px;'; 
            		} else depth = "";    		            
	            	
	            	if (value.id == loginId) {
	            		// 댓글 작성자와 로그인 한 사람이 같다면 - 답글쓰기 수정 삭제 가능	      
	            		
	            		value.contents = value.contents.replace(/\n/g, "<br>");	// textarea 줄바꿈 치환    		
	            		
	            		a += '<tr class="record'+value.cno+'">';            		
	            		a += '<td style="border-bottom:1px solid darkgray;  padding:8px 0px 5px 0px; '+depth+' ">';	            		
	            		a += '<div class="replyInfo'+value.cno+'">';
 		    			a += '<span><strong>'+value.writer+'</strong><small style="color:gray">&nbsp&nbsp ('+value.reg_dt+')</small></span>';
  		   				a += '</div>';
  		   				a += '<div class="replyContents'+value.cno+'" style="padding:2px 0px 7px 0px";>';
  		  				a += '<span>'+value.contents+'</span>';														
  		  				a += '</div>' ;  		  				
  		  				a += '<div class="replyBtns'+value.cno+'">';  		  				
  		  				// href="javascript:void(0);" onclick="replyModify()" - 함수에 리턴 값이 있던 없던 상관없음, 클릭해도 # 처럼 페이지 최상위 이동 x
  		  				a += '<a href="javascript:void(0);" onclick="addReplyForm('+value.cno+','+value.grp_no+');">답글쓰기</a>';
  		  		    	a += '&nbsp&nbsp<a href="javascript:void(0);" onclick="replyModifyForm('+value.cno+',\''+value.contents+'\');">수정 </a>';  		  		    	
  		  				a += '&nbsp<a href="javascript:void(0);" onclick="replyDelete('+value.cno+');">삭제</a>'; 		  				
  		  				a += '</div></td></tr>';
  		  				
	            	} else {
	            		// 댓글 작성자와 로그인 한 사람이 같지 않다면 - 답글쓰기만 가능		            		
	            		a += '<tr class="record'+value.cno+'"><td style="border-bottom:1px solid darkgray;  padding:8px 0px 5px 0px;'+depth+' ">';  		            	
 		            	a += '<div class="replyInfo'+value.cno+'">';
 		    			a += '<span><strong>'+value.writer+'</strong><small style="color:gray">&nbsp&nbsp ('+value.reg_dt+')</small></span>';
  		   				a += '</div>';
  		   				a += '<div class="replyContents'+value.cno+'" style="padding:2px 0px 7px 0px";>';
  		  				a += '<span>'+value.contents+'</span>';														
  		  				a += '</div>' ;  		  				
  		  				a += '<div class="replyBtns'+value.cno+'">';  		  				
  		  				a += '<a href="javascript:void(0);" onclick="addReplyForm('+value.cno+','+value.grp_no+');">답글쓰기</a>';
  		  				a += '</div></td></tr>';
  		  				
  		  				
	            	}  		            	
	            });
	              		             
	            $("#replyList").html(a);
	        } , error : function() {
			console.log("실패");
			}
	    }); 		  						
	} // function replyList()			
	
	
	//댓글 등록
	function replyInsert(replyInsertFormData){
	    $.ajax({
	        url : '${pageContext.request.contextPath}/reply/insert.do',
	        type : 'post',
	        data : replyInsertFormData,
	        success : function(data){
	            if(data == 1) {
	                replyList(); 									// 댓글 작성 후 댓글 목록 reload
	                $('#replyFormContents').val('');	// 댓글 입력 폼 내용 초기화
	            }
	        }
	    });
	} // function replyInsert(replyInsertFormData)
	
	
	//대댓글 입력 폼 삽입 - 댓글에서 답글쓰기 클릭 시
	function addReplyForm(cno, grp_no){			
					
		// 비로그인 상태라면 알림창
		if(loginId == "" || loginId == null) {
			alert("로그인이 필요합니다.");
			return false; 	
		}
		
		// 이미 다른 위치에 추가 되어있는 대댓글쓰기 입력 폼이 있다면 지우기  
		if($(".insertRecord1").length == 1) addReplyCancel();		
		
		// 대댓글 입력 폼 추가
		var addContent ='';			
		
		addContent += '<tr class="insertRecord1"><td style="padding:10px 0px 5px 50px;">';		
		addContent += '<div><span name="userInfo"><strong>'+loginUserName+'</strong></span></div>';
		addContent += '<textarea style="width: 100%;" rows="3" cols="30" id="addReplyFormContents" placeholder="댓글을 입력하세요."></textarea>';
		addContent += '</td></tr>';
		addContent += '<tr class="insertRecord2"><td style="padding-left: 50px;">';
		addContent +='<div>';
		addContent +='<button type="button" class= "btn btn-primary" onclick="addReplyInsert('+grp_no+')";>등록</button>'; 
		addContent +='&nbsp<button type="button" class= "btn btn-primary" onclick="addReplyCancel()";>취소</button></div>';
		addContent +='<div></div>';
		addContent += '</td></tr>';
						
		$( ".record"+cno).after(addContent);
		
	} // function replyDelete(cno)
	
	
	//대댓글 입력 폼 삭제
	function addReplyCancel(){		
		$(".insertRecord1").remove();
		$(".insertRecord2").remove();		
	}
	
	
	
	//대댓글 등록 - 대댓글 등록 시 lvl(댓글 depth)은 1로 저장한다.
	function addReplyInsert(grp_no){	
		// 내용 확인
		if ($('#addReplyFormContents').val().replace(/\s/g, "") == "") {
			alert('내용을 입력해주세요.')		
			return false;
		}		
		
		var contents = $('#addReplyFormContents').val();  	
		
	    $.ajax({
	        url : '${pageContext.request.contextPath}/reply/addReplyInsert.do',
	        type : 'post',
	        data : { 'id' : loginId, 'bno' : bno
	        	       , 'contents' : contents, 'grp_no' : grp_no, 'lvl' : '1'},	        
	        success : function(data){
	            if(data == 1) {
	                replyList();	// 댓글 작성 후 댓글 목록 reload	                
	            }
	        }
	    });	     	   
	     
	} // function addReplyInsert()
	
	
	

	//댓글 수정 폼 변경 - 댓글 내용 출력을 input 폼으로 변경 
	function replyModifyForm(cno, contents){
		
		// 기존 span → 변경 후 textarea
		var content ='';	    
	    content += '<textarea style="width: 87%;" rows="3" cols="30" name="content_'+cno+'">';
	    content += contents.replaceAll("<br>", "\r\n");		// textarea 줄바꿈 치환
	    content += '</textarea>';                	    
		
	    $('.replyContents'+cno).html(content);	  
	     
	   	// 기존 [수정 삭제] → 변경 후 [수정완료 취소]
	    var btn = '';	    
	    btn += '<a href="javascript:void(0);" onclick="replyModify('+cno+');">수정완료 </a>';	    
	    btn += '&nbsp<a href="javascript:void(0);" onclick="replyList();">취소</a>';	
	    
	    $('.replyBtns'+cno).html(btn);	      
	} // function replyModify(cno, contents)	
	
	
	//댓글 수정	
	function replyModify(cno){	
		if ($('[name=content_'+cno+']').val().replace(/\s/g, "") == "") {
			alert('내용을 입력해주세요.')		
			return false;
		}							
	
	    var updateContent = $('[name=content_'+cno+']').val(); 
	   
	    $.ajax({
	        url : '${pageContext.request.contextPath}/reply/modify.do',
	        type : 'post',
	        data : {'contents' : updateContent, 'cno' : cno},
	        success : function(data){
	            if(data == 1) replyList(); //댓글 수정후 목록 출력 
	        }
	    });	     
	} // function replyModify(cno)
	
	
	//댓글 삭제 
	function replyDelete(cno){
		if(confirm("삭제 하시겠습니까?")){
			$.ajax({
		    	url : '${pageContext.request.contextPath}/reply/delete.do',
		        type : 'post',
		        data : {'cno' : cno},
		        success : function(data){
		            if(data == 1) replyList(); //댓글 삭제후 목록 출력 
		        }
		    });
		}    
	} // function replyDelete(cno)
	
	
	
	
	
	
  </script>
   	
</head>
<body>

	<!-- 유저 네비게이션 메뉴  -->
	<jsp:include page="/WEB-INF/views/template/userNav.jsp"></jsp:include>

	<!-- 컨텐츠 내용 -->
	<div class="container">    
		<div>
			<h2 class="text-secondary" style="text-align:center">게시글 상세보기</h2><hr>
		</div><br>		
	
		<div>	
	 		<table class="table">			
				<thead>
					<tr>
						<th/>					
						<th style="width: 15%; text-align:left; min-width:140px;">작성자: ${board.writer}</th>
						<th style="width: 15%; text-align:left; min-width:120px;">조회수: ${board.hit_cnt}</th>
						<th style="width: 20%; text-align:left; min-width:230px;">작성시간: ${board.reg_dt}</th>			
					</tr>					
				</thead>
			</table>			 
		</div>
	   	<div class="form-group">
	    	 	<!-- <label class="control-label col-sm-2" for="category">분류:</label> -->
	    		<div>
	        		<select class="form-control" id="sel1" name="category">			    	
				    	<option value="${board.category}">${board.category}</option>			    								    				    					 
					</select>
	      		</div>      		
	   	</div>
	    <div class="form-group">
	    	<!-- <label class="control-label col-sm-2" for="title">제목:</label> -->
	      	<div>          
	        	<input type="text" class="form-control"  placeholder="제목을 입력하세요." 
	        	           name="title" id="title" value="${board.title}" readonly/>	        	      		
	      	</div>
	    </div>
	    <div class="form-group">
	    	<div>	    	
	 				<textarea class="form-control" rows="10" id="contents" placeholder="내용을 입력하세요." name="contents" readonly>${board.contents}</textarea>
	 		</div>
	   	</div>
	    <div class="form-group">
	    	<!-- 답글, 수정, 삭제, 목록 버튼 -->        
	    	<div style="float:right;">
	    		<c:choose>    			
		        	<c:when test="${empty sessionScope.userId}">
						<button type="submit" class="btn btn-primary" id="btn_list" style="width:65px;">목록</button>			
					</c:when>
					<c:otherwise>
						<c:set var = "sessionUserId" value = '<%=(String)session.getAttribute("userId") %>'/>
						<c:set var = "boardUserId" value = "${board.id}"/>				
						<!-- 로그인 아이디와 작성자 아이디 비교 -->					
						<c:choose>					
							<c:when test="${sessionUserId eq boardUserId}">					
								<button type="submit" class="btn btn-primary" id="btn_modify" style="width:65px;">수정</button>
					        	<button type="submit" class="btn btn-primary" id="btn_remove" style="width:65px;">삭제</button>
					        	<button type="submit" class="btn btn-primary" id="btn_list" style="width:65px;">목록</button>
							</c:when>													
							<c:otherwise>
								<button type="submit" class="btn btn-primary" id="btn_comment" style="width:65px;">답글</button>
								<button type="submit" class="btn btn-primary" id="btn_list" style="width:65px;">목록</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>	
		        </c:choose>	       	
	      	</div>
	    </div>
	    
	    <form name="form1" role="form" method="post">
		    <!-- 글 세부 조회에서는"수정","삭제","목록가기" 등을 클릭함에 따라 현제 페이지에서 글번호를 보내주어야 할 경우가 있다.
		        따라서, hidden 타입으로 숨겨놓되 전달시 같이 전송될 수 있도록 hidden타입의 value로 설정해 놓는다. -->	     
		    <input type='hidden' name='bno' value="${board.bno}"/>
		    <input type="hidden" name="pageNum" value="${cri.pageNum }" />
		    <input type="hidden" name="amount" value="${cri.amount }" />
		    
		    <!-- 검색 hidden 추가 -->		   
		    <input type="hidden" name="searchType" value="${cri.searchType }" />
		    <input type="hidden" name="keyword" value="${cri.keyword }" />
		    
		    <!-- lvl, grp_no :  원본글인지 답글인지 판단해서 삭제처리를 다르게 하기 위해 전송  -->
		    <input type='hidden' name='lvl' value="${board.lvl}"/>
		    <input type='hidden' name='grp_no' value="${board.grp_no}"/>		    
		</form>
	  
	</div><br><br>



	<!-- 댓글  -->
	<div class="container">
		<div>
	        <span><strong>Comments</strong></span> <span id="replyCnt">0</span>
	    </div>
		<br>
		
		
		<!-- 댓글 목록  -->	
		<div>		
			<table class="table" id="replyList">				
			</table>
		</div>		

		
		
		<!-- 댓글 등록 폼 - 로그인 상태에서만 보인다. -->
		<c:if test="${not empty sessionScope.userId}">
			<div>
				<form id="replyForm" name="replyForm" method="post">			
					<br>				
						<input type="hidden" name="bno" value="${board.bno}"/>
						<input type="hidden" name="id" value="${sessionScope.userId}"/>
						<table class="table">					
							<tr>
								<td style="padding:0px 0px 0px 0px;">
									<div>
										<span name="userInfo"><strong><%=(String) session.getAttribute("userName")%></strong></span>
									</div>
									<div>
										<textarea style="width: 87%;" rows="3" cols="30"
										                id="replyFormContents" name="contents" placeholder="댓글을 입력하세요."></textarea>
										<button
											style="width: 12%; min-width: 36px; height: 65px;"
											type="button" id="btn_replyInsert" class="btn pull-right btn-success">등록</button>
									</div>							
								</td>
							</tr>
						</table>					
				</form>
			</div>
		</c:if>        		
	</div>




	<!-- footer -->
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
 
 
 
 
</body>
</html>
