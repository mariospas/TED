package xml_mars_unmars;
import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.nio.charset.Charset;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.servlet.*;
import javax.servlet.http.HttpServlet;

import org.apache.commons.io.FileUtils;

import sun.nio.cs.StandardCharsets;
import connection.ConnectionDB;
import category.*;

/**
 * JAXB example to generate xml document from Java object also called xml marshaling
 * from Java object or xml binding in Java.
 *
 * @author  Javin Paul
 */


class UserScore implements Comparator<UserScore>
{
	String username = null;
	double score = 0.0;

	public UserScore(String user,double scor)
	{
		username = new String(user);
		score = scor;
	}

	public UserScore()
	{	}

	public String getName() { return username; }
	public double getScore() { return score; }

	public String printUserScore()
	{
		return "username = "+username+" score = "+score;
	}

	@Override
	public int compare(UserScore o1, UserScore o2) {
		System.out.println(o1.username+" "+o1.score+"      "+o2.username+" "+o2.score);
        if(o1.score < o2.score) return -1;
        else if(o1.score > o2.score) return 1;
        return 0;
	}


}




@SuppressWarnings("serial")
public class Item extends HttpServlet{

	long ItemID;
	String Name = null;
	ArrayList<String> Category;
	float Currently;
	float Buy_Price;
	float First_Bid;
	int Number_of_Bids;  // upologizo otan thelo apo sunarthsh
	//Bids/Bid/Bidder  UserID Rating Location Country
	//Bids/Bid/Time
	//Bids/Bid/Amount
	String Location = null;
	String Country = null;
	java.sql.Timestamp Started;
	java.sql.Timestamp Ends;
	//String Started = null;
	//String Ends = null;
	String Seller_UserID = null;
	String Description = null;
	String Photo_Url = null;
	String download_url = null;
	LinkedList<String> list = null;

	ConnectionDB link;

	PreparedStatement state = null;
    ResultSet set = null;

	public Item(String name,ArrayList<String> category,float currently,float buy_price,
				float first_bid,String location,String country,String photo_url,
				java.sql.Timestamp started,java.sql.Timestamp ends,String seller_userid,String description)
	{
		//ItemID;
		Name = new String(name);
		Category = new ArrayList<String>(category);
		Currently = currently;
		Buy_Price = buy_price;
		First_Bid = first_bid;
		Location = new String(location);
		Country = new String(country);
		Started = started;
		Ends = ends;
		Seller_UserID = new String(seller_userid);
		Description = new String(description);
		if(photo_url == null) Photo_Url = null;
		else Photo_Url = new String(photo_url);

		System.out.println(Started + "  " + Ends);
	    try
	    {
	        link = new ConnectionDB();
	        state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.items "+
	        		"ORDER BY item_id DESC "+
	        		"LIMIT 1"
	        		);
	        set = state.executeQuery();
	        if(set.next())
	        {
	        	ItemID = (set.getInt("item_id"));
	        	ItemID++;
	        }
	        else ItemID = 1;
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	}


	public Item(long item_id,String name,ArrayList<String> category,float currently,
			float buy_price,float first_bid,String location,String country,String photo_url,
			java.sql.Timestamp started,java.sql.Timestamp ends,String seller_userid,String description)
	{
		ItemID = item_id;
		Name = new String(name);
		Category = new ArrayList<String>(category);
		Currently = currently;
		Buy_Price = buy_price;
		First_Bid = first_bid;
		Location = new String(location);
		Country = new String(country);
		Started = started;
		Ends = ends;
		Seller_UserID = new String(seller_userid);
		Description = new String(description);
		if(photo_url == null) Photo_Url = null;
		else Photo_Url = new String(photo_url);

		link = new ConnectionDB();
	}

	//constr for xml
	public Item(String current,String ted ) throws IOException
	{

		long itemid=0;
		String name = null;
		ArrayList<String> category;
		float currently;
		float buy_price;
		float first_bid;
		int num_of_bids;
		String location = null;
		String country = null;
		String started = null;
		String ends = null;
		Seller seller_userid;
		String description = null;
		String photo_url = null;
		List<Bid> bid;
		List<ItemXML> items = new ArrayList<ItemXML>();
		link = new ConnectionDB();

		try
		{
			System.out.println("~~ 1 ~~");
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"select * "
					+"from ted.items i, ted.user_item u "
					+"where i.item_id=u.item_id and u.live=1"
	        		);
			set = state.executeQuery();
			//if (state != null) try { state.close(); } catch (SQLException logOrIgnore) {}

			while(set.next())
			{
				System.out.println("~~ 2 ~~");

				itemid = set.getLong("item_id");
				name = set.getString("name");
				category = this.findCategories(itemid);
				currently = set.getFloat("currently_price");
				buy_price = set.getFloat("buy_price");
				first_bid = set.getFloat("first_bid");

				System.out.println("~~ 3 ~~");
				state = (link.GetCon()).prepareStatement(
		        		"SELECT * "
		        		+"FROM ted.item_bids "
		        		+"WHERE item_id=?"
		        		);
		        state.setLong(1, itemid);
		        ResultSet set_row = state.executeQuery();
		        set_row.first();
		        num_of_bids = set_row.getRow();
		        System.out.println("~~ 4 ~~");

				location = set.getString("location");
				country = set.getString("country");

				java.sql.Timestamp stamp = set.getTimestamp("start_date");
				Date date = stamp;
				started = date.toString();

				stamp = set.getTimestamp("end_date");
				date = stamp;
				ends = date.toString();

				System.out.println("~~ 5 ~~");
				if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

				state = (link.GetCon()).prepareStatement(
		        		"SELECT * "
		        		+"FROM ted.user_item "
		        		+"WHERE item_id=?"
		        		);
		        state.setLong(1, itemid);
		        ResultSet set_usr = state.executeQuery();
		        set_usr.first();
				seller_userid = this.createSeller(itemid);
				System.out.println("~~ 6 ~~");

				description = set.getString("description");
				photo_url = set.getString("photo_url");
				System.out.println("~~ 7 ~~");
				bid = this.create_bids(itemid);
				System.out.println("~~ 8 ~~");

				ItemXML itemxml = new ItemXML(name, category, currently, buy_price, first_bid, num_of_bids, location, country, photo_url, started, ends, seller_userid, description, bid, itemid);
				System.out.println("~~ 9 ~~");
				items.add(itemxml);
				System.out.println("~~ 10 ~~");

		        //if (set_usr != null) try { set_usr.close(); } catch (SQLException logOrIgnore) {}
		        //if (set_row != null) try { set_row.close(); } catch (SQLException logOrIgnore) {}
		        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
		        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
			}
			if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

	        //Creating items object for marshaling into XML document
			ItemsXML itemsXML = new ItemsXML(items);
			System.out.println("~~ 11 ~~");

	        JAXBContext jaxbCtx = null;
	        StringWriter xmlWriter = null;
	        try {
	            //XML Binding code using JAXB

	            jaxbCtx = JAXBContext.newInstance(ItemsXML.class);
	            xmlWriter = new StringWriter();
	            jaxbCtx.createMarshaller().marshal(itemsXML, xmlWriter);
	            //System.out.println("XML Marshal example in Java");
	            //System.out.println(xmlWriter);
	            System.out.println("~~ 12 ~~");



	            System.out.println("~~ current ~~");
		        File dir = new File(current+"xml_files");
		        dir.mkdir();
		        current += "xml_files"+File.separator;
		        String url = new String("xml_files"+File.separator);
			    File targetFile = new File(current+"xml_all_files.xml");
			    System.out.println("~~ 13 ~~");

			    download_url = new String(ted+File.separator+url+"xml_all_files.xml");
	            FileUtils.writeStringToFile(targetFile, xmlWriter.toString());
	            System.out.println("~~ 14 ~~");
	        }
	        catch (JAXBException ex) {
	            Logger.getLogger(Item.class.getName()).log(Level.SEVERE,
	                                                                          null, ex);
	        }
		}
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

    }

	public Item(String xml) throws IOException
	{

			JAXBContext jaxbCtx = null;
			link = new ConnectionDB();

			try
			{
				jaxbCtx = JAXBContext.newInstance(ItemsXML.class);
				File targetFile = new File(xml);
			    System.out.println("~~ 13 222 ~~");



		        ItemsXML b = (ItemsXML) jaxbCtx.createUnmarshaller().unmarshal(
		                                           new StringReader(FileUtils.readFileToString(targetFile)));


		        List<ItemXML> Items = b.getItemsXML();
		        for(ItemXML itemElem : Items)
		        {
		        	System.out.println("Item ID = "+itemElem.getItemID());
		        	ItemID = itemElem.getItemID();
					Name = itemElem.getName();
					String string = itemElem.getCurrently();
					if(string != null) Currently = Float.parseFloat(string.substring(1));
					string = itemElem.getBuy_Price();
					if(string != null) Buy_Price = Float.parseFloat(string.substring(1));
					string = itemElem.getFirst_Bid();
					if(string != null) First_Bid = Float.parseFloat(string.substring(1));
					Location = itemElem.getLocation();
					Country = itemElem.getCountry();
					Started = this.splitterDateTime(itemElem.getStartedDate());
					Ends = this.splitterENDDateTime(itemElem.getEndsDate());
					Description = itemElem.getDescription();
					Photo_Url = itemElem.getPhoto_Url();
					Category = itemElem.getCategory();
					Bids bids = itemElem.getBids();
					Seller seller = itemElem.getSeller_UserID();

					this.importNewCategories();

					this.importItem();
					this.updateCategories();
					//this.importLiveness(1);

					this.importNewBids(bids);
					this.importNewSeller(seller);
		        }
			}
	        catch (JAXBException ex)
	        {
	            Logger.getLogger(Item.class.getName()).log(Level.SEVERE,
	                                                                          null, ex);
	        }


	}


	public Item(String username,int num)
	{

		LinkedHashMap<String, LinkedHashMap<String, Integer>> all_user_cat = new LinkedHashMap<String,LinkedHashMap<String, Integer>>();
		Category cat = new Category();


		link = new ConnectionDB();
		String user = null;
		String category = null;
		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"SELECT username "
	        		+ "FROM ted.users"
	        		);
			set = state.executeQuery();

			while(set.next())    //gia olous tous xrhstes
			{
				LinkedHashMap<String, Integer> catPerUser = new LinkedHashMap<String,Integer>();
				boolean flag = false; //gia to an exei kanei bid h oxi
				ResultSet set_cat = cat.get_categories();
				while(set_cat.next())
				{
					category = set_cat.getString("value");
					catPerUser.put(category, 0);
				}

				user = set.getString("username");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"SELECT item_id "
		        		+ "FROM ted.item_bids "
		        		+ "WHERE username=?"
		        		);
				state.setString(1, user);
				ResultSet set1 = state.executeQuery();

				while(set1.next())    //gia ola ta item pou exei kanei bid o idios xthsths
				{
					flag = true;
					long item_id = set1.getLong("item_id");
					state = link.GetState();
					state = (link.GetCon()).prepareStatement(
			        		"SELECT cat.value "
			        		+ "FROM ted.item_category ic, ted.category cat "
			        		+ "WHERE ic.item_id=? AND ic.category_id=cat.category_id"
			        		);
					state.setLong(1, item_id);
					ResultSet set2 = state.executeQuery();

					while(set2.next())   //gia kathe kathgoria tou item
					{
						String cat_value = set2.getString("value");
						//int count = catPerUser.get(cat_value);
						//count++;
						catPerUser.put(cat_value, catPerUser.get(cat_value) + 1);
						//System.out.println("user = "+user+" bids this item = "+item_id+" in this category = "+cat_value+" with value = "+catPerUser.get(cat_value));

					}
				}
				if(user.equals(username)) System.out.println("******* user = "+user+" *******");
				if(flag) all_user_cat.put(user, catPerUser);
			}

			list = this.findTopKNeigh(username, num, all_user_cat);
			if(list != null)
			{
				for(String user_score : list)
				{
					System.out.println(user_score);
				}
			}

	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}


	public String getDownloadLink()
	{
		return download_url;
	}

	public void importItem()
	{
		try
	    {

			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.items "+
	        		"WHERE item_id=?"
	        		);
	        state.setLong(1, ItemID);
	        ResultSet set1 = state.executeQuery();
	        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

	        if(set1.next())
	        {
	        	return;
	        }
	        else
	        {
	        	if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

				System.out.println("import Item "+ItemID);
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"INSERT INTO ted.items "
		        		+"VALUES (?,?,?,?,?,?,?,?,?,?,?)"
		        		);
				state.setLong(1, ItemID);
				state.setString(2, Name);
				state.setFloat(3, Currently);
				state.setFloat(4, Buy_Price);
				state.setFloat(5, First_Bid);
				state.setString(6, Location);
				state.setString(7, Country);
				state.setTimestamp(8, Started);
				state.setTimestamp(9, Ends);
				state.setString(10, Description);
				state.setString(11, Photo_Url);

				state.executeUpdate();
				if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        //if(set1 != null) try { set1.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
		System.out.println("out import Item "+ItemID);
	}


	public void updateItem()
	{
		try
	    {
			if(Photo_Url != null)
			{
				//System.out.println("if");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"UPDATE ted.items "
		        	   +"SET name=?,currently_price=?,buy_price=?,first_bid=?,location=?,"
		        	   +"country=?,start_date=?,end_date=?,description=?,photo_url=? "
					   +"WHERE item_id=?"
		        		);

				state.setString(1, Name);
				state.setFloat(2, Currently);
				state.setFloat(3, Buy_Price);
				state.setFloat(4, First_Bid);
				state.setString(5, Location);
				state.setString(6, Country);
				state.setTimestamp(7, Started);
				state.setTimestamp(8, Ends);
				state.setString(9, Description);
				state.setString(10, Photo_Url);
				state.setLong(11, ItemID);

				state.executeUpdate();
			}
			else
			{
				//System.out.println("else 0 "+Name+" "+Currently+" "+Buy_Price+" "+First_Bid+" "+Location+" "+Country+" "+Started+" "+Ends+" "+Description+" "+ItemID);
				state = link.GetState();
				//System.out.println("else 1 "+Name+" "+Currently+" "+Buy_Price+" "+First_Bid+" "+Location+" "+Country+" "+Started+" "+Ends+" "+Description+" "+ItemID);
				state = (link.GetCon()).prepareStatement(
		        		"UPDATE ted.items "
		        	   +"SET name=?,currently_price=?,buy_price=?,first_bid=?,location=?,"
		        	   +"country=?,start_date=?,end_date=?,description=? "
					   +"WHERE item_id=?"
		        		);
				//System.out.println("else 2 "+Name+" "+Currently+" "+Buy_Price+" "+First_Bid+" "+Location+" "+Country+" "+Started+" "+Ends+" "+Description+" "+ItemID);

				state.setString(1, Name);
				state.setFloat(2, Currently);
				state.setFloat(3, Buy_Price);
				state.setFloat(4, First_Bid);
				state.setString(5, Location);
				state.setString(6, Country);
				state.setTimestamp(7, Started);
				state.setTimestamp(8, Ends);
				state.setString(9, Description);
				state.setLong(10, ItemID);

				//System.out.println("else 3 "+Name+" "+Currently+" "+Buy_Price+" "+First_Bid+" "+Location+" "+Country+" "+Started+" "+Ends+" "+Description+" "+ItemID);

				state.executeUpdate();
				//System.out.println("else 4 "+Name+" "+Currently+" "+Buy_Price+" "+First_Bid+" "+Location+" "+Country+" "+Started+" "+Ends+" "+Description+" "+ItemID);

			}
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}


	public void insertCategories()
	{

		try
	    {
			System.out.println("InsertCategories");
			String categ = null;
			Iterator<String> iter = Category.iterator();
			while (iter.hasNext())
			{
				categ = new String(iter.next());
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"SELECT category_id "
		        		+"FROM ted.category "
		        		+"WHERE value=?"
		        		);
				state.setString(1, categ);
				set = state.executeQuery();
				//if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
				while (set.next())
				{
					state = link.GetState();
					state = (link.GetCon()).prepareStatement(
			        		"INSERT INTO ted.item_category "
			        		+"VALUES (?,?)"
			        		);
					state.setLong(1, ItemID);
					state.setLong(2, set.getLong("category_id"));
					state.executeUpdate();
					if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
				}
				if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
			}
			System.out.println("OUT InsertCategories");
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}

	}


	public void updateCategories()
	{

		try
	    {
			System.out.println("1 UpdateCategories");
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"DELETE FROM item_category "
	        		+"WHERE item_id=?"
	        		);
			state.setLong(1, ItemID);
			state.executeUpdate();
			if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

			System.out.println("2 UpdateCategories");
			String categ = null;
			Iterator<String> iter = Category.iterator();
			while (iter.hasNext())
			{
				categ = new String(iter.next());
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"SELECT category_id "
		        		+"FROM ted.category "
		        		+"WHERE value=?"
		        		);
				state.setString(1, categ);
				set = state.executeQuery();
				//if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
				System.out.println("3 UpdateCategories");
				while (set.next())
				{
					System.out.println("4 UpdateCategories");
					state = link.GetState();
					state = (link.GetCon()).prepareStatement(
			        		"INSERT INTO ted.item_category "
			        		+"VALUES (?,?)"
			        		);
					state.setLong(1, ItemID);
					state.setLong(2, set.getLong("category_id"));
					state.executeUpdate();
					if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
					System.out.println("5 UpdateCategories");
				}
				if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
			}
			System.out.println("OUT UpdateCategories");
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}

	}


	public void importLiveness()
	{
		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"INSERT INTO ted.user_item "
	        		+"VALUES (?,?,?)"
	        		);
			state.setString(1, Seller_UserID);
			state.setLong(2, ItemID);
			state.setInt(3, 0);

			state.executeUpdate();
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}

	public void importLiveness(int num, String Seller_UserID)
	{
		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"INSERT INTO ted.user_item "
	        		+"VALUES (?,?,?)"
	        		);
			state.setString(1, Seller_UserID);
			state.setLong(2, ItemID);
			state.setInt(3, num);

			state.executeUpdate();
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}



	public ArrayList<String> findCategories(long itemid)
	{

		ArrayList<String> categories = new ArrayList<String>();

		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.item_category "
	        		+ "WHERE item_id=?"
	        		);
			state.setLong(1, itemid);
			ResultSet item_cat = state.executeQuery();
			//if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

			while(item_cat.next())
			{
				int category_id = item_cat.getInt("category_id");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"SELECT value "
		        		+"FROM ted.category "
		        		+ "WHERE category_id=?"
		        		);
				state.setLong(1, category_id);
				ResultSet value_set = state.executeQuery();
				//if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
				while(value_set.next())
				{
					categories.add(value_set.getString("value"));
				}
				if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
			}
			if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}



	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}

		return categories;
	}


	public Seller createSeller(long itemid)
	{

		Seller sel = null;
		int rate = 0;
		ResultSet user_item = null;
		ResultSet value_set = null;

		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.user_item "
	        		+ "WHERE item_id=?"
	        		);
			state.setLong(1, itemid);
			user_item = state.executeQuery();
			//if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

			while(user_item.next())
			{
				String username = user_item.getString("username");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"SELECT value "
		        		+"FROM ted.sellers "
		        		+ "WHERE username=?"
		        		);
				state.setString(1, username);
				value_set = state.executeQuery();
				//if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
				while(value_set.next())
				{
					rate = value_set.getInt("value");
				}

				sel = new Seller(rate,username);
				if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
			}
			if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}



	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (user_item != null) try { user_item.close(); } catch (SQLException logOrIgnore) {}
	        //if (value_set != null) try { value_set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}

		return sel;
	}


	public List<Bid> create_bids(long itemid)
	{

		List<Bid> bids = new ArrayList<Bid>();
		ResultSet loc_set = null;
		ResultSet item_bids = null;

		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.item_bids "
	        		+ "WHERE item_id=?"
	        		);
			state.setLong(1, itemid);
			item_bids = state.executeQuery();
			//System.out.println("before while bid");
			while(item_bids.next())
			{
				java.sql.Timestamp stamp = item_bids.getTimestamp("date_time");
				Date date = stamp;
				String time = date.toString();
				//System.out.println("time = "+time);
				float amount = item_bids.getFloat("price");
				String username = item_bids.getString("username");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"SELECT city,country,value "
		        		+"FROM ted.users u, ted.bidders b "
		        		+ "WHERE u.username=? AND b.username=u.username"
		        		);
				state.setString(1, username);
				loc_set = state.executeQuery();
				while(loc_set.next())
				{
					String location = loc_set.getString("city");
					String country = loc_set.getString("country");
					int rating = loc_set.getInt("value");
					Bidder bidder = new Bidder(location, country, rating, username);
					Bid bid = new Bid(bidder, time, amount);
					bids.add(bid);
				}
			}



	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (item_bids != null) try { item_bids.close(); } catch (SQLException logOrIgnore) {}
	        //if (loc_set != null) try { loc_set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}


		return bids;
	}


	public void importNewCategories()
	{

		try
	    {
		    int category_id = 0;
	        //link = new ConnectionDB();
	        state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.category "+
	        		"ORDER BY category_id DESC "+
	        		"LIMIT 1"
	        		);
	        ResultSet set1 = state.executeQuery();
	        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        if(set1.next())
	        {
	        	category_id = (set1.getInt("category_id"));
	        	category_id++;
	        }
	        else category_id = 1;

	        for(String cat_value : Category)
	        {
	        	System.out.println(" 1 Insert new category for loop "+cat_value);
		        state = link.GetState();
		        state = (link.GetCon()).prepareStatement(
		        		"SELECT * "+
		        		"FROM ted.category "+
		        		"WHERE value=?"
		        		);
		        state.setString(1, cat_value);
		        set1 = state.executeQuery();
		        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

		        System.out.println(" 2 Insert new category for loop "+cat_value);
		        //set1.first();
		        System.out.println(" 3 Insert new category for loop "+cat_value);
		        if(set1.next())
		        {
		        	if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
		        	System.out.println(" 3.1 Insert new category for loop "+cat_value);
		        	continue;
		        }
		        else
		        {
		        	if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
		        	System.out.println(" 3.2 Insert new category for loop "+cat_value);
		        	System.out.println("import Item");
					state = link.GetState();
					state = (link.GetCon()).prepareStatement(
			        		"INSERT INTO ted.category "
			        		+"VALUES (?,?)"
			        		);
					state.setInt(1, category_id);
					state.setString(2, cat_value);

					state.executeUpdate();
					if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
					category_id++;
		        }
	        }
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set != null) try { set.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}

	public void importNewBids(Bids bids)
	{
		List<Bid> bid_list = bids.getBids();
		System.out.println("importNewBids");

		if(bid_list != null)
		{
			for(Bid bidElem : bid_list)
			{
				System.out.println("FOR bidElem");

				String count = null;
				String loc = null;

				Bidder bidder = bidElem.getBidder();
				if(bidder.getCountry()!=null) count = new String(bidder.getCountry());
				if(bidder.getLocation()!=null) loc = new String(bidder.getLocation());
				int rate = bidder.getRating();
				String user = new String(bidder.getUsername());

				System.out.println("Import BIDS insertNewUser");
				this.insertNewUser(count, loc, user);

				System.out.println("Import BIDS insertNewBidder");
				this.insertNewBidder(user, rate);

				java.sql.Timestamp time = this.splitterDateTime(bidElem.getTime());

				float price = 0;
				String string = bidElem.getAmount();
				if(string != null) price = Float.parseFloat(string.substring(1));

				System.out.println("Import BIDS insertBid");
				this.insertBid(price, user, time);
			}
		}
	}

	public void insertNewUser(String country, String location,String user)
	{
		ResultSet set1 = null;
		try
	    {
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.users "+
	        		"WHERE username=?"
	        		);
	        state.setString(1, user);
	        set1 = state.executeQuery();
	        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

	        //set1.first();
	        if(set1.next())
	        {

	        }
	        else
	        {
	        	System.out.println("import New User");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement("INSERT INTO ted.users VALUES (?,aes_encrypt('1', SHA2('134711Kk',512)),'demo','demo','demo','demo','demo','demo',?,?,'demo',1,'user')");

		        state.setString(1,user);
		        state.setString(2,location);
		        state.setString(3,country);

		        state.executeUpdate();
		       // if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set1 != null) try { set1.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}

	public void insertNewUser(String user)
	{
		try
	    {
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.users "+
	        		"WHERE username=?"
	        		);
	        state.setString(1, user);
	        ResultSet set1 = state.executeQuery();

	        //set1.first();
	        if(set1.next()){}
	        else
	        {
	        	System.out.println("import New User");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement("INSERT INTO ted.users VALUES (?,aes_encrypt('1', SHA2('134711Kk',512)),'demo','demo','demo','demo','demo','demo','demo','demo','demo',1,'user')");

		        state.setString(1,user);

		        state.executeUpdate();
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set1 != null) try { set1.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}

	public void insertNewBidder(String user,int rate)
	{
		ResultSet set1 = null;
		try
	    {
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.bidders "+
	        		"WHERE username=?"
	        		);
	        state.setString(1, user);
	        set1 = state.executeQuery();
	        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

	        //set1.first();
	        if(set1.next())
	        {
	        	state = link.GetState();
				state = (link.GetCon()).prepareStatement("UPDATE ted.bidders SET value=? WHERE username=?");

		        state.setInt(1,rate);
		        state.setString(2,user);

		        state.executeUpdate();
		        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        }
	        else
	        {

		        System.out.println("import New Bidder");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement("INSERT INTO ted.bidders VALUES (?,?)");

		        state.setString(1,user);
		        state.setInt(2,rate);

		        state.executeUpdate();
		        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set1 != null) try { set1.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}

	public void insertBid(float price, String user, java.sql.Timestamp time)
	{
		ResultSet set1 = null;
		try
	    {
			System.out.println("import New Bidder");
			state = link.GetState();
			state = (link.GetCon()).prepareStatement("INSERT INTO ted.item_bids VALUES (?,?,?,?)");

	        state.setLong(1,ItemID);
	        state.setFloat(2,price);
	        state.setString(3,user);
	        state.setTimestamp(4,time);

	        state.executeUpdate();
	        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	        //if (set1 != null) try { set1.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}

	public void importNewSeller(Seller seller)
	{
		String user = seller.getUsername();
		int rate = seller.getRating();

		this.insertNewUser(user);
		this.insertNewSeller(user, rate);
		this.importLiveness(1, user);
	}

	public void insertNewSeller(String user,int rate)
	{
		try
	    {
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.sellers "+
	        		"WHERE username=?"
	        		);
	        state.setString(1, user);
	        ResultSet set1 = state.executeQuery();
	        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

	        //set1.first();
	        if(set1.next())
	        {
	        	state = link.GetState();
				state = (link.GetCon()).prepareStatement("UPDATE ted.sellers SET value=? WHERE username=?");

		        state.setInt(1,rate);
		        state.setString(2,user);

		        state.executeUpdate();
		        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}

	        }
	        else
	        {
	        	System.out.println("import New Seller");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement("INSERT INTO ted.sellers VALUES (?,?)");

		        state.setString(1,user);
		        state.setInt(2,rate);

		        state.executeUpdate();
		        //if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		finally
		{
	       // if (set1 != null) try { set1.close(); } catch (SQLException logOrIgnore) {}
	        if (state != null) try { state.close();  } catch (SQLException logOrIgnore) {}
	        //if (conn != null) try { conn.close(); } catch (SQLException logOrIgnore) {}
		}
	}

	public LinkedList<String> findTopKNeigh(String username,int K, LinkedHashMap<String, LinkedHashMap<String, Integer>> all_user_cat)
	{
		int i=0;
		//int j;
		LinkedHashMap<String, Integer> user_cat = null;
		user_cat = all_user_cat.get(username);
		LinkedList<UserScore> neigh_list = null;
		LinkedList<String> neigh_username = null;
		if(user_cat != null)
		{
			neigh_username = new LinkedList<String>();
			neigh_list = new LinkedList<UserScore>();
			int size = K;
			for (Map.Entry<String, LinkedHashMap<String, Integer>> entry : all_user_cat.entrySet()) // username
			{
				i++;
				//System.out.println(i+" Key : " + entry.getKey());
				//j=0;
				if(username.equals(entry.getKey())) continue;

				Iterator<String> it = user_cat.keySet().iterator();
				double sum = 0.0;
				for (Map.Entry<String, Integer> value : entry.getValue().entrySet()) //kathgoria kai agores ana username
				{
					String user_cat_name = it.next();
					int user_cat_value = user_cat.get(user_cat_name);
					//System.out.println(i+" user_cat_value : " + user_cat_value+" cat name: "+user_cat_name);
					//j++;
					sum = sum + Math.pow((user_cat_value - value.getValue()), 2);  //euklidia norma
					//System.out.println(j+" cat : " + value.getKey()+" "+value.getValue());
				}
				double square = Math.sqrt(sum);
				System.out.println(i+" user : " + entry.getKey()+" in common points = "+square+" with user = "+username);

				UserScore user_score = new UserScore(entry.getKey(), square);
				if(size != 0)
				{
					size--;
					neigh_list.add(user_score);
					if(size == 0)
					{
						Collections.sort(neigh_list, new UserScore());
					}
				}
				else if(size == 0)
				{
					UserScore last = neigh_list.getLast();
					if(user_score.getScore() < last.getScore())
					{
						neigh_list.removeLast();
						neigh_list.addLast(user_score);
						Collections.sort(neigh_list, new UserScore());
					}
				}
			}

			for(UserScore elem: neigh_list)
			{
				neigh_username.add(elem.getName());
			}
		}
		else System.out.println("NULL");

		return neigh_username;
	}


	public java.sql.Timestamp splitterDateTime(String set)
	{
		java.sql.Timestamp date_sql = null;

		String[] parts = set.split(" ");
		String date = new String(parts[0]);
		String time = new String(parts[1]);

		String[] date_parts = date.split("-");
		String proper_date = "20"+date_parts[2]+"-"+date_parts[0]+"-"+date_parts[1]+time;

		Date java_date;
		try {
			java_date = new SimpleDateFormat("yyyy-MMM-ddhh:mm").parse(proper_date);
			date_sql = new java.sql.Timestamp(java_date.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return date_sql;
	}

	public java.sql.Timestamp splitterENDDateTime(String set)
	{
		java.sql.Timestamp date_sql = null;

		String[] parts = set.split(" ");
		String date = new String(parts[0]);
		String time = new String(parts[1]);

		String[] date_parts = date.split("-");
		String proper_date = "2016"+"-"+date_parts[0]+"-"+date_parts[1]+time;

		Date java_date;
		try {
			java_date = new SimpleDateFormat("yyyy-MMM-ddhh:mm").parse(proper_date);
			date_sql = new java.sql.Timestamp(java_date.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return date_sql;
	}

	public LinkedList<String> getListNeighUsers(){ return list; }
}

@XmlRootElement(name="Items")
@XmlAccessorType(XmlAccessType.FIELD)
class ItemsXML
{
	@XmlElement(name="Item")
	List<ItemXML> ItemsXML;

    public ItemsXML(List<ItemXML> itemsXML){
    	ItemsXML = new ArrayList<ItemXML>(itemsXML);
    }
    public ItemsXML(){
    }

    public List<ItemXML> getItemsXML()
    {
    	return ItemsXML;
    }

}

//@XmlRootElement(name="Item")
//@XmlAccessorType(XmlAccessType.FIELD)
class ItemXML{

	@XmlAttribute(name="ItemID")
    protected long ItemID;

	@XmlElement(name="Name")
	String Name = null;

	@XmlElement(name="Category")
	ArrayList<String> Category = null;

	@XmlElement(name="Currently")
	String Currently = null;

	@XmlElement(name="Buy_Price")
	String Buy_Price = null;

	@XmlElement(name="First_Bid")
	String First_Bid = null;

	@XmlElement(name="Number_of_Bids")
	int Number_of_Bids = 0;  // upologizo otan thelo apo sunarthsh

	@XmlElement(name="Bids")
	Bids bids = null;

	@XmlElement(name="Location")
	String Location = null;

	@XmlElement(name="Country")
	String Country = null;

	@XmlElement(name="Started")
	String Started = null;

	@XmlElement(name="Ends")
	String Ends = null;

	@XmlElement(name="Seller")
	Seller Seller_UserID;

	@XmlElement(name="Description")
	String Description = null;

	@XmlElement(name="Photo_Url")
	String Photo_Url = null;


    public ItemXML(String name,ArrayList<String> category,float currently,float buy_price,
				float first_bid,int num_of_bids,String location,String country,String photo_url,
				String started,String ends,Seller seller_userid,String description,List<Bid> bid,
				long itemid)
    {
    	Name = new String(name);
		Category = new ArrayList<String>(category);
		Currently = Float.toString(currently);
		Buy_Price = Float.toString(buy_price);
		First_Bid = Float.toString(first_bid);
		Number_of_Bids = num_of_bids;
		Location = new String(location);
		Country = new String(country);
		Started = new String(started);
		Ends = new String(ends);
		Seller_UserID = seller_userid;
		Description = new String(description);
		if(photo_url == null) Photo_Url = null;
		else Photo_Url = new String(photo_url);
		bids = new Bids(bid);
		ItemID = itemid;
    }

    public ItemXML(){
    }


    public long getItemID()
    {
    	return ItemID;
    }

    public String getName()
    {
    	return Name;
    }

    public ArrayList<String> getCategory()
    {
    	return Category;
    }

    public String getCurrently()
    {
    	return Currently;
    }

    public String getBuy_Price()
    {
    	return Buy_Price;
    }

    public String getFirst_Bid()
    {
    	return First_Bid;
    }

    public int getNumber_of_Bids()
    {
    	return Number_of_Bids;
    }

    public Bids getBids()
    {
    	return bids;
    }

    public String getLocation()
    {
    	return Location;
    }

    public String getCountry()
    {
    	return Country;
    }

    public String getStartedDate()
    {
    	return Started;
    }

    public String getEndsDate()
    {
    	return Ends;
    }

    public Seller getSeller_UserID()
    {
    	return Seller_UserID;
    }

    public String getDescription()
    {
    	return Description;
    }

    public String getPhoto_Url()
    {
    	return Photo_Url;
    }




}

//@XmlRootElement(name="Bids")
//@XmlAccessorType(XmlAccessType.FIELD)
class Bids{

	@XmlElement(name="Bid")
	List<Bid> Bid;

	public Bids(List<Bid> bid)
	{
		Bid = new ArrayList<Bid>(bid);
	}
	public Bids(){
    }

	public List<Bid> getBids()
	{
		return Bid;
	}
}


//@XmlRootElement(name="Bid")
//@XmlAccessorType(XmlAccessType.FIELD)
class Bid{
	@XmlElement(name="Bidder")
	Bidder bidder;
	@XmlElement(name="Time")
	String Time;
	@XmlElement(name="Amount")
	String Amount;

	public Bid(Bidder bider,String time,float amount)
	{
		bidder = bider;
		Time = new String(time);
		Amount = Float.toString(amount);
	}
	public Bid(){
    }

	public Bidder getBidder()
	{
		return bidder;
	}

	public String getTime()
	{
		return Time;
	}

	public String getAmount()
	{
		return Amount;
	}

}

//@XmlRootElement(name="Bidder")
//@XmlAccessorType(XmlAccessType.FIELD)
class Bidder{

	@XmlAttribute(name="Rating")
	int rating = 0;

	@XmlAttribute(name="UserID")
	String username = null;

	@XmlElement(name="Location")
	String Location;

	@XmlElement(name="Country")
	String Country;

	public Bidder(String loc,String con,int rate,String user)
	{
		Location = new String(loc);
		Country = new String(con);
		rating = rate;
		username = new String(user);
	}
	public Bidder(){
    }

	public int getRating()
	{
		return rating;
	}

	public String getUsername()
	{
		return username;
	}

	public String getLocation()
	{
		return Location;
	}

	public String getCountry()
	{
		return Country;
	}

}

class Seller
{
	@XmlAttribute(name="Rating")
	int rating;

	@XmlAttribute(name="UserID")
	String username;

	public Seller(int rate,String user)
	{
		rating = rate;
		username = new String(user);
	}

	public Seller()
	{
	}

	public int getRating()
	{
		return rating;
	}

	public String getUsername()
	{
		return username;
	}

}
