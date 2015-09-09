<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="maps.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Openstreetmap</title>
	</head>
	<body>
		<% 
		double x = 0; 
		double y = 0; 
		GetLocation locations = new GetLocation("mariospassaris");
		x = locations.getLatitude();
		y = locations.getLongitude();
		%>
		<!-- -->
		<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" 
		src="http://www.openstreetmap.org/export/embed.html?
		bbox=30.1171875%2C32.879587173066305%2C21.9482421875%2C43.26120612479979&amp;
		layer=mapnik&amp;marker=<%=x%>%2C<%=y%>" 
		style="border: 0px solid black">
		</iframe>
		<br/>
		<small><a href="http://www.openstreetmap.org/?mlat=38.255&amp;mlon=23.533#map=6/38.255/23.533">View Larger Map</a></small>
		<!-- -->
	</body>
</html>