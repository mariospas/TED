<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../../logout.html"/>
<jsp:include page="../profile_button.html"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{

		request.setCharacterEncoding("UTF-8");
		String bid_string = request.getParameter("bid");
		float bid = Float.parseFloat(bid_string);
		session.setAttribute("bid", bid);

	}
%>
</body>
</html>