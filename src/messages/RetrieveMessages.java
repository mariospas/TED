package messages;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class RetrieveMessages {
	
	String recipient = null;
	String sender = null;
	
    public ResultSet getInbox(String rec, String sen) {
    	
    	PreparedStatement state = null;
        ResultSet inboxset = null;
        recipient = new String(rec);
        sender = new String(sen);
        
    	try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM messages m1 "
	        		+"WHERE m1.userID=? AND m1.recipient=? "
	        		+"UNION "
	        		+"SELECT * "
	        		+"FROM messages m2 "
	        		+"WHERE m2.userID=? AND m2.recipient=? "
	        		+"ORDER BY date_time ASC"
	        		); 
	        state.setString(1, sender);
	        state.setString(2, recipient);
	        state.setString(3, recipient);
	        state.setString(4, sender);
	        System.out.println("*****Inbox messages delivered ");
	        inboxset = state.executeQuery();
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
    	
    	return inboxset;
    }
    
    /*
    public ResultSet getSent(String username) {
    	
    	PreparedStatement state = null;
        ResultSet sentset = null;
        user = new String(username);
        
    	try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM messages "
	        		+"WHERE userID =?"
	        		); 
	        System.out.println("*****Sent messages delivered ");
	        state.setString(1, user);
	        sentset = state.executeQuery();
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
    	
    	return sentset;
    }
    */
    
    public void delSent(int ID) {
    	
    	PreparedStatement state = null;
    	int msgID = ID;
        
    	try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"UPDATE messages "
	        		+"SET usr_del=1 "
	        		+"WHERE msgID=?"
	        		);
	        state.setInt(1, msgID);
	        System.out.println("*****Deleting sent message");
	        state.executeUpdate();
	        System.out.println("*****Sent message deleted");
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
    	
    }
    
    public void delReceived(int ID) {
    	
    	PreparedStatement state = null;
    	int msgID = ID;
        
    	try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"UPDATE messages "
	        		+"SET rec_del=1 "
	        		+"WHERE msgID=?"
	        		); 
	        state.setInt(1, msgID);
	        System.out.println("*****Deleting received message");
	        state.executeUpdate();
	        System.out.println("*****Received message deleted");
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
    }
    
    public ResultSet getMessage(int ID) {
    	
    	PreparedStatement state = null;
        ResultSet msg = null;
        int msgID = ID;
        
    	try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM messages "
	        		+"WHERE msgID =?"
	        		); 
	        state.setInt(1, msgID);
	        msg = state.executeQuery();
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
    	
    	return msg;
    }
    
    public boolean isRead(int ID) {
    	
    	PreparedStatement state = null;
    	int set = 0;
    	int msgID = ID;
    	
    	try {
    		ConnectionDB apply = new ConnectionDB();
			state = apply.GetState();
	        state = (apply.GetCon()).prepareStatement(
	        		"UPDATE messages "
	        		+"SET msgRead=1 "
	        		+"WHERE msgID=?"
	        		);
	        state.setInt(1, msgID);
			set = state.executeUpdate();
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }
    	
    	if (set == 1)
    		return true;    		
    	else
    		return false;

    }
   
}


