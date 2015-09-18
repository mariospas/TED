package socket.server;


import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.swing.plaf.SliderUI;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;







@ServerEndpoint("/websocket")
public class WebSocket{


	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	private static HashMap<String, Session> client_map = new HashMap<String, Session>();

	  @OnMessage
	  public void onMessage(String message, Session session) throws IOException
	  {
		  String[] message_array = new String[1];
		  Session receiver_session = null;

		 if(splitMe(message))
		 {
			 System.out.println("///// this is an id "+message);
			 client_map.put(message, session);
		 }
		 else
		 {
			 message_array = split(message);
			 receiver_session = client_map.get(message_array[2]);
		 }
	    synchronized(clients){
	      // Iterate over the connected sessions
	      // and broadcast the received message
	      for(Session client : clients){

	        if (client.equals(receiver_session)){
	          client.getBasicRemote().sendText(message);
	        }
	      }
	    }

	  }

	  @OnOpen
	  public void onOpen (Session session) {
	  // Add session to the connected sessions set
	    clients.add(session);
	    System.out.println(session.getId());
	  }

	  @OnClose
	  public void onClose (Session session) {
	    // Remove session from the connected sessions set
	    clients.remove(session);

	    for(Iterator<String> iter = client_map.keySet().iterator(); iter.hasNext();)
	    {
	    	String key = iter.next();
	    	if(client_map.get(key).equals(session))
	    	{
	    		client_map.remove(key);
	    		break;
	    	}
	    }
	  }


	  public boolean splitMe(String message)
	  {
		boolean b=false;
		String[] parts = new String[1];

		parts = message.split(" ");
		System.out.println("//// "+parts[0]+" ");
		if(parts.length==1) return true;  //sumainei pos einai id kai oxi munhma

		return b;
	  }

	  public String[] split(String message)
	  {
		String[] parts = new String[3]; //o tritos pinakas einai o receiver

		parts = message.split(" ");

		return parts;
	  }


}
