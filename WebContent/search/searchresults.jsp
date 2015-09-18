<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="search.*" %>
<%@ page import="java.util.List" %>

<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Search Results</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/searchresults.css" type="text/css" media="screen" />
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

		<script src="scripts/checkTwoPass.js"></script>
		<script src="scripts/saveDataAndFill.js"></script>

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

	    	if(width < 700)
	    	{
	    		$(".search2").show();
	    		$(".search").hide();
	    	}
	    	else if(width > 700)
    		{
	    		$(".search2").hide();
	    		$(".search").show();
    		}

		};
		$(document).ready(jqUpdateSize);    // When the page first loads
		$(window).resize(jqUpdateSize);
		</script>

    </head>
	<body>
		<jsp:include page="/jsp_scripts/header_nav.jsp"/>
		<jsp:include page="/jsp_scripts/search_script.jsp"/>

		<section id="boxcontent" >
			<hr class="searchr">
			<h4 align="center" class="searchtitle">Αποτελέσματα Αναζήτησης</h4>

			<%
			ResultSet results = (ResultSet) request.getAttribute("items");
			Filter_max_count filter = new Filter_max_count(results);
			List<String> countries = filter.countries();
			float[] price = filter.max_minPrice();   //0 max 1 min
			results.beforeFirst();
			int i=0;

			//Check if there are any search results
			if (!results.isBeforeFirst() ) { %>
				<h4 align="center" class="searchtitle">Δυστυχώς δε μπορέσαμε να βρούμε κάποιο αποτέλεσμα</h4>
			<%
				return;
			}
			%>

			<% if ((int) request.getAttribute("match") == 1) { %>
			  	   <h4 align="center" class="searchtitle">Μήπως εννοείτε..</h4>
			<% } %>

			<section id=upper_filter>
				<article id="filters">
					<h4>Φίλτρα</h4>
					<form name="filter" action="getsearch" method="get">
						<hr>
						<p>Ελάχιστη τιμή</p>
						<select name="min">
							<option value="-100">Όλες</option>
						<%
							int count=0;
							int w = 0;
							while(count < price[0] && w < 3)
							{
								w++;
						%>
							<option value="<%out.print(count);%>"><%out.print(count);%> €</option>
						<%
								count = count+10;
							}
						%>
						</select>
						<p>Μέγιστη Τιμή</p>
						<select name="max">
							<option value="1000">Όλες</option>
						<%
							w = 0;
							while(count <= price[0] && w < 3)
							{
								w++;
						%>
							<option value="<%out.print(count);%>"><%out.print(count);%> €</option>
						<%
								count = count + 10;
							}
						%>
							<option value="<%out.print(Math.round(price[0]));%>"><%out.print(Math.round(price[0]));%> €</option>
						</select>
						<hr>
						<p>Χώρα</p>
						<select name="country">
							<option value="">Όλες</option>
						<%
							for(String elem : countries)
							{
						%>
							<option value="<%out.print(elem);%>"><%out.print(elem);%></option>
						<%
							}
						%>
						</select>
						<br/>
						<input type="hidden" name="category" value="<%= request.getParameter("category") %>">
						<input type="hidden" name="text" value="<%= request.getParameter("text") %>">
						<input type="submit" value="Υποβολή">
					</form>
				</article>
			</section>

			<div id="da-thumbs" class="da-thumbs">
				<%
				while (results.next()) {
					if(i%2 == 0) {
				%>

					<article class="results1">
						<a href="/TED/after_login/auction/item_details.jsp?item=<%=results.getString("item_id") %>">
							<% if (results.getString("photo_url") == null) { %>
								<img src="/TED/img/item3.png" alt="My Image" style="width:240px;height:240px;">
							<% } else { %>
								<img src="<%= results.getString("photo_url") %>" alt="My Image" style="width:240px;height:240px;">
							<% } %>
							<div>
								<span>
									<p class="mainame"><%= results.getString("name") %></p>
									<p>Τιμή: <%= results.getString("buy_price") %> €</p>
								</span>
							</div>
						</a>
					</article>
					<% } else { %>
					<article class="results2">
						<a href="/TED/after_login/auction/item_details.jsp?item=<%=results.getString("item_id") %>">
							<% if (results.getString("photo_url") == null) { %>
								<img src="/TED/img/item3.png" alt="My Image" style="width:240px;height:240px;">
							<% } else { %>
								<img src="<%= results.getString("photo_url") %>" alt="My Image" style="width:240px;height:240px;">
							<% } %>
							<div>
								<span>
									<p class="mainame"><%= results.getString("name") %></p>
									<p>Τιμή: <%= results.getString("buy_price") %> €</p>
								</span>
							</div>
						</a>
					</article>


					<% } %>
				<% ++i; } %>
				</div>
			<div class="pages">
			<%
			int pg = (int) request.getAttribute("currentPage");
			if (pg != 1){
			%>
				<a href="getsearch?page=<%= pg - 1 %>&category=<%= request.getParameter("category") %>&text=<%= request.getParameter("text") %>&country=<%= request.getAttribute("country") %>&min=<%= request.getAttribute("min") %>&max=<%= request.getAttribute("max") %>">Προηγούμενη</a>
			<% } %>

			<%
			int k = 1;
			int num = (int) request.getAttribute("noOfPages");
			System.out.println("number of pages = " +num);
			for (k = 1; k <= num; k++){
				if (pg == k) { %>
					<span class="currpage" ><%= k %></span>
				<% } else if (pg == k+1) {%>
					<a href="getsearch?page=<%= k %>&category=<%= request.getParameter("category") %>&text=<%= request.getParameter("text") %>&country=<%= request.getAttribute("country") %>&min=<%= request.getAttribute("min") %>&max=<%= request.getAttribute("max") %>"><%= k %></a>
				<% } %>
			<% } %>

			<%
			if (pg < num) {
			%>
				<a href="getsearch?page=<%= pg + 1 %>&category=<%= request.getParameter("category") %>&text=<%= request.getParameter("text") %>&country=<%= request.getAttribute("country") %>&min=<%= request.getAttribute("min") %>&max=<%= request.getAttribute("max") %>">Επόμενη</a>
			<% } %>
			</div>
		</section>
		<jsp:include page="/jsp_scripts/footer.jsp"/>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
		<script type="text/javascript" src="/TED/appearance/scripts/jquery.hoverdir.js"></script>
		<script type="text/javascript">
			$(function() {

				$(' #da-thumbs > article ').each( function() { $(this).hoverdir(); } );

			});
		</script>

	</body>
</html>