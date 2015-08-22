package category;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class Category {


	ConnectionDB link;

	PreparedStatement state = null;
    ResultSet set = null;


	public Category() {

        link = new ConnectionDB();
        state = link.GetState();


	}

	public ResultSet get_categories()
	{
		try
	    {
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.category"
	        		);
	        set = state.executeQuery();
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return set;
	}

	public ResultSet get_categories_id(String category)
	{
		try
	    {
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT category_id "+
	        		"FROM ted.category "+
	        		"WHERE value=?"
	        		);
	        state.setString(1, category);
	        set = state.executeQuery();
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return set;
	}

}
