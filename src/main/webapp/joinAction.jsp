<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- DB를 사용함 -->
<%@ page import ="user.UserDAO" %> 
<!-- javaScript문자을 사용하기위해서 불러옴 --> 
<%@ page import="java.io.PrintWriter" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 현제 페이지 안에서만 자바빈즈를 사용할수있도록 설정 -->
<jsp:useBean id="user" class="user.User" scope="page" />
<!-- login페이지에서 userID를 받아서 한명의 사용자의 userID(property)에 넣어준다 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinAction</title>
</head>
<body>
	<%
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
		   user.getUserGender() == null || user.getUserEmail() == null){ //유효성 검사
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력을 모두 해주세요.')");
			script.println("history.back()");
			script.print("</script>");
		}else{
			
			//인스턴스 생성
			UserDAO userDAO = new UserDAO();
			
			//아이디 비밀번호 이름 등 모든 값을 받아서 하나의 user라는 인스턴스가 join함수를
			//수행하도록 매개변수로 들어간다
			int result = userDAO.join(user); 
			
			if(result == -1){ //데이터 베이스 오류
				//userID에 primaryKEY를 주었기 때문에 데이터 베이스가 오류가 나는 경우엔
				//동일한 아이디여서 오류가 남
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디 입니다.')");
				script.println("history.back()");
				script.print("</script>");
			}
			else{ //정상적으로 로그인 한 경우	
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='main.jsp'");
				script.print("</script>");
			}	
			
		}	
	%>
</body>
</html>






