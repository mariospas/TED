<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="5;url=after_login/general_homepage.jsp">
<title>Insert title here</title>
</head>
<body>

<%
	session.invalidate();
%>
	<h1><font color="Red">You are Successfully logged out...</font></h1>
	<p>If auto redirect fails then click to this <a href="after_login/general_homepage.jsp"> link</a></p>

</body>
</html>