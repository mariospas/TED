<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="check_uti.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*" %>
<%@page import="java.sql.ResultSet"%>
	<footer>
            <h2 class="hidden">footer</h2>
            <section id="copyright">
                <h3 class="hidden">Copyright notice</h3>
                <div class="wrapper">
                <div class="social">
	                <a href="https://plus.google.com/"><img src="/TED/appearance/images/logo/GooglePlus-Logo-Official.png" alt="google plus" width="25"/></a>
	                <a href="https://www.facebook.com/"><img src="/TED/appearance/images/logo/fb_icon_325x325.png" alt="facebook" width="25"/></a>
	                <a href="https://www.youtube.com/"><img src="/TED/appearance/images/logo/youtube_logo_detail.png" alt="youtube" width="25"/></a>
	                <a href="https://www.linkedin.com/"><img src="/TED/appearance/images/logo/LinkedIn_logo_initials.png" alt="linkedin" width="25"/></a>
                </div>
                &copy; Copyright 2015 by Hyper Mario & Ign . All Rights Reserved.</div>
            </section>
            <section class="wrapper">
                <h3 class="hidden">Footer content</h3>
                <article class="column">
                    <h4>Λίγα λόγια για Εμάς</h4>
                    Αυτό το site είναι project του μαθήματος Τεχνολογίες Εφαρμογών Διαδικτίου του τμήματος Πληροφορικής και Τηλεπικοινωνιών του Πανεπιστημίου Αθηνών
                </article>
                <article class="column midlist">
                <h4>Επικοινωνία</h4>
                    <ul>
                        <li><a href="https://goo.gl/Q0omeU">Που βρισκόμαστε</a></li>
                        <li><a href="javascript:void(0)">Τηλ : 2109999999</a></li>
                        <li><a href="javascript:void(0)">Email : demo@di.uoa.gr</a></li>
                    </ul>
                </article>
                <article class="column rightlist">
                    <h4>SiteMap</h4>
                    <ul>
                        <li><a href="/TED/after_login/general_homepage.jsp">Αρχική Σελίδα</a></li>
                        <li><a href="/TED/categories.jsp">Κατηγορίες</a></li>
                        <li><a href="javascript:void(0)">Γενικά</a></li>
                    </ul>
                </article>
            </section>
        </footer>

        <%
        LoginSession log = (LoginSession) session.getAttribute("log");
		if(log != null)
		{
        %>

        		<script type="text/javascript">
					    var webSocket = new WebSocket('wss://snf-674750.vm.okeanos.grnet.gr:8443/TED/websocket?user=takis2'); //topika localhost:8080


					    webSocket.onerror = function(event) {
					      onError(event)
					    };

					    webSocket.onopen = function(event) {
					      webSocket.send("<%=log.getName()%>");
					      onOpen(event)
					    };

					    webSocket.onmessage = function(event) {
					      onMessage(event)
					    };

					    function onMessage(event) {
					    	document.getElementById('messages').innerHTML
					        = '<a style=\"color:red;\" href=\"/TED/messages/newInbox.jsp?user=\">ΜΥΝΗΜΑΤΑ</a>';

					        var res = (event.data).split(" ");
					        document.getElementById('receiver').innerHTML
					    	+= '<p><a title=\"Διαγραφή\" href=\"\">'+res[1]+'</a></p>';
					    }

					    function onOpen(event) {
					      /*document.getElementById('messages').innerHTML
					        = 'Connection established';*/
					    }

					    function onError(event) {
					      alert(event.data);
					    }

					    function send() {
					      var txt = '<%=log.getName()%> '+document.getElementById('inputmessage').value+' <%=request.getParameter("user")%>';
					      webSocket.send(txt);
					      return false;
					    }

				  </script>
<%
			}
%>