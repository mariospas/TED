package messages;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class RetrieveMessages {
	
/*    
    public RetrieveMessages() {
    	
    	try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM messages "
	        		+"WHERE userID = 'mariospassaris' "
	        		+"OR recipient = 'mariospassaris'"
	        		); 
	        System.out.println("*****Finish Login Session Constr ");
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
    	
    }
*/   
    public ResultSet getInbox() {
    	
    	PreparedStatement state = null;
        ResultSet inboxset = null;
        
    	try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM messages "
	        		+"WHERE recipient = 'takis2'"
	        		); 
	        System.out.println("*****Inbox messages delivered ");
	        inboxset = state.executeQuery();
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
    	
    	return inboxset;
    }
    
    public ResultSet getSent() {
    	
    	PreparedStatement state = null;
        ResultSet sentset = null;
        
    	try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM messages "
	        		+"WHERE userID = 'mariospassaris'"
	        		); 
	        System.out.println("*****Sent messages delivered ");
	        sentset = state.executeQuery();
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
    	
    	return sentset;
    }
    
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
   
}
