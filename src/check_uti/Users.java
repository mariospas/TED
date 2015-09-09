package check_uti;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class Users {

	PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
    ConnectionDB link;

	public Users() {
		try
	    {
	        link = new ConnectionDB();
	        state = link.GetState();
	    }
	    catch(Exception ex)
	    {
	    	ex.printStackTrace();
	    }
	}

	public ResultSet all_users()
	{
		try
		{
			state = (link.GetCon()).prepareStatement(
	        		"SELECT username,password,firstname,lastname,ready "
	        		+"FROM ted.users "
	        		);
			set = state.executeQuery();
		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return set;
	}

	public void confirmation(String username)
	{
		try
		{
			state = (link.GetCon()).prepareStatement(
					"UPDATE ted.users SET ready=1 WHERE username=?");
			state.setString(1,username);
			state.executeUpdate();
		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

	}

}
