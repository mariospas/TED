package check_uti;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class Profile {

	PreparedStatement state = null;
    ResultSet set = null;
    String name = null;

	public Profile(String username)
	{
		name = new String(username);
	    System.out.println("*****Start Profile Session Constr name = "+name);
	    try
	    {
	        ConnectionDB link = new ConnectionDB();
	        state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.users "
	        		+"WHERE username = ? "
	        		);
	        state.setString(1, name);
	        System.out.println("*****Finish Profile Session Constr name = "+name);
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	}

	public ResultSet profile_info()
	{
		try
		{
			set = state.executeQuery();
		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return set;
	}

}
