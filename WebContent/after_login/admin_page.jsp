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
<jsp:include page="../jsp_scripts/header_nav.jsp"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log == null || !(log.getType().equals("admin")) )
	{
		out.println("<center><h1>Permission Denied</h1>");
	}
	else
	{
		int pagin = 1;
		int recordsPerPage = 10;
		if(request.getParameter("pagin") != null) {
    	pagin = Integer.parseInt(request.getParameter("pagin"));
		}
		DataCheck data_check = new DataCheck();
		Users users = new Users();
		ResultSet set = users.all_users((pagin-1)*recordsPerPage, recordsPerPage);

		int noOfRecords = users.getNoOfRecords();
    int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

    request.setAttribute("noOfPages", noOfPages);
    request.setAttribute("currentPage", pagin);

%>
		<p id="create_auct" align="center" ><b><a href="auction/create_xml.jsp">Δημιουργία XML</a></b></p>
		<p id="create_auct" align="center" ><b><a href="import_xml.jsp">Εισαγωγή XML</a></b></p>




			<form method="post" action="change_profile_info/admin_profile.jsp">
			<table id="miyazaki" align="center">
            <caption>Username</caption>
            <thead>
			<tr>
			  <th>Όνομα Χρήστη
			  <th>Κωδικός
			  <th>Όνομα
			  <th>Επώνυμο
			  <th>Επιβεβαιωμένος
			  <th>Επιλογή
			<tbody>
<%
		while (set.next())
		{
%>

			<tr>
			  <td id="username" name="username"><%out.print(set.getString("username"));%>
			  <td id="password" name="password"><%out.print(set.getString("password"));%>
			  <td id="firstname" name="firstname"><%out.print(set.getString("firstname"));%>
			  <td id="lastname" name="lastname"><%out.print(set.getString("lastname"));%>
			  <td id="ready" name="ready"><%out.print(set.getString("ready"));%>
			  <td><input type="radio" name="uname" value="<%out.print(set.getString("username"));%>" id="uname">



<%
		}
%>
		</table>
		</br>
		<div align="center">
			<input align="center" TYPE="submit" name="sub" id="sub" value="Άνοιγμα Προφιλ"/>
		</div>
		</form>
<%
	}
%>
	<div class="pagination">
		<%
		int pg = (int) request.getAttribute("currentPage");
		if (pg != 1){
		%>
			<a href="admin_page.jsp?pagin=<%= pg - 1 %>">Προηγούμενη</a>
		<% } %>

		<%
		int k = 1;
		int num = (int) request.getAttribute("noOfPages");
		System.out.println("number of pages = " +num);
		for (k = 1; k <= num; k++){
			if (pg == k) { %>
				<span class="crrnt"><%= k %></span>
			<% } else if (pg==(k-1)){%>
				<a href="admin_page.jsp?pagin=<%= pg + 1 %>"><%= k %></a>
			<% } %>
		<% } %>

		<%
		if (pg < num) {
		%>
			<a href="admin_page.jsp?pagin=<%= pg + 1 %>">Επόμενη</a>
		<% } %>
	</div>

	<jsp:include page="../jsp_scripts/footer.jsp"/>
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