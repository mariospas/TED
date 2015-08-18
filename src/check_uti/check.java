package check_uti;


import java.sql.*;

import connection.*;
import java.lang.*;

public class check
{
	PreparedStatement state;
	String name;

    public check(String uname)
    {

        try
        {

        	System.out.println("***** Start Check " +uname+ " ******");
        	name = new String(uname);
        	System.out.println("***** Start Check "+name+" ******");
        	ConnectionDB connection = new ConnectionDB();
            state = connection.GetState();
            state = (connection.GetCon()).prepareStatement("SELECT username FROM ted.users WHERE username=?");
            state.setString(1,uname);
            System.out.println("***** Finish Check ******");

        }
        catch (Exception ex)
        {
        	ex.printStackTrace();
        }

}




    public int getAvailability()
	{
    	int x = 2;
		try
		{
			ResultSet set = state.executeQuery();
			if (!set.next()) x = 1;
            else x = 0;
		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		 return x;
	}
}