package xml_mars_unmars;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import connection.ConnectionDB;

public class Auctions {

	PreparedStatement state = null;
    ResultSet set = null;
    String name = null;
    ConnectionDB link;

    long ItemID;
    float Bid;


	public Auctions(String username) {

		name = new String(username);
        link = new ConnectionDB();
        state = link.GetState();

	}

	public Auctions(String username,long item_id,float bid) {

		name = new String(username);
		ItemID = item_id;
		Bid = bid;
        link = new ConnectionDB();
        state = link.GetState();

	}

	public Auctions(String username,long item_id) {

		name = new String(username);
		ItemID = item_id;
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

	public int delete_item(long item)
	{
	    try
	    {
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT item_id "
	        		+"FROM ted.user_item "
	        		+"WHERE username = ?"
	        		);
	        state.setString(1, name);
	        set = state.executeQuery();
	        long id = -1;
	        boolean flag = false;    //shmainei pos den uparxei to item auto ston sugkekrimeno user
	        while (set.next())
			{
	        	id = set.getLong("item_id");
	        	if(id == item)
	        	{
	        		flag = true;
	        		break;
	        	}
			}
	        if(flag == false) return 0;
	        else
	        {
	        	state = (link.GetCon()).prepareStatement(
		        		"DELETE FROM ted.items "
		        		+"WHERE item_id = ?"
		        		);
		        state.setLong(1, item);
		        state.executeUpdate();

		        state = (link.GetCon()).prepareStatement(
		        		"DELETE FROM item_category "
		        		+"WHERE item_id = ?"
		        		);
		        state.setLong(1, item);
		        state.executeUpdate();

		        state = (link.GetCon()).prepareStatement(
		        		"DELETE FROM user_item "
		        		+"WHERE item_id = ?"
		        		);
		        state.setLong(1, item);
		        state.executeUpdate();

		        state = (link.GetCon()).prepareStatement(
		        		"DELETE FROM item_bids "
		        		+"WHERE item_id = ?"
		        		);
		        state.setLong(1, item);
		        state.executeUpdate();
	        }

	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

	    return 1;
	}


	public void onlineLiveness(long ItemID)
	{
		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"UPDATE ted.user_item "
	        		+"SET live=1 "
	        		+"WHERE item_id=?"
	        		);
			state.setLong(1, ItemID);
			state.executeUpdate();
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	}


	public int num_of_bids(long item_id)
	{
		int bids = 0;
	    try
	    {
	    	System.out.println("num_of_bids");
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.item_bids "
	        		+"WHERE item_id=?"
	        		);
	        state.setLong(1, item_id);
	        set = state.executeQuery();
	        set.first();

	        bids = set.getRow();
	        System.out.println("num_of_bids "+bids);
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

	    return bids;
	}

	public ResultSet bids(long item_id)
	{
	    try
	    {
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.item_bids "
	        		+"WHERE item_id = ?"
	        		);
	        state.setLong(1, item_id);
	        set = state.executeQuery();
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

	    return set;
	}

	public boolean addBid()
	{
		boolean b = true;
		try
		{
			b = this.updateCurrentPrice();
			if(b)
			{
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-ddHH:mm");
				   //get current date time with Date()
				Date date = new Date();
				String date_str = dateFormat.format(date);
				try {
					date = dateFormat.parse(date_str);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				java.sql.Timestamp stamp = new java.sql.Timestamp(date.getTime());


				state = (link.GetCon()).prepareStatement(
		        		"SELECT * "
						+"FROM ted.bidders "
						+ "WHERE username=?"
		        		);
		        state.setString(1, name);
		        set = state.executeQuery();
		        if(set.next())
		        {

		        }
		        else
		        {
					state = (link.GetCon()).prepareStatement(
			        		"INSERT INTO ted.bidders "
							+"VALUES (?,1)"
			        		);
			        state.setString(1, name);
			        state.executeUpdate();
		        }

		        state = (link.GetCon()).prepareStatement(
		        		"INSERT INTO ted.item_bids "
						+"VALUES (?,?,?,?)"
		        		);
		        state.setLong(1, ItemID);
		        state.setFloat(2, Bid);
		        state.setString(3, name);
		        state.setTimestamp(4, stamp);
		        state.executeUpdate();

			}
		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		return b;
	}


	public boolean updateCurrentPrice()
	{
		boolean flag=true;
		try
		{
			state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
					+"FROM ted.items "
					+ "WHERE item_id=?"
	        		);
	        state.setLong(1, ItemID);
	        ResultSet set1 = state.executeQuery();

	        while(set1.next())
	        {
	        	float price = set1.getFloat("currently_price");
	        	if(price>Bid)
	        	{
	        		return false;
	        	}
	        	else
	        	{
	        		state = (link.GetCon()).prepareStatement(
	    	        		"UPDATE items "+
	        				"SET currently_price=? "+
	        				"WHERE item_id=?"
	    	        		);
	        		state.setFloat(1, Bid);
	    	        state.setLong(2, ItemID);
	    	        state.executeUpdate();
	        	}
	        }
		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return flag;
	}

	public boolean checkBidUser()
	{
		boolean b = false;

		try
		{
			state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
					+"FROM ted.item_bids b,ted.items i "
					+ "WHERE b.username=? AND b.item_id=? AND b.item_id=i.item_id"
	        		);
	        state.setString(1, name);
	        state.setLong(2,ItemID);
	        ResultSet set1 = state.executeQuery();

	        while(set1.next())
	        {
	        	float price = set1.getFloat("price");
	        	float cur_price = set1.getFloat("currently_price");
	        	if(price == cur_price)
	        	{
	        		return true;
	        	}
	        }
		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return b;
	}

}
