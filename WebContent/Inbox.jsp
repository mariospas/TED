<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="messages.*" import="java.sql.ResultSet"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Inbox</title>
	</head>
	<body>
		<h4>Sent and Received messages</h4>
		Inbox <br>
		<%
		RetrieveMessages msg = new RetrieveMessages();
		ResultSet inbox = msg.getInbox();
		
		while (inbox.next()) {
			if (inbox.getInt("msgID")==123) {
				msg.delReceived(inbox.getInt("msgID"));
			}
			if (inbox.getInt("rec_del") == 0) {
		%>
		
			<table>
				<tbody>
					<tr>
						<td>Message ID :</td>
						<td><%= inbox.getInt("msgID") %></td>
					</tr>
					<tr>
						<td>Message Text :</td>
						<td><%= inbox.getString("msgText") %></td>
					</tr>
				</tbody>
			</table>
		
		<% } } %>
		
		<a href="Outbox.jsp">Sent</a>
		<a href="DeleteMessages.jsp">Delete Messages</a>
	</body>
</html>