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

//import org.apache.commons.dbcp.DriverManagerConnectionFactory;

import connection.*;





public class LoginSession {


    PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
    String pass = null;
    String type1 = null;

	public LoginSession(String username, String passwd)
	{
		name = new String(username);
	    pass = new String(passwd);
	    System.out.println("*****Start Login Session Constr name = "+name+" pass = "+pass);
	    try
	    {
	        ConnectionDB link = new ConnectionDB();
	        state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT username ,password, ready, type "
	        		+"FROM ted.users "
	        		+"WHERE username = ? "
	        		+"AND password = AES_ENCRYPT(?, SHA2('134711Kk',512))"
	        		);
	        state.setString(1, name);
	        state.setString(2, pass);
	        System.out.println("*****Finish Login Session Constr name = "+name+" pass = "+pass);

	    }
	    catch(SQLException ex)
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
	            if (set.getInt("ready") == 1) 					//0 den einai egkuro kai 1 einai einai OK
	            {
	                x = 1; //success
	                if(set.getString("type").equals("admin"))
                	{
	                	System.out.println("****FIND THIS type = "+set.getString("type"));
	                	x = 4; //4 einai oti o xrhsths pou mphke einai admin eno
	                	type1 = new String("admin");
                	}
	                else type1 = new String("user");
	            }													//1 o xrhsths einai aplos user
	            else if(set.getInt("ready") == 0)
	            {
	            	x = 3; //not ready
	            }
	            else
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

	public String getName()
	{
		return name;
	}

	public String getPass()
	{
		return pass;
	}

	public void changePass(String newpass)
	{
		pass = new String(newpass);
	}

	public String getType()
	{
		return type1;
	}

}
