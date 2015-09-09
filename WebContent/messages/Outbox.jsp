<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="messages.*" import="java.sql.ResultSet"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Sent Messages</title>
	</head>
	<body>
		<h4>Sent Messages</h4>
		<%
		RetrieveMessages msg = new RetrieveMessages();
		ResultSet outbox = msg.getSent();
		
		while (outbox.next()) {
			if (outbox.getInt("usr_del") == 0) {
		%>
		
			<table>
				<tbody>
					<tr>
						<td>Message ID :</td>
						<td><%= outbox.getInt("msgID") %></td>
					</tr>
					<tr>
						<td>Message Text :</td>
						<td><%= outbox.getString("msgText") %></td>
					</tr>
					<tr>
						<td>Recipient :</td>
						<td><%= outbox.getString("recipient") %></td>
					</tr>
				</tbody>
			</table>
		
		<% } } %>
	</body>
</html>