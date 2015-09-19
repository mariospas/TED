package check_uti;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class Users {

	PreparedStatement state = null;
    ResultSet set = null;
    ResultSet set2 = null;
    String name = null;
    ConnectionDB link;
    private int noOfRecords;

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

	public ResultSet all_users(int offset, int noOfRecords)
	{
		try
		{
			state = (link.GetCon()).prepareStatement(
	        		"SELECT SQL_CALC_FOUND_ROWS username,password,firstname,lastname,ready "
	        		+"FROM ted.users "
	        		+"LIMIT ? OFFSET ?"
	        		);
			state.setInt(1, noOfRecords);
	        state.setInt(2, offset);
			set = state.executeQuery();
			state = (link.GetCon()).prepareStatement("SELECT FOUND_ROWS()");
            set2 = state.executeQuery();
            if (set2.next()){
              	 this.noOfRecords = set2.getInt(1);
              	 System.out.println("number of pages PAGING= " +this.noOfRecords);
            }
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
	
	public int getNoOfRecords() {
        return noOfRecords;
    }

}
