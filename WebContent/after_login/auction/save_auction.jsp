<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.Object.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Αποθήκευση Δημοπρασίας</title>
</head>
<body>
<%

	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{

		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		float currently_price = Float.parseFloat(request.getParameter("currently_price"));
		float first_bid = Float.parseFloat(request.getParameter("first_bid"));
		float buy_price = Float.parseFloat(request.getParameter("buy_price"));
		String latlong = request.getParameter("latlong");
		String country = request.getParameter("country");
		java.util.Date date = new SimpleDateFormat("MM-dd-yyyy").parse(request.getParameter("start_date"));
		java.sql.Date start_date = new java.sql.Date(date.getTime());
		date = new SimpleDateFormat("MM-dd-yyyy").parse(request.getParameter("end_date"));
		java.sql.Date end_date = new java.sql.Date(date.getTime());
		String description = request.getParameter("description");

	}
	else
	{
		out.println("<center><h1> Permission Denied </h1></center>");
	}
%>

</body>
</html>