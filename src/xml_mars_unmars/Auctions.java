package xml_mars_unmars;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class Auctions {

	PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
    ConnectionDB link;


	public Auctions(String username) {

		name = new String(username);
        link = new ConnectionDB();
        state = link.GetState();

	}

	public ResultSet online_auctions()
	{
		long item = -1;
	    try
	    {
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT item_id "
	        		+"FROM ted.user_item "
	        		+"WHERE username = ? "
	        		+"AND live = 1"
	        		);
	        state.setString(1, name);
	        set = state.executeQuery();
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

	    return set;
	}

	public ResultSet offline_auctions()
	{
	    try
	    {
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT item_id "
	        		+"FROM ted.user_item "
	        		+"WHERE username = ? "
	        		+"AND live = 0"
	        		);
	        state.setString(1, name);
	        set = state.executeQuery();

	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

	    return set;
	}


	public ResultSet requested_item(long item)
	{
	    try
	    {
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.items "
	        		+"WHERE item_id = ?"
	        		);
	        state.setLong(1, item);
	        set = state.executeQuery();

	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

	    return set;
	}


}
