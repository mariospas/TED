<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="check_uti.*"%>
<%@ page import="xml_mars_unmars.*"%>
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
		DataCheck data_check = new DataCheck();
		Item item = new Item(log.getName(),7);
		LinkedList<String> usernames = item.getListNeighUsers();
		out.println("<center><h1>Welcome: " + log.getName() + "</h1>");
%>
		<p align="center"><b><a href="auction/live_auctions.jsp">Διαχείριση Δημοπρασιών</a></b></p>
		<p align="center"><b><a href="auction/find_auction.jsp">Αναζήτηση Δημοπρασιών</a></b></p>
<%

		if(usernames != null)
		{
			NeighItems neighItems = new NeighItems(usernames);
			LinkedList<FriendItems> friendItems = neighItems.getFriendList();

			if(friendItems != null)
			{
%>
				<div>
					<p align="center">Προτεινόμενα Προϊόντα</p>
					<table align="center" width="<%out.print(friendItems.size() * 100);%>" border="1">
						<tr>
<%
						  for(FriendItems elem: friendItems)
						  {
%>
						  	<td>
							  	<p align="center"><a href="auction/item_details.jsp?item=<%out.print(elem.getItemID());%>"><%out.print(elem.getName());%></a></p>

								<p align="center"><a href="auction/item_details.jsp?item=<%out.print(elem.getItemID());%>"><img src="<%out.print(elem.getPhotoURL());%>" width="80" height="80"></a></p>

								<p align="center"><%out.print(elem.getCurrentPrice()+"$");%></p>
						  	</td>
<%
						  }
%>
						</tr>
					</table>

				</div>
<%
			}
		}
%>


<%
	}
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