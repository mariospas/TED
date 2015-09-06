package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionDB {

	String URL = "jdbc:mysql://localhost:3306/ted?useUnicode=yes&characterEncoding=UTF-8";
    String dbuser = "root";
    String dbpass = "134711Kk";
    Connection connection = null;
    PreparedStatement state = null;
    ResultSet set = null;

	public ConnectionDB()
	{
		try
	    {
	        Class.forName("com.mysql.jdbc.Driver");

	        connection = DriverManager.getConnection(URL, dbuser, dbpass);

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

	public PreparedStatement GetState()
	{
		return state;
	}

	public Connection GetCon()
	{
		return connection;
	}

}