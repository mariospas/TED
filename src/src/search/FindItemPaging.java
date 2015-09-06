package search;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class FindItemPaging {
	
	PreparedStatement state = null;
	ResultSet set = null;
	ResultSet set2 = null;
    String searchquery = null;
    private int noOfRecords;
    
    public FindItemPaging() { }
    
    public ResultSet Items(int offset, int noOfRecords) {
    	
    	 /*String query = "select SQL_CALC_FOUND_ROWS * from ted.items limit "
                 + offset + ", " + noOfRecords;*/
    	 
    	 System.out.println("ok so far");
    	 
    	 try {
    		 ConnectionDB connection = new ConnectionDB();
    		 state = connection.GetState();
    		 state = (connection.GetCon()).prepareStatement(
    				 "SELECT SQL_CALC_FOUND_ROWS * "
    			      +"FROM ted.items "
    			      +"Limit ? Offset ?"
    			      );
    		 state.setInt(1, noOfRecords);
    		 state.setInt(2, offset);
             set = state.executeQuery();
             state = (connection.GetCon()).prepareStatement("SELECT FOUND_ROWS()");
             set2 = state.executeQuery();
             System.out.println("ok so far 2");
             if (set2.next()){
            	 this.noOfRecords = set2.getInt(1);
            	 System.out.println("number of pages PAGING= " +this.noOfRecords);
             }
             //set = state.executeQuery();
    	 } catch (SQLException ex) {
 	  		ex.printStackTrace();
 		 } /*finally {
             try {
                 if(state != null)
                     state.close();
                 } catch (SQLException e) {
                 e.printStackTrace();
             }
         }*/
    	 
    	 return set;
    }
    
    public int getNoOfRecords() {
        return noOfRecords;
    }
}