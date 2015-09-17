package search;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import java.sql.ResultSet;

public class Filter_max_count {

	ResultSet set;

	public Filter_max_count(ResultSet set1) {

		set = set1;
	}


	public float[] max_minPrice()
	{
		float[] price = new float[2];
		price[0] = -1;     //max
		price[1] = 100000; //min

		try
		{
			set.beforeFirst();
			while(set.next())
			{
				float min_max = set.getFloat("currently_price");
				if(price[0]<min_max) price[0] = min_max;
				if(price[1]>min_max) price[1] = min_max;
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}

		return price;
	}

	public List<String> countries()
	{
		List<String> country = new LinkedList<String>();

		try
		{
			//System.out.println("lalal");
			set.beforeFirst();
			while(set.next())
			{
				String count = set.getString("country");
				country.add(count);
				System.out.println(count);

			}
			Set<String> set1 = this.findDuplicates(country);
			country = new LinkedList<String>();
			country.addAll(set1);
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}

		return country;
	}


	public  Set<String> findDuplicates(List<String> listContainingDuplicates)
	{

		Set<String> setToReturn = new HashSet<String>();
		Set<String> set1 = new HashSet<String>();

		for (String yourInt : listContainingDuplicates)
		{
			//System.out.println("in loop dubl "+yourInt);
			if (set1.add(yourInt)) {
				//System.out.println("in no dubl "+yourInt);
				setToReturn.add(yourInt);
			}
		}
		return setToReturn;
	}

}
