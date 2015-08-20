<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Page</title>
</head>
<body>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log == null || !(log.getType().equals("admin")) )
	{
		out.println("<center><h1>Permission Denied</h1>");
	}
	else
	{
		Users users = new Users();
		ResultSet set = users.all_users();
%>
		<jsp:include page="../logout.html"/>
		<jsp:include page="profile_button.html"/>
		<p><b><center>Admin Page</center></b></p>



			<form method="post" action="change_profile_info/admin_profile.jsp">
			<table align="center" width="700" border="1">
			<tr>
			  <td>Όνομα Χρήστη</td>
			  <td>Κωδικός</td>
			  <td>Όνομα</td>
			  <td>Επώνυμο</td>
			  <td>Επιβεβαιωμένος</td>
			  <td>Επιλογή</td>
			</tr>
<%
		while (set.next())
		{
%>

			<tr>
			  <td id="username" name="username"><%out.print(set.getString("username"));%></td>
			  <td id="password" name="password"><%out.print(set.getString("password"));%></td>
			  <td id="firstname" name="firstname"><%out.print(set.getString("firstname"));%>;</td>
			  <td id="lastname" name="lastname"><%out.print(set.getString("lastname"));%></td>
			  <td id="ready" name="ready"><%out.print(set.getString("ready"));%></td>
			  <td><input type="radio" name="uname" value="<%out.print(set.getString("username"));%>" id="uname"></td>
			</tr>


<%
		}
%>
		</table>
		</br>
		<div align="center">
			<input align="center" TYPE="submit" name="sub" id="sub" value="Άνοιγμα Προφιλ"/>
		</div>
		</form>
<%
	}
%>
</body>
</html>