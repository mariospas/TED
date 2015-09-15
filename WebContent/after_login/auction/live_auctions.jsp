<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ζωντανές Δημοπρασίες</title>
</head>
<body>
<jsp:include page="../../logout.html"/>
<jsp:include page="../profile_button.html"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		DataCheck data_check = new DataCheck();
%>
		<p align="center"><b><a href="create_auction.jsp">Δημιουργία Δημοπρασίας</a></b></p>
		</br>

<%
		Auctions auctions = new Auctions(log.getName());
		ResultSet set = auctions.online_auctions();
		long item = -1;
		ResultSet item_set = null;
%>
		<p align="center"><b>Δημοπρασίες σε Εξέλιξη</b></p>
		<form method="post" action="https://snf-674750.vm.okeanos.grnet.gr:8443/TED/after_login/auction/edit_on_auction.jsp">
			<table align="center" width="700" border="1">
			<tr>
			  <td>Φωτογραφία</td>
			  <td>Κωδικός Προϊόντος</td>
			  <td>Όνομα</td>
			  <td>Τωρινή Τιμή</td>
			  <td>Τιμή Αγοράς</td>
			  <td>Αρχικό bid</td>
			  <td>Εκκίνηση</td>
			  <td>Τερματισμός</td>
			  <td>Επιλογή</td>
			</tr>
<%
			while (set.next())
			{
				item  = set.getLong("item_id");
				item_set = auctions.requested_item(item);
				while (item_set.next())
				{
%>

					<tr>
					  <td id="photo_url" name="photo_url"><img src="<%out.print(item_set.getString("photo_url"));%>" width="60" height="60"></td>
					  <td id="item_id" name="item_id"><%out.print(item_set.getLong("item_id"));%></td>
					  <td id="name" name="name"><%out.print(item_set.getString("name"));%>;</td>
					  <td id="currently_price" name="currently_price"><%out.print(item_set.getFloat("currently_price"));%></td>
					  <td id="buy_price" name="buy_price"><%out.print(item_set.getFloat("buy_price"));%></td>
					  <td id="first_bid" name="first_bid"><%out.print(item_set.getFloat("first_bid"));%>;</td>
					  <td id="start_date" name="start_date"><%out.print(item_set.getDate("start_date"));%></td>
					  <td id="end_date" name="end_date"><%out.print(item_set.getDate("end_date"));%></td>
					  <td><input type="radio" name="item" value="<%out.print(item_set.getLong("item_id"));%>" id="item"></td>
					</tr>

<%
				}

			}
%>
			</table>
			</br>
			<div align="center">
				<input align="center" TYPE="submit" name="sub" id="sub" value="Επεξεργασία"/>
			</div>
		</form>

<%
		auctions = new Auctions(log.getName());
		set = auctions.offline_auctions();
		item = -1;
		item_set = null;
%>
		<p align="center"><b>Απενεργοποιημένες Δημοπρασίες</b></p>
		<form method="post" action="https://snf-674750.vm.okeanos.grnet.gr:8443/TED/after_login/auction/edit_auction.jsp">
			<table align="center" width="700" border="1">
			<tr>
			  <td>Φωτογραφία</td>
			  <td>Κωδικός Προϊόντος</td>
			  <td>Όνομα</td>
			  <td>Τωρινή Τιμή</td>
			  <td>Τιμή Αγοράς</td>
			  <td>Αρχικό bid</td>
			  <td>Εκκίνηση</td>
			  <td>Τερματισμός</td>
			  <td>Επιλογή</td>
			</tr>
<%
			while (set.next())
			{
				item  = set.getLong("item_id");
				item_set = auctions.requested_item(item);
				while (item_set.next())
				{
%>
					<tr>
					  <td id="photo_url" name="photo_url"><img src="<%out.print(item_set.getString("photo_url"));%>" width="60" height="60"></td>
					  <td id="item_id" name="item_id"><%out.print(item_set.getLong("item_id"));%></td>
					  <td id="name" name="name"><%out.print(item_set.getString("name"));%>;</td>
					  <td id="currently_price" name="currently_price"><%out.print(item_set.getFloat("currently_price"));%></td>
					  <td id="buy_price" name="buy_price"><%out.print(item_set.getFloat("buy_price"));%></td>
					  <td id="first_bid" name="first_bid"><%out.print(item_set.getFloat("first_bid"));%>;</td>
					  <td id="start_date" name="start_date"><%out.print(item_set.getString("start_date"));%></td>
					  <td id="end_date" name="end_date"><%out.print(item_set.getString("end_date"));%></td>
					  <td><input type="radio" name="item" value="<%out.print(item_set.getLong("item_id"));%>" id="item"></td>
					</tr>

<%
				}

			}
%>
			</table>
			</br>
			<div align="center">
				<input align="center" TYPE="submit" name="sub" id="sub" value="Ενεργοποίηση"/>
				<input align="center" TYPE="submit" name="sub" id="sub" value="Επεξεργασία"/>
				<input align="center" TYPE="submit" name="sub" id="sub" value="Διαγραφή"/>
			</div>
		</form>


<%


	}
	else
	{
		out.println("<center><h1> Guest Mode Permission Denied</h1></center>");
	}
%>
</body>
</html>