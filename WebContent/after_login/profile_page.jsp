<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>General HomePage</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_live_auctions.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_table_profil.css" type="text/css" media="screen" />
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
<jsp:include page="../jsp_scripts/header_nav.jsp"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		out.println("<center><h1>Πληροφορίες Προφίλ : " + log.getName() + "</h1>");
		Profile prof = new Profile(log.getName());
		ResultSet set = prof.profile_info();
		while (set.next())
		{
%>
			<table id="miyazaki" align="center">
			<thead>
			<tbody>
			  <tr>
			    <th>Όνομα Χρήστη
			    <td><%out.print(set.getString("username"));%>

			  <tr>
			    <th>Όνομα
			    <td><%out.print(set.getString("firstname"));%>

			  <tr>
			    <th>Επώνυμο
			    <td><%out.print(set.getString("lastname"));%>

			  <tr>
			    <th>Email
			    <td><%out.print(set.getString("email"));%>

			  <tr>
			    <th>Τηλεφωνικός Αριθμός
			    <td><%out.print(set.getString("phone_number"));%>

			  <tr>
			    <th>Χώρα
			    <td><%out.print(set.getString("country"));%>

			  <tr>
			    <th>Πόλη
			    <td><%out.print(set.getString("city"));%>

			  <tr>
			    <th>Διεύθυνση
			    <td><%out.print(set.getString("address"));%>

			  <tr>
			    <th>Τ.Κ
			    <td><%out.print(set.getString("postal_code"));%>

			  <tr>
			    <th>Α.Φ.Μ
			    <td><%out.print(set.getString("afm"));%>

			</table>

			<div id="links">
				<p align="center"><a href="change_profile_info/change_info.jsp">Αλλαγή Στοιχείων</a></p>
				<p align="center"><a href="change_profile_info/change_pass.jsp">Αλλαγή Κωδικού</a></p>
			</div>

<%
		}
	}
	else
	{
		out.println("<center><h1>Error in profile page !!!</h1>");
	}

%>
<jsp:include page="../jsp_scripts/footer.jsp"/>
</body>

</html>