<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="check_uti.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Testing websockets</title>
</head>
<body>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
%>

	  <div>
	    <input id="inputmessage" type="text" />
	  </div>
	  <div>
	    <input type="submit" value="Broadcast message" onclick="send()" />
	  </div>
	  <div id="messages"></div>
	  <script type="text/javascript">
	    var webSocket = new WebSocket('ws://localhost:8080/TED/websocket?user=takis2');


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
	    }

	    function onOpen(event) {
	      /*document.getElementById('messages').innerHTML
	        = 'Connection established';*/
	    }

	    function onError(event) {
	      alert(event.data);
	    }

	    function send() {
	      var txt = '<%=log.getName()%> '+document.getElementById('inputmessage').value+' receive';
	      webSocket.send(txt);
	      return false;
	    }

	  </script>
<%
	}
%>
</body>
</html>