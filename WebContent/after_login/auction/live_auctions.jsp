<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>General HomePage</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_live_auctions.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_table.css" type="text/css" media="screen" />
        <link href="/TED/appearance/css/lightbox.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans|Baumans' rel='stylesheet' type='text/css'/>
        <script src="/TED/appearance/scripts/modernizr.custom.04512.js"></script>
        <script src="/TED/appearance/scripts/respond.js"></script>

        <!-- include extern jQuery file but fall back to local file if extern one fails to load !-->
        <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text\/javascript" src="js\/1.7.2.jquery.min"><\/script>')</script>

        <script async src="/TED/appearance/scripts/lightbox.js"></script>
        <script src="/TED/appearance/scripts/prefixfree.min.js"></script>
        <script src="/TED/appearance/scripts/jquery.slides.min.js"></script>


        <script>
			(function ($, window, document, undefined)
			{
				'use strict';
				$(function ()
				{
					$("#mobileMenu").hide();
					$(".toggleMobile").click(function()
					{
						$(this).toggleClass("active");
						$("#mobileMenu").slideToggle(500);
					});
				});
				$(window).on("resize", function()
				{

					if($(this).width() > 700)
					{
						$("#mobileMenu").hide();
						$(".toggleMobile").removeClass("active");
					}

				});
			})(jQuery, window, document);
		</script>



    </head>
<body>
<jsp:include page="../../jsp_scripts/header_nav.jsp"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		DataCheck data_check = new DataCheck();
%>
		<p id="create_auct" align="center" ><b><a href="create_auction.jsp">Δημιουργία Δημοπρασίας</a></b></p>
		</br>

<%
		Auctions auctions = new Auctions(log.getName());
		ResultSet set = auctions.online_auctions();
		long item = -1;
		ResultSet item_set = null;
%>
		<!-- <p align="center"><b>Δημοπρασίες σε Εξέλιξη</b></p>-->
		<form method="post" action="edit_on_auction.jsp">
			<table id="miyazaki" align="center">
            <caption>Δημοπρασίες σε Εξέλιξη</caption>
            <thead>
                <tr>
				  <th>Φωτογραφία
                  <th>Κωδικός Προϊόντος
                  <th>Όνομα
                  <th>Τωρινή Τιμή
                  <th>Τιμή Αγοράς
                  <th>Αρχικό bid
                  <th>Εκκίνηση
                  <th>Τερματισμός
                  <th>Επιλογή
			<tbody>
<%
			while (set.next())
			{
				item  = set.getLong("item_id");
				item_set = auctions.requested_item(item);
				while (item_set.next())
				{
%>

					<tr>
					  <td id="photo_url" name="photo_url"><img src="<%out.print(item_set.getString("photo_url"));%>" width="60" height="60">
					  <td id="item_id" name="item_id"><%out.print(item_set.getLong("item_id"));%>
					  <td id="name" name="name"><%out.print(item_set.getString("name"));%>
					  <td id="currently_price" name="currently_price"><%out.print(item_set.getFloat("currently_price"));%>
					  <td id="buy_price" name="buy_price"><%out.print(item_set.getFloat("buy_price"));%>
					  <td id="first_bid" name="first_bid"><%out.print(item_set.getFloat("first_bid"));%>
					  <td id="start_date" name="start_date"><%out.print(item_set.getDate("start_date"));%>
					  <td id="end_date" name="end_date"><%out.print(item_set.getDate("end_date"));%>
					  <td><input type="radio" name="item" value="<%out.print(item_set.getLong("item_id"));%>" id="item">


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
		<!-- <p align="center"><b>Απενεργοποιημένες Δημοπρασίες</b></p>-->
		<form method="post" action="edit_auction.jsp">
			<table id="miyazaki" align="center">
            <caption>Απενεργοποιημένες Δημοπρασίες</caption>
            <thead>
				<tr>
			  		<th>Φωτογραφία
	                <th>Κωδικός Προϊόντος
	                <th>Όνομα
	                <th>Τωρινή Τιμή
	                <th>Τιμή Αγοράς
	                <th>Αρχικό bid
	                <th>Εκκίνηση
	                <th>Τερματισμός
	                <th>Επιλογή
			<tbody>
<%
			while (set.next())
			{
				item  = set.getLong("item_id");
				item_set = auctions.requested_item(item);
				while (item_set.next())
				{
%>
					<tr>
					  <td id="photo_url" name="photo_url"><img src="<%out.print(item_set.getString("photo_url"));%>" width="60" height="60">
					  <td id="item_id" name="item_id"><%out.print(item_set.getLong("item_id"));%>
					  <td id="name" name="name"><%out.print(item_set.getString("name"));%>
					  <td id="currently_price" name="currently_price"><%out.print(item_set.getFloat("currently_price"));%>
					  <td id="buy_price" name="buy_price"><%out.print(item_set.getFloat("buy_price"));%>
					  <td id="first_bid" name="first_bid"><%out.print(item_set.getFloat("first_bid"));%>
					  <td id="start_date" name="start_date"><%out.print(item_set.getString("start_date"));%>
					  <td id="end_date" name="end_date"><%out.print(item_set.getString("end_date"));%>
					  <td><input type="radio" name="item" value="<%out.print(item_set.getLong("item_id"));%>" id="item">


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
	<jsp:include page="../../jsp_scripts/footer.jsp"/>
</body>
	<script>
			var headertext = [];
			var headers = document.querySelectorAll("#miyazaki th"),
			tablerows = document.querySelectorAll("#miyazaki th"),
			tablebody = document.querySelector("#miyazaki tbody");
			for(var i = 0; i < headers.length; i++) {
				var current = headers[i];
				headertext.push( current.textContent.replace( /\r?\n|\r/,"") );
			}
			for (var i = 0, row; row = tablebody.rows[i]; i++) {
				for (var j = 0, col; col = row.cells[j]; j++) {
					col.setAttribute("data-th", headertext[j]);
				}
			}
	 </script>
</html>