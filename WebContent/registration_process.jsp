<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="check_uti.*"%>
<%@ page import="import_update_DB.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Εγγραφή</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	int x;
	String name = request.getParameter("uname");
	check ch = new check(name);

	x = ch.getAvailability();
	if (x == 1)
	{
		String password = request.getParameter("password");
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
		eisagogh.importUser(name, password, firstname, lastname, email, telephone, address, tk, city, country, afm);


		//String site = new String("after_login/successful_registration.html");
		//response.setStatus(response.SC_MOVED_TEMPORARILY);
		//response.setHeader("Location", site);
%>
		<p>Εκκρεμεί η έγκριση της αίτησης εγγραφής σας στην εφαρμογή από τον διαχειριστή.</p>
<%
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