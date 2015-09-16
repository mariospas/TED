<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page import="check_uti.*"%>
<%@ page import="import_update_DB.*"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>General HomePage</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style.css" type="text/css" media="screen" />
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



		<script>
		function jqUpdateSize(){
		    // Get the dimensions of the viewport
		    var width = $(window).width();
		    var height = $(window).height();

		    $('#jqWidth').html(width);      // Display the width
		    $('#jqHeight').html(height);    // Display the height

	    	if(width < 700) $(".search2").show();
	    	else if(width > 700) $(".search2").hide();

		};
		$(document).ready(jqUpdateSize);    // When the page first loads
		$(window).resize(jqUpdateSize);
		</script>


    </head>
<body>
<jsp:include page="jsp_scripts/header_nav.jsp"/>
<%
	request.setCharacterEncoding("UTF-8");
	int x;
	String name = request.getParameter("uname");
	check ch = new check(name);

	x = ch.getAvailability();
	if (x == 1)
	{
		String password = request.getParameter("password");
		String firstname = request.getParameter("onoma");
		String lastname = request.getParameter("epitheto");
		String email = request.getParameter("taxudromio");
		String telephone = request.getParameter("thl");
		String country = request.getParameter("country");
		String city = request.getParameter("city");
		String address = request.getParameter("address");
		String tk = request.getParameter("tk");
		String afm = request.getParameter("afm");

		ImportUpdateDB eisagogh = new ImportUpdateDB();
		eisagogh.importUser(name, password, firstname, lastname, email, telephone, address, tk, city, country, afm);


		//String site = new String("after_login/successful_registration.html");
		//response.setStatus(response.SC_MOVED_TEMPORARILY);
		//response.setHeader("Location", site);
%>
		<p align="center" style="font-size:20px;">Εκκρεμεί η έγκριση της αίτησης εγγραφής σας στην εφαρμογή από τον διαχειριστή.</p>
<%
	}
	else
	{
		out.println("<h1 align=\"center\">Το όνομα χρήστη "+ name + " υπάρχει ήδη</h1>");
%>
		<p align="center" style="font-size:20px;"><a href="registration.jsp">Επιστροφή στην σελίδα εγγραφής!</a></p>
<%
	}
%>
<jsp:include page="jsp_scripts/footer.jsp"/>
</body>
</html>