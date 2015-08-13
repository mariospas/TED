<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="login_logout_process.*"%>

<%
	int x;
	String name = request.getParameter("uname");
	String pass = request.getParameter("upass");
	LoginSession log = new LoginSession(name,pass);

	x = log.getUser();
	if (x == 1)
	{
		HttpSession s = request.getSession();
		out.println("<center><h1>Welcome: " + name + "</h1>");
		out.println("<br/><b>You are successfully login........ ");
	}
	else
	{
		out.println("<center>" + "<b>Either You Enter Wrong UserName or Password</b>");
	}
%>
