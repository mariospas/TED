package maps;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class GetLocation2 {
	
	PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
	
	public GetLocation2(String username) {
		
		name = new String(username);
		System.out.println("*****Start Login Session Constr name = "+name);
		
		try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT location "
	        		+"FROM users "
	        		+"WHERE username = ?"); 
	        
	        state.setString(1, name);
	        System.out.println("*****Finish Login Session Constr name = "+name);
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		} 	
	}
	
	public double getLatitude(){
		String x = "";
		double d = 0.0;
		
		try {
			set = state.executeQuery();
			System.out.println("latitude ");
			
			set.next();
			x = set.getString("location");
			System.out.println("ok " +x);
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }
		
		String[] result = x.split(";");

	    try {
	        d = Double.valueOf(result[0].trim()).doubleValue();
	        System.out.println("double d = " + d);
	    } catch (NumberFormatException nfe) {
	        System.out.println("NumberFormatException: " + nfe.getMessage());
	    }
		
		return d;
	}
	
	public double getLongitude(){
		String x = "";
		double d = 0.0;
		
		try {
			set = state.executeQuery();
			System.out.println("latitude ");
			
			set.next();
			x = set.getString("location");
			System.out.println("ok " +x);
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }
		
		String[] result = x.split(";");

	    try {
	        d = Double.valueOf(result[1].trim()).doubleValue();
	        System.out.println("double d = " + d);
	    } catch (NumberFormatException nfe) {
	        System.out.println("NumberFormatException: " + nfe.getMessage());
	    }
		
		return d;
	}
}
