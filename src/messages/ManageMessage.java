package messages;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.Random;

import connection.ConnectionDB;

public class ManageMessage {

	PreparedStatement state = null;
    int set = 0;
    String recipient = null;
    String subject = null;
    String message = null;

    public ManageMessage(String rec, String msg, String userID) {

    	recipient = new String(rec);
    	message = new String(msg);
    	System.out.println("ManageMessage constructor");
    	Random rand = new Random();
    	int n = rand.nextInt(10000) + 1;
    	java.sql.Timestamp  start_date_sql;
    	java.util.Date date = new java.util.Date();
    	start_date_sql = new java.sql.Timestamp(date.getTime());

    	try {
			ConnectionDB apply = new ConnectionDB();
			state = apply.GetState();
	        state = (apply.GetCon()).prepareStatement(
	        		"INSERT INTO messages (msgText, recipient, userID, msgID, usr_del, rec_del, msgRead, date_time) "
	        		+"VALUES (?, ?, ?, ?, 0, 0, 0, ?) ");
	        state.setString(1, message);
	        state.setString(2, recipient);
	        state.setString(3, userID);
	        state.setInt(4, n);
	        state.setTimestamp(5, start_date_sql);
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
