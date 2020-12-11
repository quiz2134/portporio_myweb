# Portforio

### 내용

개인 프로젝트 소스입니다. 기본적인 메인 화면 구성이나 컴포넌트들은 주로 부트스트랩을 
이용하였으며, Spring Framework (STS3) 기반으로 기능 구현하였습니다.
주요 기능은 아래와 같습니다.
   - 회원가입(ID중복확인 ajax) 및 로그인 유효성 검사, 게시글 CRUD, 페이징, 검색기능
     게시글 답글, 댓글, 대댓글






### 개발환경

##### Front-End
  * Bootstrap 3
  * HTML / CSS
  * jQuery
  * Ajax
                                    
##### Back-Eed
  * Java JDK 1.8
  * Spring
  * Oracle 11g
  * Mybatis
  * Tomcat 9





### Spring 동작과정

  1) 클라이언트에서 요청(url pattern) 이 들어오면 DispatcherServlet에서 요청을 받는다. (web.xml)


  2) 요청을 받은 DispatcherServlet은 어떤 컨트롤러에서 요청을 처리할 것인지 찾는다. 
       ( component-sacn base-package 하위 파일들 중 @Controller 어노테이션을 통해 컨트롤러를 
         찾아가 알맞은 @RequestMapping 메소드를 찾아간다. ) 


  3) 컨트롤러는 해당 요청을 처리할 서비스를 주입 받아 비즈니스 로직을 서비스에게 위임한다.


  4) 서비스는 요청에 필요한 작업을 수행하고, 데이터 조회, 입력, 수정, 삭제 등 DB처리는 DAO에게 위임한다.


  5) DAO는 Mybatis를 이용하여 SQL 쿼리가 있는 Mapper 파일을 찾아 DB를 처리하며 받아온 정보를 다시
      Service에게 전달한다.  
      ( 보통 DTO[VO]를 컨트롤러에서 부터 받아 쿼리 결과를 DTO에 담아 보내준다. )
 

  6) 모든 로직을 끝낸 서비스가 결과를 컨트롤러에게 넘긴다.


  7) 컨트롤러는 Model객체에 결과물을 요청에 맞는 View 정보를 담아 DispatcherServlet에게 보낸다.


  8) DispatcherServlet은 받아온 View 정보를 ViewResolver에게 넘겨주며, ViewResolver는 응답할 View에 대한
      JSP를 찾아 DispatcherServlet에게 전달한다.

    
  9) DispatcherServlet은 클라이언트에게 Rendering된 뷰를 응답하며 요청을 마친다.
