<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- DB를 사용함 -->
<%@ page import ="user.UserDAO" %> 
<!-- javaScript문자을 사용하기위해서 불러옴 --> 
<%@ page import="java.io.PrintWriter" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 현제 페이지 안에서만 자바빈즈를 사용할수있도록 설정 -->
<!-- user패키지에 있는User클래스라는 자바빈즈를 user라는 이름으로 객체를 생성 -->
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- login페이지에서 userID를 받아서 한명의 사용자의 userID(property)에 넣어준다 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginAction</title>
</head>
<body>
	<%
		//인스턴스 생성
		UserDAO userDAO = new UserDAO();
	
	
		//로그인을 시도할수 있도록 하고 result에 담는다
		//userDAO.login(아이디,비밀번호) << 어디서 넘어오는지?
		//자바빈즈를 사용했기때문에 <jsp:setProperty />
		//입력받은 값이 User.java 필드에 대입됨
		//User.java에서 입력받은 값을 가지고 getuserID()메소드가 
		//userDAO.login(user.getUserID(),user.getUserPassword());>   << 대입된다
		//userDAO.java에 있는 login함수의 매개값으로 전달 됨
		int result = userDAO.login(user.getUserID(),user.getUserPassword());
		
		if(result == 1){ //정상 로그인 경우
			
			PrintWriter script = response.getWriter(); //script문장을 넣기위해서 사용
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.print("</script>");
		}
		else if(result == 0){ //비밀번호가 틀린경우	
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");//이전페이지로 사용자를 돌려보낸다
			script.print("</script>");
		}
		else if(result == -1){ //아이디가 존재하지 않을때	
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('아이디가 존재하지 않습니다.')");
			script.println("history.back()");
			script.print("</script>");
		}
		else if(result == -2){ //데이터 베이스가 오류일때
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('데이터 베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.print("</script>");
		}
		
	%>
</body>
</html>






