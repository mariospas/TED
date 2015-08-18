<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int x;
	String name = request.getParameter("uname");
	out.println("<center><h1>Το όνομα χρήστη "+ name + "lalalal ήδη</h1>");
	check ch = new check(name);

	x = ch.getAvailability();
	if (x == 1)
	{
		//ola ta upoloipa kai klash gia sync

		String site = new String("after_login/successful_registration.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);

	}
	else
	{
		out.println("<center><h1>Το όνομα χρήστη "+ name + "υπάρχει ήδη</h1>");
%>
		<p><a href="registration.jsp">Επιστροφή στην σελίδα εγγραφής!</a></p>
<%
	}
%>
</body>
</html>