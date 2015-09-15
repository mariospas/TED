<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="category.*"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>General HomePage</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_create_item.css" type="text/css" media="screen" />
        <link href="/TED/appearance/css/lightbox.css" rel="stylesheet" />
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
		Category cat = new Category();
		ResultSet set = cat.get_categories();
%>

	 <section id="all_form">
    	<div id="form_title">
        	<h2 align="center" style="font-size:24px;">Δημιουργία Δημοπρασίας!</h2>
        </div>

        <div class="main_form">
        	<form method="post" action="save_auction.jsp?id=create" ENCTYPE="multipart/form-data" >
            	<p><label>Όνομα :</label></p>
                <hr>
				<input type="text" id="name" name="name" style="width: 300px;" required/>
                <br/>
                <p><label>Κατηγορίες :</label></p>
                <hr>
                <div class="multiselect">
			        <div class="selectBox" onclick="showCheckboxes()">
			            <select required>
			                <option>Select an option</option>
			            </select>
			            <div class="overSelect"></div>
			        </div>
			        <div id="checkboxes">
			        <%
			        while (set.next())
					{
					%>
			            <label for="<%out.print(set.getString("value"));%>"><input type="checkbox" name="<%out.print(set.getString("value"));%>" id="<%out.print(set.getString("value"));%>"/><%out.print(set.getString("value"));%></label>
			       <%}
			        %>
			        </div>
			    </div>
				<br/>
                <p><label>Αρχική Προσφορά :</label></p>
                <hr>
           		<input type="text" id="first_bid" name="first_bid" required/>
                <br/>
                <p><label>*Τιμή Αγοράς :</label></p>
                <hr>
				<input type="text" id="buy_price" name="buy_price"  />
                <br/>
                <p><label>Location : (latitude;longtitude e.g 2.458;3.589)</label></p>
                <hr>
				<input type="text" id="latlong" name="latlong" required/>
                <br/>
                <p><label>Χώρα :</label></p>
                <hr>
				<input type="text" id="country" name="country" required/>
                <br/>
                <p><label>Ημερομηνία και Ώρα έναρξης :</label></p>
                <hr>
				<input type="date" id="start_date" name="start_date" required />
				<input type="time" id="start_time" name="start_time" required />
				<br/>
                <p><label>Ημερομηνία και Ώρα Τερματισμού :  :</label></p>
                <hr>
                <input type="date" id="end_date" name="end_date" required />
				<input type="time" id="end_time" name="end_time" required />
				<br/>
                <p><label>* Φωτογραφία :</label></p>
                <hr>
                <input type="hidden" name="size" value="1048576">
                <input type="file" name="photo" id="i_file">
                </br>
                <p><label>Περιγραφή  :</label></p>
                <hr>
				<input type="text" id="description" name="description" style="width: 98%; height: 300px;" required />
                <br/>
                <br/>
                <input TYPE="submit" name="sub_button" id="sub_button" title="Add data to the Database" value="Αποθήκευση"/>
            </form>
       </div>
    </section>


    <script type="text/javascript">

			rescuefieldvalues(['name', 'currently_price', 'first_bid', 'buy_price', 'latlong', 'country', 'start_date', 'end_date']);

	</script>
<%
	}
	else
	{
		out.println("<center><h1> Permission Denied </h1></center>");
	}
%>
<jsp:include page="../../jsp_scripts/footer.jsp"/>
</body>
</html>