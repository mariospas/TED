package src.search;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class FindItem {
	
	PreparedStatement state = null;
	ResultSet set = null;
	ResultSet set2 = null;
    String searchquery = null;
    private int noOfRecords;
	
    public FindItem() { }
    
	public ResultSet LikeItem(String item, int offset, int noOfRecords, String country, int minPrice, int maxPrice) {
		
		searchquery = new String(item).replace(" ", "%");
		System.out.println("*****Starting Search Query with input = " +searchquery);
		
		try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT SQL_CALC_FOUND_ROWS * "
	        		+"FROM ted.items AS it, ted.user_item AS usi "
	        		+"WHERE (it.name LIKE ? "
	        		+"OR it.description LIKE ?) "
	        		+"AND it.country LIKE ? "
	        		+"AND it.buy_price>? "
	        		+"AND it.buy_price<? "
	        		+"AND it.item_id=usi.item_id "
	        		+"AND usi.live=1 "
	        		+"LIMIT ? OFFSET ?"); 
	        state.setString(1, "%" + searchquery + "%");
	        state.setString(2, "%" + searchquery + "%");
	        state.setString(3, "%" + country);
	        state.setInt(4, minPrice);
	        state.setInt(5, maxPrice);
	        state.setInt(6, noOfRecords);
	        state.setInt(7, offset);
	        System.out.println("*****Finished Search Query with input = " +searchquery);
	        System.out.println("try state execute");
			set = state.executeQuery();
			state = (link.GetCon()).prepareStatement("SELECT FOUND_ROWS()");
            set2 = state.executeQuery();
            if (set2.next()){
           	 this.noOfRecords = set2.getInt(1);
           	 System.out.println("number of pages PAGING= " +this.noOfRecords);
            }
			System.out.println("finish try state execute");
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
		
		return set;  
	}
	
	public ResultSet LikeItem(String item, int category, int offset, int noOfRecords, String country, int minPrice, int maxPrice) {
        
        int categ = category;
        searchquery = new String(item).replace(" ", "%");
        System.out.println("*****Starting Category Search Query with input = " +searchquery+ " and category " +categ);
        
        try {
            ConnectionDB link = new ConnectionDB();
            state = link.GetState();
            state = (link.GetCon()).prepareStatement(
                    "SELECT SQL_CALC_FOUND_ROWS * "
                    +"FROM ted.items AS it, ted.item_category AS it_c, ted.category AS categ, ted.user_item AS usi "
                    +"WHERE (it.name LIKE ? OR it.description LIKE ?) "
                    +"AND categ.category_id=? "
                    +"AND it.item_id=it_c.item_id "
                    +"AND categ.category_id=it_c.category_id "
                    +"AND it.country LIKE ? "
	        		+"AND it.buy_price>? "
	        		+"AND it.buy_price<? "
	        		+"AND it.item_id=usi.item_id "
	        		+"AND usi.live=1 "
                    +"LIMIT ? OFFSET ?"); 
            state.setString(1, "%" + searchquery + "%");
            state.setString(2, "%" + searchquery + "%");
            state.setInt(3, categ);
            state.setString(4, "%" + country);
	        state.setInt(5, minPrice);
	        state.setInt(6, maxPrice);
            state.setInt(7, noOfRecords);
            state.setInt(8, offset);
            System.out.println("*****Finished Search Query with input = " +searchquery);
            System.out.println("try state execute");
            set = state.executeQuery();
            state = (link.GetCon()).prepareStatement("SELECT FOUND_ROWS()");
            set2 = state.executeQuery();
            if (set2.next()){
             this.noOfRecords = set2.getInt(1);
             System.out.println("number of pages PAGING= " +this.noOfRecords);
            }
            System.out.println("finish try state execute");
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return set;
    }
	
	public ResultSet matchItem(String item, int offset, int noOfRecords) {
		
		searchquery = new String(item).replace(" ", "%");
		System.out.println("*****Starting Match Query with input = " +searchquery);
		
		try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT SQL_CALC_FOUND_ROWS * "
	        		+"FROM ted.items "
	        		+"WHERE MATCH (name) "
	        		+"AGAINST (?) "
	        		+"LIMIT ? OFFSET ?"); 
	        state.setString(1, "%" + searchquery + "%");
	        state.setInt(2, noOfRecords);
	        state.setInt(3, offset);
	        System.out.println("*****Finished Match Query with input = " +searchquery);
	        set = state.executeQuery();
	        state = (link.GetCon()).prepareStatement("SELECT FOUND_ROWS()");
            set2 = state.executeQuery();
            if (set2.next()){
           	 this.noOfRecords = set2.getInt(1);
           	 System.out.println("number of pages PAGING= " +this.noOfRecords);
            }
			System.out.println("finish try state execute");
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		} 
		
		return set;
	}
	
	public ResultSet matchItem(String item, int category, int offset, int noOfRecords) {
		
		int categ = category;
		searchquery = new String(item).replace(" ", "%");
		System.out.println("*****Starting Match Query with input = " +searchquery);
		
		try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT SQL_CALC_FOUND_ROWS * "
	        		+"FROM ted.items AS it, ted.item_category AS it_c, ted.category AS categ "
	        		+"WHERE (MATCH (name) AGAINST (?)) "
	        		+"AND categ.category_id=? "
	        		+"AND it.item_id=it_c.item_id "
	        		+"AND categ.category_id=it_c.category_id "
	        		+"LIMIT ? OFFSET ?"); 
	        state.setString(1, "%" + searchquery + "%");
	        state.setInt(2, categ);
	        state.setInt(3, noOfRecords);
	        state.setInt(4, offset);
	        System.out.println("*****Finished Match Query with input = " +searchquery);
	        set = state.executeQuery();
	        state = (link.GetCon()).prepareStatement("SELECT FOUND_ROWS()");
            set2 = state.executeQuery();
            if (set2.next()){
           	 this.noOfRecords = set2.getInt(1);
           	 System.out.println("number of pages PAGING= " +this.noOfRecords);
            }
			System.out.println("finish try state execute");
		} catch (SQLException ex) {
	  		ex.printStackTrace();
		} 
		
		return set;
	}
	
	public int getNoOfRecords() {
        return noOfRecords;
    }
}
