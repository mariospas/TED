package login_logout_process;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.lang.*;
import java.util.*;
import java.net.HttpURLConnection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.dbcp.DriverManagerConnectionFactory;






public class LoginSession {

	String URL = "jdbc:mysql://localhost:3306/ted";
    String dbuser = "root";
    String dbpass = "134711Kk";
    Connection con = null;
    PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
    String pass = null;

	public LoginSession(String username, String passwd)
	{
		name = username;
	    pass = passwd;
	    System.out.println("*****Start Login Session Constr name = "+name+" pass = "+pass);
	    try
	    {
	        Class.forName("com.mysql.jdbc.Driver");

	        con = DriverManager.getConnection(URL, dbuser, dbpass);
	        state = con.prepareStatement(
	        		"SELECT username ,password "
	        		+"FROM ted.users "
	        		+"WHERE username = ? "
	        		+"AND password = ?"
	        		);
	        state.setString(1, name);
	        state.setString(2, pass);
	        System.out.println("*****Finish Login Session Constr name = "+name+" pass = "+pass);

	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	    catch(ClassNotFoundException ex)
	    {
	    	ex.printStackTrace();
	    }
	}


	public int getUser()
	{
		int x = 2;
		try
		{
			System.out.println("try state execute");
			set = state.executeQuery();
			System.out.println("finish try state execute");
	        while (set.next())
	        {
	        	System.out.println("FIND THIS USERNAME = "+set.getString("username"));
	            if (set.getString("username").equals(name) && set.getString("password").equals(pass))
	            {
	                x = 1; //success
	            } else
	            {
	                x = 0; //fail
	            }
	        }


		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return x;

	}

}
