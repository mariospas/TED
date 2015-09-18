<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="messages.*" import="java.sql.ResultSet" import="java.util.*"%>
<%@ page import="login_logout_process.*"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Search Results</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/inbox.css" type="text/css" media="screen" />
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

		<script src="/TED/scripts/checkTwoPass.js"></script>
		<script src="/TED/scripts/saveDataAndFill.js"></script>

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
%>
		<div id="boxcontent" >

			<h2 style="text-align:center">Μηνύματα</h2>

			<div class="Users">
				<%
				RetrieveUsers chat = new RetrieveUsers();
				List<String> clients = new ArrayList<String>();
				List<String> sellers = new ArrayList<String>();
				%>

				<div class="lft"><h4>Πελάτες</h4></div>

				<%
				clients = chat.RetrieveClients(log.getName());
				for (String elem : clients) {
				%>

					<a class="ppl" href="/TED/messages/newInbox.jsp?user=<%= elem %>"><%= elem %></a>

				<% } %>

				<div class="lft"><h4>Πωλητές</h4></div>

				<%
				sellers = chat.RetrieveSellers(log.getName());
				for (String elem : sellers) {
				%>

					<a class="ppl" href="/TED/messages/newInbox.jsp?user=<%= elem %>"><%= elem %></a>

				<% } %>
			</div>

			<div class="rightbox">
				<div class="Inbox">
					<div class="usr"> <h4><%= request.getParameter("user") %></h4> </div>

					<%
					RetrieveMessages msg = new RetrieveMessages();
					ResultSet inbox = msg.getInbox(log.getName(), request.getParameter("user"));

					while (inbox.next()) {
						if (inbox.getInt("rec_del") == 0) {
							if (inbox.getString("userID").equals(log.getName())) { %>
									<div class="sender">
									<p><a title="Διαγραφή" href="../delmessage?user=<%= request.getParameter("user") %>&del=1&ID=<%= inbox.getInt("msgID") %>"><%= inbox.getString("msgText") %></a></p>
									</div><br>
							<% } else { %>
									<div class="receiver"><p><a title="Διαγραφή" href="../delmessage?user=<%= request.getParameter("user") %>&del=0&ID=<%= inbox.getInt("msgID") %>"><%= inbox.getString("msgText") %></a></p></div><br>
							<% } %>

					<% } } %>
				</div>

				<div class="Reply">
					<form name="message" action="../getmessage" method="post">
						<input class="Answer" type="text" name="message" placeholder="Απάντηση..">
						<input type="hidden" name="recipient" value="<%=request.getParameter("user") %>">
						<input type="hidden" name="username" value="<%=log.getName() %>">
						<input type="submit" value="Αποστολή">
					</form>
				</div>

			</div>

		</div>
<%
	}
	else
	{
%>
		<p style="font-size:22px;">Guest Mode Permission Denied !</p>

<%
	}
%>
		<jsp:include page="../jsp_scripts/footer.jsp"/>

	</body>
</html>