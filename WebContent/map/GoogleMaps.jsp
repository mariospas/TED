<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="maps.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Google Maps</title>
	</head>
	<body>
		<% 
		double latitude = 0; 
		double longitude = 0; 
		GetLocation2 locations = new GetLocation2("mariospassaris");
		latitude = locations.getLatitude();
		longitude = locations.getLongitude();
		%>
		<iframe 
			src="https://www.google.com/maps/embed?pb=!1m17!1m8!1m3!1d
			3178877.868245887!2d
			22.781871051269!3d
			38.91545309195277!3m2!1i1024!2i768!4f13.1!4m6!3e6!4m0!4m3!3m2!1d
			<%=latitude%>!2d
			<%=longitude%>!5e0!3m2!1sel!2sgr!4v1440257243539" 
			width="600" height="450" frameborder="0" style="border:0">
		</iframe>
	</body>
</html>