<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="import_update_DB.*"%>
<%@ page import="login_logout_process.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Change Info Process</title>
</head>
<body>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		request.setCharacterEncoding("UTF-8");

		String firstname = request.getParameter("onoma");
		String lastname = request.getParameter("epitheto");
		String email = request.getParameter("taxudromio");
		String telephone = request.getParameter("thl");
		String country = request.getParameter("country");
		String city = request.getParameter("city");
		String address = request.getParameter("address");
		String tk = request.getParameter("tk");
		String afm = request.getParameter("afm");

		ImportUpdateDB eisagogh = new ImportUpdateDB();
		eisagogh.updateUser(log.getName(), firstname, lastname, email, telephone, address, tk, city, country, afm);

		String site = new String("../general_homepage.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);

	}
	else out.println("<center><h1> Error no name </h1></center>");
%>

</body>
</html>