<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="check_uti.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*" %>
<%@page import="java.sql.ResultSet"%>
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
<jsp:include page="../jsp_scripts/header_nav.jsp"/>
<%
	Category cat = new Category();
	ResultSet set = cat.get_categories();
%>
		<section class="container">

			<section id="spacer2">
				<div class="search" id="slider_content1">
					<form name="search" action="../getsearch" method="get">
							<select name="category">
								<option value="0">Επέλεξε την κατηγορία σου</option>
							   <%
							   int i=0;
					        while (set.next())
							{
					        	i++;
							%>
					            <option value="<%out.print(set.getString("category_id"));%>" name="<%out.print(set.getString("value"));%>" id="<%out.print(set.getString("value"));%>"><%out.print(set.getString("value"));%></option>
					       <%}
							   %>
							</select>
							&nbsp;&nbsp;<input type="text" name="text">
							&nbsp;<input type="submit" name="start_search" class="button" value="Search"/>
					</form>
				</div>

	            <div id="slides">
	                <img src="/TED/img/1.png" alt="Some alt text">
	                <img src="/TED/img/2.jpg" alt="Some alt text">
	                <img src="/TED/img/3.png" alt="Some alt text">
	            </div>
	        </section>
        </section>
        <section>

	        <div class="search2" id="search2">
				<form name="search" action="../getsearch" method="get">
						<p align="center"><select name="category">
							<option value="0">Επέλεξε την κατηγορία σου</option>
						   <%
						    i=0;
				        while (set.previous())
						{
				        	i++;
						%>
				            <option value="<%out.print(set.getString("category_id"));%>" name="<%out.print(set.getString("value"));%>" id="<%out.print(set.getString("value"));%>"><%out.print(set.getString("value"));%></option>
				       <%}
						   %>
						</select>
						<input type="text" name="text"></p>
						<p align="center"><input type="submit" name="start_search" class="button" value="Search"/></p>
				</form>
			</div>

        </section>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		Item item = new Item(log.getName(),3);
		LinkedList<String> usernames = item.getListNeighUsers();



		//out.println("<center><h1>Welcome: " + log.getName() + "</h1>");
%>
<!-- 	<p align="center"><b><a href="auction/live_auctions.jsp">Διαχείριση Δημοπρασιών</a></b></p>
		<p align="center"><b><a href="auction/find_auction.jsp">Αναζήτηση Δημοπρασιών</a></b></p>
-->

<%

		if(usernames != null)
		{
			NeighItems neighItems = new NeighItems(usernames,log.getName());
			LinkedList<FriendItems> friendItems = neighItems.getFriendList();


			if(friendItems != null)
			{
%>
				<section id="spacer">
		            <p>Προτεινόμενα Προϊόντα</p>
		        </section>
		        <section id="boxcontent" >
<%
						  for(FriendItems elem: friendItems)
						  {

%>
							<h2 class="hidden">Adipiscing</h2>
				            <article>
				                <a href="auction/item_details.jsp?item=<%out.print(elem.getItemID());%>"><img src="<%if(elem.getPhotoURL() != null) out.print(elem.getPhotoURL());
			        				else out.print("/TED/img/item3.png");
			        			  %>" width="80" height="80"></a>
				                <h3><a href="auction/item_details.jsp?item=<%out.print(elem.getItemID());%>"><%out.print(elem.getName());%></a></p></h3>
				                <p>
				                <%out.print(elem.getCurrentPrice()+"$");%></p>
				            </article>
<%
						  }
%>
				</section>
<%
			}
		}
%>


<%
	}
	else
	{

	}
%>
		<jsp:include page="../jsp_scripts/footer.jsp"/>



</body>




     	<script>
			$(function()
			{
				$('#slides').slidesjs
				({
					height: 350,
					navigation: false,
					pagination: false,
					effect:
					{
						fade:
						{
							speed: 400
						}
					},callback:
					{

						complete: function(number)
						{
							$("#slider_content" + number).delay(500).fadeIn(1000);
						}
					},
					play:
					{
						active: false,
						auto: true,
						interval: 6000,
						pauseOnHover: false
					}
				});
			});
		</script>


</html>