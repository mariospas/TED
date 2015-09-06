package maps;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class GetLocation {
	
	PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
	
	public GetLocation(String username) {
		
		name = new String(username);
		System.out.println("*****Start Login Session Constr name = "+name);
		
		try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT latitude, longitude "
	        		+"FROM users "
	        		+"WHERE username = ?"); 
	        
	        state.setString(1, name);
	        System.out.println("*****Finish Login Session Constr name = "+name);
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		} 	
	}
	
	public double getLatitude(){
		double x = 0;
		
		try {
			set = state.executeQuery();
			System.out.println("latitude ");
			
			set.next();
			x = set.getDouble("latitude");
			System.out.println("ok " +x);
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }
		
		return x;
	}
	
	public double getLongitude(){
		double x = 0;
		
		try {
			set = state.executeQuery();
			System.out.println("longitude");
			
			set.next();
			
			x = set.getDouble("longitude");
			System.out.println("ok " +x);
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }
		
		return x;
	}
}
