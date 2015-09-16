<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>General HomePage</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_create_item.css" type="text/css" media="screen" />
        <link href="/TED/appearance/css/lightbox.css" rel="stylesheet" />
        <link href="/TED/appearance/css/acordeon.css" rel='stylesheet' type='text/css' />
        <link rel="stylesheet" type="text/css" href="../../css/after_login/auction/create_auction.css">
        <link href='http://fonts.googleapis.com/css?family=Open+Sans|Baumans' rel='stylesheet' type='text/css'/>
        <script src="/TED/appearance/scripts/modernizr.custom.04512.js"></script>
        <script src="/TED/appearance/scripts/respond.js"></script>

        <!-- include extern jQuery file but fall back to local file if extern one fails to load !-->
        <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text\/javascript" src="js\/1.7.2.jquery.min"><\/script>')</script>

        <script async src="/TED/appearance/scripts/lightbox.js"></script>
        <script src="/TED/appearance/scripts/prefixfree.min.js"></script>
        <script src="/TED/appearance/scripts/jquery.slides.min.js"></script>
        <script src="../../scripts/checkFileSize.js"></script>
		<script src="../../scripts/saveDataAndFill.js"></script>


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
		    var expanded = false;
		    function showCheckboxes() {
		        var checkboxes = document.getElementById("checkboxes");
		        if (!expanded) {
		            checkboxes.style.display = "block";
		            expanded = true;
		        } else {
		            checkboxes.style.display = "none";
		            expanded = false;
		        }
		    }
		</script>



</head>

<body>
<jsp:include page="../../jsp_scripts/header_nav.jsp"/>
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
				%>
			    <p align="center"><b><a href="item_details.jsp?item=<%out.print(item_id);%>">Επιστροφή</a></b></p>
			<%
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
			    <p align="center" style="font-size:20px; margin-top:20px;"><label>Είστε σίγουρος για την προσφορά σας <%out.print(bid+"€");%> στο
			    <a href="item_details.jsp?item=<%out.print(item_id);%>"><%out.print(item_id);%></a> ?
			    		 <br/> Πιέστε Ναι για συνέχεια ή Άκυρο για επιστροφή </label></p>
		        <br/>
		        <p style="margin-left:100px;"><input TYPE="submit" name="sub" id="sub" title="Add data to the Database" value="Ναι"/></p>
		        <p style="margin-left:80px;"><input type="button" onclick="history.go(-1);" value="Άκυρο"></p>
	    	</form>
	<%
		}
	}
	else
	{
		out.println("<center><h1> Guest Mode Permission Denied</h1></center>");
	}
%>
<jsp:include page="../../jsp_scripts/footer.jsp"/>
</body>
</html>