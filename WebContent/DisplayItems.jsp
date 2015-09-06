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
		<center><h4>Search Results</h4></center>
		
		<%
		ResultSet results = (ResultSet) request.getAttribute("items");	
		System.out.println("CATEGORY = " +request.getParameter("text"));
		
		//Check if there are any search results
		if (!results.isBeforeFirst() ) {    
			 out.println("<center>Sorry but we couldn't find anything</center>");
			 return;
		}
		
		if ((int) request.getAttribute("match") == 1) {
			out.println("<center>Did you mean</center>");
		}
		while (results.next()) {
		%>
			
			<p align="left">
			Result: <%= results.getString("name") %> <br>
			Description: <%= results.getString("description") %> </p>
		 	
		<% } %>
		
		<% System.out.println("ok so far 5"); %>
		<form name="filter" action="getsearch" method="get">
			min. <input type="text" name="min">
			max. <input type="text" name="max">
			City <select name="city">
						 <option value="">Any</option>
					   <option value="Greece">Athens</option>
					   <option value="Greece">Thessaloniki</option>
					   <option value="Greece">Patra</option>
					 </select>
			<br> 
			<input type="submit" value="Apply">
		</form>
		 <%
    int pg = (int) request.getAttribute("currentPage");
    if (pg != 1){
    %>	
    	<a href="getsearch?page=<%= pg - 1 %>&category=<%= request.getParameter("category") %>&text=<%= request.getParameter("text") %>&country=<%= request.getParameter("city") %>&min=<%= request.getParameter("min") %>&max=<%= request.getParameter("max") %>">Previous</a>
    <% } %>
     
    <%
    int k = 1;
    int num = (int) request.getAttribute("noOfPages");
    System.out.println("number of pages = " +num);
    for (k = 1; k <= num; k++){
    	if (pg == k) { %>
    		<%= k %>
    	<% } else {%>
    		<a href="getsearch?page=<%= k %>&category=<%= request.getParameter("category") %>&text=<%= request.getParameter("text") %>&country=<%= request.getParameter("city") %>&min=<%= request.getParameter("min") %>&max=<%= request.getParameter("max") %>"><%= k %></a>
    	<% } %>
    <% } %>
    
    <%
    if (pg < num) {
    %>
    	<a href="getsearch?page=<%= pg + 1 %>&category=<%= request.getParameter("category") %>&text=<%= request.getParameter("text") %>&country=<%= request.getParameter("city") %>&min=<%= request.getParameter("min") %>&max=<%= request.getParameter("max") %>">Next</a>
    <% } %>
    
	</body>
</html>