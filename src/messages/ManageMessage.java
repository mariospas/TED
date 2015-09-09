package messages;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import connection.ConnectionDB;

public class ManageMessage {
	
	PreparedStatement state = null;
    int set = 0;
    String recipient = null;
    String subject = null;
    String message = null;
    
    public ManageMessage(String rec, String sub, String msg) {
    	
    	recipient = new String(rec);
    	subject = new String(sub);
    	message = new String(msg);
    	System.out.println("ManageMessage constructor");
    	
    	try {
			ConnectionDB apply = new ConnectionDB();
			state = apply.GetState();
	        state = (apply.GetCon()).prepareStatement(
	        		"INSERT INTO messages (subject, msgText, recipient, userID, msgID, usr_del, rec_del) "
	        		+"VALUES (?, ?, ?, 'mariospassaris', 456, 0, 0) "); 
	        state.setString(1, subject);
	        state.setString(2, message);
	        state.setString(3, recipient);
	        System.out.println("*****Finish Login Session Constr subject = "+subject+" recipient = "+recipient);
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		} 	
	}
    
    public boolean deliver() {
    	
    	try {
			System.out.println("executing deliver");
			set = state.executeUpdate();
			System.out.println("message delivered = " +set);
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }
    	
    	if (set == 1)
    		return true;    		
    	else
    		return false;

    }
    	
}
