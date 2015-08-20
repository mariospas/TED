<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Confirmation</title>
</head>
<body>
<%
	Users user = new Users();
	String name = (String) session.getAttribute("admin_user");

	user.confirmation(name);

	String site = new String("../admin_page.jsp");
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", site);

%>

</body>
</html>