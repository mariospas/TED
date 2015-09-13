<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="import_update_DB.*"%>
<%@ page import="login_logout_process.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Change Pass Process</title>
</head>
<body>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		request.setCharacterEncoding("UTF-8");

		String passwordold = request.getParameter("passwordold");
		String password = request.getParameter("password");
		if(passwordold.equals(log.getPass()))
		{

			ImportUpdateDB eisagogh = new ImportUpdateDB();
			eisagogh.changeUserPass(log.getName(), password);

			log.changePass(password);

			String site = new String("../general_homepage.jsp");
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", site);
		}
		else out.println("<center><h1> Λάθος Κωδικός !!! </h1></center>");

	}
	else out.println("<center><h1> Error no name </h1></center>");
%>


</body>
</html>