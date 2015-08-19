package import_update_DB;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import connection.ConnectionDB;

public class ImportUpdateDB
{
	PreparedStatement state;
	ConnectionDB connection;

	public ImportUpdateDB()
	{
		try
        {

        	connection = new ConnectionDB();
            state = connection.GetState();

        }
        catch (Exception ex)
        {
        	ex.printStackTrace();
        }

	}

	public void importUser(String username,String password,String firstname,
						   String lastname,String email,String telephone,
						   String address,String tk,String city,String country,String afm)
	{
		try
        {
			System.out.println("***** Start Import " +firstname+ " ******");
			state = (connection.GetCon()).prepareStatement("INSERT INTO ted.users VALUES (?,?,?,?,?,?,?,?,?,?,?,0)");

	        state.setString(1,username);
	        state.setString(2,password);
	        state.setString(3,firstname);
	        state.setString(4,lastname);
	        state.setString(5,email);
	        state.setString(6,telephone);
	        state.setString(7,address);
	        state.setString(8,tk);
	        state.setString(9,city);
	        state.setString(10,country);
	        state.setString(11,afm);
	        System.out.println("***** SKAYTA " +password+ " ******");
	        state.executeUpdate();
	        System.out.println("***** finish Import " +password+ " ******");
        }
		catch (Exception ex)
        {
        	ex.printStackTrace();
        }

	}

}
