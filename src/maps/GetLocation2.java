package maps;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.ConnectionDB;

public class GetLocation2 {

	PreparedStatement state = null;
    ResultSet set = null;
    long Item;

	public GetLocation2(long item_id) {

		Item = item_id;

		try {
			ConnectionDB link = new ConnectionDB();
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT location "
	        		+"FROM items "
	        		+"WHERE item_id = ?");

	        state.setLong(1, Item);

		} catch (SQLException ex) {
	  		ex.printStackTrace();
		}
	}

	public double getLatitude(){
		String x = "";
		double d = 0.0;

		try {
			set = state.executeQuery();
			System.out.println("latitude ");

			set.next();
			x = set.getString("location");
			System.out.println("ok " +x);
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }

		String[] result = new String[1];
		result = x.split(";");
		if(result.length == 1)
		{
			System.out.println(result.length);
			result = new String[2];
			result[0] = "15.698";
			result[1] = "18.256";
		}

	    try {
	        d = Double.valueOf(result[0].trim()).doubleValue();
	        System.out.println("double d = " + d);
	    } catch (NumberFormatException nfe) {
	        System.out.println("NumberFormatException: " + nfe.getMessage());
	    }

		return d;
	}

	public double getLongitude(){
		String x = "";
		double d = 0.0;

		try {
			set = state.executeQuery();
			System.out.println("Longitude ");

			set.next();
			x = set.getString("location");
			System.out.println("ok " +x);
		} catch(SQLException ex) {
	    	ex.printStackTrace();
	    }

		String[] result = new String[1];
		result = x.split(";");
		if(result.length == 1)
		{
			result = new String[2];
			result[0] = "15.698";
			result[1] = "18.256";
		}

	    try {
	        d = Double.valueOf(result[1].trim()).doubleValue();
	        System.out.println("double d = " + d);
	    } catch (NumberFormatException nfe) {
	        System.out.println("NumberFormatException: " + nfe.getMessage());
	    }

		return d;
	}
}
