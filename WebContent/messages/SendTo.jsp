<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="messages.*" import="java.sql.ResultSet" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Send Message</title>
	</head>
	<body>
		<%
		RetrieveUsers chat = new RetrieveUsers();
		List<String> clients = new ArrayList<String>();
		List<String> sellers = new ArrayList<String>();
		%>
		
		<h3>Clients</h3>
		
		<%
		clients = chat.RetrieveClients("mariospassaris");
		for (String elem : clients) {
		%>
		
			<a href="newInbox.jsp?user=<%= elem %>"><%= elem %></a>
			
		<% } %>
		
		<h3>Sellers</h3>
		
		<%
		sellers = chat.RetrieveSellers("mariospassaris");
		for (String elem : sellers) {
		%>
		
			<a href="newInbox.jsp?user=<%= elem %>"><%= elem %></a>
			
		<% } %>

	</body>
</html>