<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>General Homepage</title>
</head>
<body>
<jsp:include page="../logout.html"/>
<jsp:include page="profile_button.html"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		out.println("<center><h1>Welcome: " + log.getName() + "</h1>");
%>
		<p align="center"><b><a href="auction/live_auctions.jsp">Διαχείριση Δημοπρασιών</a></b></p>
		<p align="center"><b><a href="auction/find_auction.jsp">Αναζήτηση Δημοπρασιών</a></b></p>
<%}
	else
	{
		out.println("<center><h1> Guest Mode </h1></center>");
%>
		<p align="center"><b><a href="auction/find_auction.jsp">Αναζήτηση Δημοπρασιών</a></b></p>
<%
	}
%>

</body>
</html>