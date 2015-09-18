package messages;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import connection.ConnectionDB;

public class RetrieveUsers {
	
	String user = null;
	
	public RetrieveUsers(){ }
	
	//Find the people the user has bought items from
	public List<String> RetrieveSellers(String username) {
		
		PreparedStatement state = null;
        ResultSet set1 = null;
        ResultSet set2 = null;
        ResultSet set3 = null;
        user = new String(username);
        List<Integer> list1 = new ArrayList<>();
        List<String> list2 = new ArrayList<String>();
        
        try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT DISTINCT item_id "
	        		+"FROM item_bids "
	        		+"WHERE username=? "
	        		+"ORDER BY date_time DESC"
	        		); 
	        state.setString(1, user);
	        set1 = state.executeQuery();
	        
	        while(set1.next()){
		        state = (link.GetCon()).prepareStatement(
		        		"SELECT * "
		        		+"FROM item_bids "
		        		+"WHERE item_id=? "
		        		+"ORDER BY date_time DESC "
		        		+"LIMIT 1"
		        		);
		        state.setInt(1, set1.getInt("item_id"));
	            set2 = state.executeQuery();
	            while (set2.next()) {
		            if (set2.getString("username").equals(user)) {
		            	list1.add(set2.getInt("item_id"));
		            }
	            }
	        }
	        
	        for(int elem : list1) {
	        	state = (link.GetCon()).prepareStatement(
		        		"SELECT * "
		        		+"FROM user_item "
		        		+"WHERE item_id=?"
		        		);
	        	state.setInt(1, elem);
	        	set3 = state.executeQuery();
	        	while(set3.next()) {
	        	list2.add(set3.getString("username"));
	        	}
	        }
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
        
        //Remove duplicate names
        Set<String> hs = new HashSet<>();
        hs.addAll(list2);
        list2.clear();
        list2.addAll(hs);
        
        return list2;
        
	}
	
	//Find the people the user has sold items to
	public List<String> RetrieveClients(String username) {
		
		PreparedStatement state = null;
        ResultSet set1 = null;
        ResultSet set2 = null;
        user = new String(username);
        List<String> list1 = new ArrayList<String>();
        
        try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT *"
	        		+"FROM user_item "
	        		+"WHERE username=?"
	        		);
	        state.setString(1, user);
	        set1 = state.executeQuery();
	        
	        while(set1.next()){
		        state = (link.GetCon()).prepareStatement(
		        		"SELECT * "
		        		+"FROM item_bids "
		        		+"WHERE item_id=? "
		        		+"ORDER BY date_time DESC "
		        		+"LIMIT 1"
		        		);
		        state.setInt(1, set1.getInt("item_id"));
	            set2 = state.executeQuery();
	            while (set2.next()) {
	            	list1.add(set2.getString("username"));
	            }
	        }
	        
        } catch (SQLException ex) {
	  		ex.printStackTrace();
		}
        
        //Remove duplicate names
        Set<String> hs = new HashSet<>();
        hs.addAll(list1);
        list1.clear();
        list1.addAll(hs);
        
        return list1;
        
	}
}
