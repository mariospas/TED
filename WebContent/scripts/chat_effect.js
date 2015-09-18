/**
 *
 */


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
