package search;

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
    
	public ResultSet LikeItem(String item, int offset, int noOfRecords) {
		
		searchquery = new String(item).replace(" ", "%");
		System.out.println("*****Starting Search Query with input = " +searchquery);
		
		try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT SQL_CALC_FOUND_ROWS * "
	        		+"FROM ted.items "
	        		+"WHERE name LIKE ? "
	        		+"OR description LIKE ? "
	        		+"LIMIT ? OFFSET ?"); 
	        state.setString(1, "%" + searchquery + "%");
	        state.setString(2, "%" + searchquery + "%");
	        state.setInt(3, noOfRecords);
	        state.setInt(4, offset);
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
	
	public ResultSet LikeItem(String item, int category, int offset, int noOfRecords) {
        
        int categ = category;
        searchquery = new String(item).replace(" ", "%");
        System.out.println("*****Starting Category Search Query with input = " +searchquery+ " and category " +categ);
        
        try {
            ConnectionDB link = new ConnectionDB();
            state = link.GetState();
            state = (link.GetCon()).prepareStatement(
                    "SELECT SQL_CALC_FOUND_ROWS * "
                    +"FROM ted.items AS it, ted.item_category AS it_c, ted.category AS categ "
                    +"WHERE (it.name LIKE ? OR it.description LIKE ?) "
                    +"AND categ.category_id=? "
                    +"AND it.item_id=it_c.item_id "
                    +"AND categ.category_id=it_c.category_id "
                    +"LIMIT ? OFFSET ?"); 
            state.setString(1, "%" + searchquery + "%");
            state.setString(2, "%" + searchquery + "%");
            state.setInt(3, categ);
            state.setInt(4, noOfRecords);
            state.setInt(5, offset);
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
