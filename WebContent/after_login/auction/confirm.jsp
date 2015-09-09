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
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../../logout.html"/>
<jsp:include page="../profile_button.html"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		request.setCharacterEncoding("UTF-8");
		String sub = request.getParameter("sub");
		if(sub != null && sub.equals("Ναι"))
		{
			String item_name = request.getParameter("item");
			long item_id = Long.parseLong(item_name);
			String bid_string = request.getParameter("bid");
			float bid = Float.parseFloat(bid_string);

			Auctions auction = new Auctions(log.getName(),item_id,bid);
			boolean b = auction.addBid();
			if(b)
			{
				String site = new String("item_details.jsp?item="+item_id);
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site);
			}
			else
			{
			%>

			    <p align="center">Παρακαλώ εισάγεται προσφορά μεγαλύτερη από την τωρινή τιμή !</p>
			    <p align="center"><b><a href="item_details.jsp?item=<%out.print(item_id);%>">Επιστροφή</a></b></p>
			<%
			}

		}
		else
		{
			String item_name = request.getParameter("item");
			//out.println("<p><b>"+item_name+"</b></p>");
			long item_id = Long.parseLong(item_name);
			String bid_string = request.getParameter("bid");
			float bid = Float.parseFloat(bid_string);
			//session.setAttribute("bid", bid);
	%>
			<form method="post" action="confirm.jsp?item=<%out.print(item_id);%>&bid=<%out.print(bid);%>" >
			    <p align="center"><label>Είστε σίγουρος για την προσφορά σας <%out.print(bid+"$");%> στο
			    <a href="item_details.jsp?item=<%out.print(item_id);%>"><%out.print(item_id);%></a> ?
			    		 <br/> Πιέστε Ναι για συνέχεια ή Άκυρο για επιστροφή </label></p>
		        <br/>
		        <p align="center"><input TYPE="submit" name="sub" id="sub" title="Add data to the Database" value="Ναι"/>
		        <input type="button" onclick="history.go(-1);" value="Άκυρο"></p>
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