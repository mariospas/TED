<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Δημοπρασία</title>
</head>
<body>
<jsp:include page="../../logout.html"/>
<jsp:include page="../profile_button.html"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{

		request.setCharacterEncoding("UTF-8");

		String item_name = request.getParameter("item");
		//out.println("<p><b>"+item_name+"</b></p>");
		long item_id = Long.parseLong(item_name);
		Auctions auction = new Auctions(log.getName());

		Category cat = new Category();
		ResultSet item_set = auction.requested_item(item_id);
		ResultSet item_cat = cat.get_categories(item_id);
		while (item_set.next())
		{
%>
			<div id="all_form">
		    	<div id="form_title">
		        	Δημοπρασία
		        </div>
		            	<p><label>Όνομα : <%out.print(item_set.getString("name"));%></label>
		                <br/>
		                <img src="<%out.print(item_set.getString("photo_url"));%>" width="120" height="120">
		                <br/>
		                <p><label>Κατηγορίες :
<%
			        	while (item_cat.next())
						{
%>
		            		<%out.print(item_cat.getString(1));%> </label></p>
<%
			        	}
%>
						<br/>
		                <p><label>Τωρινή Τιμή : <%out.print(item_set.getString("currently_price"));%></label>
		                <br/>
		                <%
		                if(item_set.getString("buy_price") != null)
		                {
		                %>
		                <p><label>Τιμή Αγοράς : <%out.print(item_set.getString("buy_price"));%></label>
						<%
		                }
						%>
		                <br/>
		                <p><label>Location : <%out.print(item_set.getString("location"));%></label></p>
						<br/>
		                <p><label>Χώρα : <%out.print(item_set.getString("country"));%></label>
						<br/>
		                <p><label>Ημερομηνία Έναρξης : <%out.print(item_set.getString("start_date"));%></label>
		                <p><label>Ημερομηνία Τερματισμού : <%out.print(item_set.getString("end_date"));%></label>
						<br/>
		               	<p><label>Περιγραφή  :</label>
		                </br>
						<p><%out.print(item_set.getString("description"));%>" required /></p>
		                <br/>
		    </div>
		    <form method="post" action="confirm.jsp" >
			    <p><label>Δώστε μία Προσφορά :</label>
				<input type="text" id="bid" name="bid" required/></p>
	            <br/>
	            <input TYPE="submit" name="sub_button" id="sub_button" title="Add data to the Database" value="Προσθήκη"/>
		    </form>
<%
		}
	}
	else
	{
		out.println("<center><h1> Guest Mode Permission Denied</h1></center>");
	}
%>
</body>
</html>