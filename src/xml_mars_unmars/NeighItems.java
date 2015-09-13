package xml_mars_unmars;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

import connection.ConnectionDB;
import xml_mars_unmars.FriendItems;

public class NeighItems {

	long ItemID;

	LinkedList<String> neigh_username = null;
	LinkedList<Long> items_list = null;
	LinkedList<FriendItems> friend_list = null;

	ConnectionDB link;

	PreparedStatement state = null;
    ResultSet set = null;

	public NeighItems(LinkedList<String> neigh_user)
	{
		neigh_username = neigh_user;
		try
	    {
	        link = new ConnectionDB();
	        items_list = new LinkedList<Long>();

	        for(String username : neigh_username)
	        {
	        	//System.out.println(username+" NeighItems");
	        	state = link.GetState();
		        state = (link.GetCon()).prepareStatement(
		        		"SELECT item_id "+
		        		"FROM ted.user_item u "+
		        	    "WHERE u.live=1 AND u.item_id IN "+
				        		"(SELECT item_id "+
				        		"FROM ted.item_bids "+
				        		"WHERE username=? "+
				        		"ORDER BY date_time DESC "+
				        		")"
		        		);
		        state.setString(1, username);
		        set = state.executeQuery();
		        if(set.next())
		        {
		        	ItemID = set.getLong("item_id");
		        	items_list.add(ItemID);
		        	//System.out.println(ItemID+" NeighItems");
		        }
	        }

	        if(items_list.size() > 0)
        	{
	        	friend_list = new LinkedList<FriendItems>();
		        for(long item_id : items_list)
		        {
		        	//System.out.println("1 "+item_id+" NeighItems");
		        	state = link.GetState();
			        state = (link.GetCon()).prepareStatement(
			        		"SELECT name,currently_price,photo_url "
			        		+ "FROM ted.items "
			        		+"WHERE item_id=?"
			        		);
			        state.setLong(1, item_id);
			        set = state.executeQuery();
			        //System.out.println("2 "+item_id+" NeighItems");

			        while(set.next())
			        {
			        	//System.out.println("3 "+set.getString("name")+" NeighItems");
			        	FriendItems friend = new FriendItems(item_id,set.getString("name"), set.getFloat("currently_price"), set.getString("photo_url"));

			        	if(CheckAdd(friend_list, friend))
			        	{
			        		friend_list.add(friend);
			        	}
			        	//System.out.println("4 "+set.getString("name")+" NeighItems");
			        }
		        }
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


	public boolean CheckAdd(LinkedList<FriendItems> list, FriendItems friend)
	{
		boolean b = true;
		if(list != null)
		{
			for(FriendItems elem: list)
			{
				if(elem.getItemID() == friend.getItemID())
				{
					return false;
				}
			}
		}

		return b;
	}


	public LinkedList<FriendItems> getFriendList()
	{
		return friend_list;
	}

}
