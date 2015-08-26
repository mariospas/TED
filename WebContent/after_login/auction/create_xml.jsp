<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.Object.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Δημιουργία XML</title>
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

		String current = getServletContext().getRealPath(File.separator);
        String ted = getServletContext().getContextPath();

	    Item item = new Item(current,ted);
		String download_link = new String(item.getDownloadLink());
%>
		<p align="center"><b><a href="<%out.print(download_link);%>">Κατεβάστε το XML</a></b></p>
<%
	}
%>


</body>
</html>