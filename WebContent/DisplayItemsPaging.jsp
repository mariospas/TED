<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Results</title>
	</head>
	<body>
		<h4>Results with Paging</h4>
		
		<%
		ResultSet results = (ResultSet) request.getAttribute("items");
		//int a = (int) request.getAttribute("noOfPages");
	  //System.out.println("number of pages = " +a);
		System.out.println("ok so far 3");
		while (results.next()) {
			//System.out.println("ok so far 4");
		%>
    
    	<p align="left">
			Result: <%= results.getString("name") %> <br>
			Description: <%= results.getString("description") %> </p>
    
    <% } %>
    
		<% System.out.println("ok so far 5"); %>
    <%
    int pg = (int) request.getAttribute("currentPage");
    if (pg != 1){
    %>	
    	<a href="getsearchpaging?page=<%= pg - 1 %>">Previous</a>
    <% } %>
    
    <%
    int k = 1;
    int num = (int) request.getAttribute("noOfPages");
    System.out.println("number of pages = " +num);
    for (k = 1; k <= num; k++){
    	if (pg == k) { %>
    		<%= k %>
    	<% } else {%>
    		<a href="getsearchpaging?page=<%= k %>"><%= k %></a>
    	<% } %>
    <% } %>
    
    <%
    if (pg < num) {
    %>
    	<a href="getsearchpaging?page=<%= pg + 1 %>">Next</a>
    <% } %>
	</body>
</html>








