<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profile Info</title>
</head>
<body>
<jsp:include page="../../logout.html"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log.getType().equals("admin"))
	{
		String name = request.getParameter("uname");
		session.setAttribute("admin_user", name);
		Profile prof = new Profile(name);
		ResultSet set = prof.profile_info();
		while (set.next())
		{
%>
				<table align="center" width="300" border="1">
				  <tr>
				    <td>Όνομα Χρήστη</td>
				    <td><%out.print(set.getString("username"));%></td>
				  </tr>
				  <tr>
				    <td>Όνομα</td>
				    <td><%out.print(set.getString("firstname"));%></td>
				  </tr>
				  <tr>
				    <td>Επώνυμο</td>
				    <td><%out.print(set.getString("lastname"));%></td>
				  </tr>
				  <tr>
				    <td>Email</td>
				    <td><%out.print(set.getString("email"));%></td>
				  </tr>
				  <tr>
				    <td>Τηλεφωνικός Αριθμός</td>
				    <td><%out.print(set.getString("phone_number"));%></td>
				  </tr>
				  <tr>
				    <td>Χώρα</td>
				    <td><%out.print(set.getString("country"));%></td>
				  </tr>
				  <tr>
				    <td>Πόλη</td>
				    <td><%out.print(set.getString("city"));%></td>
				  </tr>
				  <tr>
				    <td>Διεύθυνση</td>
				    <td><%out.print(set.getString("address"));%></td>
				  </tr>
				  <tr>
				    <td>Τ.Κ</td>
				    <td><%out.print(set.getString("postal_code"));%></td>
				  </tr>
				  <tr>
				    <td>Α.Φ.Μ</td>
				    <td><%out.print(set.getString("afm"));%></td>
				  </tr>
				</table>
<%
			if(set.getInt("ready")==0)
			{
%>
				<div>
					<p align="center"><a href="confirmation.jsp">Επιβεβαίωση Χρήστη</a></p>
				</div>

<%
			}
		}
	}
	else
	{
		out.println("<center><h1>Error in profile page !!!</h1>");
	}

%>
</body>
</html>