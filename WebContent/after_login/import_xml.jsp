<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Import XML</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script src="../scripts/checkFileSize.js"></script>
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
		%>
		<form method="post" action="save_xml.jsp" ENCTYPE="multipart/form-data" >
			<p><label>XML :</label>
	        <input type="hidden" name="size" value="1048576000">
	        <input type="file" name="xml" id="i_file"> </p>
	        <input TYPE="submit" name="sub_button" id="sub_button" title="Add data to the Database" value="Αποθήκευση"/>
	        </br>
	    </form>
		<%
	}

%>
</body>
</html>