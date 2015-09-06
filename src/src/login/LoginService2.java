package login;

import java.sql.*;

//import connection.ConnectionDB;

public class LoginService2 {
	String URL = "jdbc:mysql://localhost:3306/ted?useUnicode=yes&characterEncoding=UTF-8";
	String dbuser = "root";
	String dbpass = "134711Kk";
	Connection connection = null;
	
    PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
    String pass = null;
    String type1 = null;
	
	public LoginService2(String username, String passwd) {
		
		name = new String(username);
		pass = new String(passwd);
		System.out.println("*****Start Login Session Constr name = "+name+" pass = "+pass);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			connection = DriverManager.getConnection(URL, dbuser, dbpass);
			
	        state = connection.prepareStatement(
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
		} catch(ClassNotFoundException ex)
	    {
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
