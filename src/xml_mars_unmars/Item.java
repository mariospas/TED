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
import java.util.Date;
import java.util.Iterator;
import java.util.List;
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

/**
 * JAXB example to generate xml document from Java object also called xml marshaling
 * from Java object or xml binding in Java.
 *
 * @author  Javin Paul
 */


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
	//java.sql.Date Started;
	//java.sql.Date Ends;
	String Started = null;
	String Ends = null;
	String Seller_UserID = null;
	String Description = null;
	String Photo_Url = null;
	String download_url = null;

	ConnectionDB link;

	PreparedStatement state = null;
    ResultSet set = null;

	public Item(String name,ArrayList<String> category,float currently,float buy_price,
				float first_bid,String location,String country,String photo_url,
				String started,String ends,String seller_userid,String description)
	{
		//ItemID;
		Name = new String(name);
		Category = new ArrayList<String>(category);
		Currently = currently;
		Buy_Price = buy_price;
		First_Bid = first_bid;
		Location = new String(location);
		Country = new String(country);
		Started = new String(started);
		Ends = new String(ends);
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
			String started,String ends,String seller_userid,String description)
	{
		ItemID = item_id;
		Name = new String(name);
		Category = new ArrayList<String>(category);
		Currently = currently;
		Buy_Price = buy_price;
		First_Bid = first_bid;
		Location = new String(location);
		Country = new String(country);
		Started = new String(started);
		Ends = new String(ends);
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
				started = set.getString("start_date");
				ends = set.getString("end_date");
				System.out.println("~~ 5 ~~");

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
			}

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
		//try
		//{
			JAXBContext jaxbCtx = null;

			try
			{
				jaxbCtx = JAXBContext.newInstance(ItemsXML.class);
				File targetFile = new File(xml);
			    System.out.println("~~ 13 222 ~~");
			    //System.out.println(FileUtils.readFileToString(targetFile));


		        ItemsXML b = (ItemsXML) jaxbCtx.createUnmarshaller().unmarshal(
		                                           new StringReader(FileUtils.readFileToString(targetFile)));
		        //System.out.println("XML Unmarshal example in JAva");
		        //System.out.println(b.toString());

		        List<ItemXML> Items = b.getItemsXML();
		        for(ItemXML itemElem : Items)
		        {
		        	System.out.println("Item ID = "+itemElem.getItemID());
		        	ItemID = itemElem.getItemID();
					Name = itemElem.getName();
					Currently = itemElem.getCurrently();
					Buy_Price = itemElem.getBuy_Price();
					First_Bid = itemElem.getFirst_Bid();
					Location = itemElem.getLocation();
					Country = itemElem.getCountry();
					Started = itemElem.getStartedDate();
					Ends = itemElem.getEndsDate();
					Description = itemElem.getDescription();
					Photo_Url = itemElem.getPhoto_Url();
					Category = itemElem.getCategory();
					Bids bids = itemElem.getBids();
					Seller seller = itemElem.getSeller_UserID();

					this.importNewCategories();

					this.importItem();
					this.insertCategories();
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
		//}
       // catch(SQLException ex)
	   // {
	   // 	ex.printStackTrace();
	  //  }

	}

	public String getDownloadLink()
	{
		return download_url;
	}

	public void importItem()
	{
		try
	    {
			System.out.println("import Item");
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
			state.setString(8, Started);
			state.setString(9, Ends);
			state.setString(10, Description);
			state.setString(11, Photo_Url);

			state.executeUpdate();
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
		System.out.println("out import Item");
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
				state.setString(7, Started);
				state.setString(8, Ends);
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
				state.setString(7, Started);
				state.setString(8, Ends);
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
	}


	public void insertCategories()
	{

		try
	    {
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
				}
			}

	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

	}


	public void updateCategories()
	{

		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"DELETE FROM item_category "
	        		+"WHERE item_id=?"
	        		);
			state.setLong(1, ItemID);
			state.executeUpdate();


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
				}
			}

	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
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
				while(value_set.next())
				{
					categories.add(value_set.getString("value"));
				}
			}



	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return categories;
	}


	public Seller createSeller(long itemid)
	{

		Seller sel = null;
		int rate = 0;

		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.user_item "
	        		+ "WHERE item_id=?"
	        		);
			state.setLong(1, itemid);
			ResultSet user_item = state.executeQuery();

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
				ResultSet value_set = state.executeQuery();
				while(value_set.next())
				{
					rate = value_set.getInt("value");
				}

				sel = new Seller(rate,username);
			}



	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }

		return sel;
	}


	public List<Bid> create_bids(long itemid)
	{

		List<Bid> bids = new ArrayList<Bid>();

		try
	    {
			state = link.GetState();
			state = (link.GetCon()).prepareStatement(
	        		"SELECT * "
	        		+"FROM ted.item_bids "
	        		+ "WHERE item_id=?"
	        		);
			state.setLong(1, itemid);
			ResultSet item_bids = state.executeQuery();

			while(item_bids.next())
			{
				String time = item_bids.getString("date_time");
				float amount = item_bids.getFloat("price");
				String username = item_bids.getString("username");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement(
		        		"SELECT city,country,value "
		        		+"FROM ted.users u, ted.bidders b "
		        		+ "WHERE u.username=? AND b.username=u.username"
		        		);
				state.setString(1, username);
				ResultSet loc_set = state.executeQuery();
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

		return bids;
	}


	public void importNewCategories()
	{
		ResultSet set1;
		try
	    {
		    int category_id = 0;
	        link = new ConnectionDB();
	        state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.category "+
	        		"ORDER BY category_id DESC "+
	        		"LIMIT 1"
	        		);
	        set1 = state.executeQuery();
	        if(set1.next())
	        {
	        	category_id = (set1.getInt("category_id"));
	        	category_id++;
	        }
	        else category_id = 1;

	        for(String cat_value : Category)
	        {
		        state = link.GetState();
		        state = (link.GetCon()).prepareStatement(
		        		"SELECT * "+
		        		"FROM ted.category "+
		        		"WHERE value=?"
		        		);
		        state.setString(1, cat_value);
		        set1 = state.executeQuery();

		        set1.first();
		        if(set.getString("value") == null)
		        {
		        	continue;
		        }
		        else
		        {
		        	System.out.println("import Item");
					state = link.GetState();
					state = (link.GetCon()).prepareStatement(
			        		"INSERT INTO ted.category "
			        		+"VALUES (?,?)"
			        		);
					state.setInt(1, category_id);
					state.setString(2, cat_value);

					state.executeUpdate();
					category_id++;
		        }
	        }
	    }
	    catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	}

	public void importNewBids(Bids bids)
	{
		List<Bid> bid_list = bids.getBids();

		for(Bid bidElem : bid_list)
		{
			Bidder bidder = bidElem.getBidder();
			String count = new String(bidder.getCountry());
			String loc = new String(bidder.getLocation());
			int rate = bidder.getRating();
			String user = new String(bidder.getUsername());
			this.insertNewUser(count, loc, user);
			this.insertNewBidder(user, rate);

			String time = bidElem.getTime();
			float price = bidElem.getAmount();

			this.insertBid(price, user, time);
		}
	}

	public void insertNewUser(String country, String location,String user)
	{
		ResultSet set1;
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

	        set1.first();
	        if(set.getString("username") != null)
	        {
	        	System.out.println("import New User");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement("INSERT INTO ted.users VALUES (?,1,demo,demo,demo,demo,demo,demo,?,?,demo,1,'user')");

		        state.setString(1,user);
		        state.setString(2,location);
		        state.setString(3,country);

		        state.executeUpdate();
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	}

	public void insertNewUser(String user)
	{
		ResultSet set1;
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

	        set1.first();
	        if(set.getString("username") != null)
	        {
	        	System.out.println("import New User");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement("INSERT INTO ted.users VALUES (?,1,demo,demo,demo,demo,demo,demo,demo,demo,demo,1,'user')");

		        state.setString(1,user);

		        state.executeUpdate();
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	}

	public void insertNewBidder(String user,int rate)
	{
		ResultSet set1;
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

	        set1.first();
	        if(set.getString("username") != null)
	        {
	        	System.out.println("import New Bidder");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement("INSERT INTO ted.bidders VALUES (?,?)");

		        state.setString(1,user);
		        state.setInt(2,rate);

		        state.executeUpdate();
	        }
	        else
	        {
	        	state = link.GetState();
				state = (link.GetCon()).prepareStatement("UPDATE ted.bidders SET value=? WHERE username=?");

		        state.setInt(1,rate);
		        state.setString(2,user);

		        state.executeUpdate();
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	}

	public void insertBid(float price, String user, String time)
	{
		ResultSet set1;
		try
	    {
			System.out.println("import New Bidder");
			state = link.GetState();
			state = (link.GetCon()).prepareStatement("INSERT INTO ted.item_bids VALUES (?,?,?,?)");

	        state.setLong(1,ItemID);
	        state.setFloat(2,price);
	        state.setString(3,user);
	        state.setString(4,time);

	        state.executeUpdate();

	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
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
		ResultSet set1;
		try
	    {
			state = link.GetState();
	        state = (link.GetCon()).prepareStatement(
	        		"SELECT * "+
	        		"FROM ted.sellers "+
	        		"WHERE username=?"
	        		);
	        state.setString(1, user);
	        set1 = state.executeQuery();

	        set1.first();
	        if(set.getString("username") != null)
	        {
	        	System.out.println("import New Seller");
				state = link.GetState();
				state = (link.GetCon()).prepareStatement("INSERT INTO ted.sellers VALUES (?,?)");

		        state.setString(1,user);
		        state.setInt(2,rate);

		        state.executeUpdate();
	        }
	        else
	        {
	        	state = link.GetState();
				state = (link.GetCon()).prepareStatement("UPDATE ted.sellers SET value=? WHERE username=?");

		        state.setInt(1,rate);
		        state.setString(2,user);

		        state.executeUpdate();
	        }
	    }
		catch(SQLException ex)
	    {
	    	ex.printStackTrace();
	    }
	}
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
	float Currently = 0;

	@XmlElement(name="Buy_Price")
	float Buy_Price = 0;

	@XmlElement(name="First_Bid")
	float First_Bid = 0;

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
		Currently = currently;
		Buy_Price = buy_price;
		First_Bid = first_bid;
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

    public float getCurrently()
    {
    	return Currently;
    }

    public float getBuy_Price()
    {
    	return Buy_Price;
    }

    public float getFirst_Bid()
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
	float Amount;

	public Bid(Bidder bider,String time,float amount)
	{
		bidder = bider;
		Time = new String(time);
		Amount = amount;
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

	public float getAmount()
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