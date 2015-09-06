package login;

import java.sql.*;

import connection.ConnectionDB;

public class LoginService {
	
    PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
    String pass = null;
    String type1 = null;
	
	public LoginService(String username, String passwd) {
		
		name = new String(username);
		pass = new String(passwd);
		System.out.println("*****Start Login Session Constr name = "+name+" pass = "+pass);
		
		try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT username, password "
	        		+"FROM users "
	        		+"WHERE username = ? "
	        		+"AND password = ?"
	        		); 
	        state.setString(1, name);
	        state.setString(2, pass);
	        System.out.println("*****Finish Login Session Constr name = "+name+" pass = "+pass);
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		} 	
	}
	
	public boolean authenticate(String passwd) {
			
			if (passwd == null || passwd.trim() == ""){
				return false;
			}
			
			return true;
	}
	
	public int getUser() {
		
		int x = 2;
		try {
			System.out.println("try state execute");
			set = state.executeQuery();
			System.out.println("finish try state execute");
			
			while (set.next()) {
				if (set.getString("username").equals(name)
		            && set.getString("password").equals(pass)) {
					
					x = 1;
					
				} else {
	                x = 0;
	            }
					
			}
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }
		
		return x;
	}
}
