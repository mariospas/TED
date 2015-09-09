package check_uti;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class DataCheck {

	ConnectionDB link;

	PreparedStatement state = null;
    ResultSet set = null;

    long ItemID;

	public DataCheck()
	{
		try
	    {
	        link = new ConnectionDB();
	        state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"select i.item_id "+
	        		"from ted.items i, ted.user_item u "+
	        		"where i.item_id = u.item_id and u.live = 1 "+
	        		"and i.start_date < current_timestamp "+
	        		"and i.end_date < current_timestamp"
	        		);
	        set = state.executeQuery();
	        while(set.next())
	        {
	        	ItemID = (set.getLong("item_id"));
	        	state = link.GetState();
		        state = (link.GetCon()).prepareStatement(
			        	"UPDATE user_item "+
			        	"SET live=0 "+
			        	"WHERE item_id=?"
			        	);
		        state.setLong(1, ItemID);
		        state.executeUpdate();
	        }

	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}

}
