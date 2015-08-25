package xml_mars_unmars;
import java.io.StringReader;
import java.io.StringWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import connection.ConnectionDB;

/**
 * JAXB example to generate xml document from Java object also called xml marshaling
 * from Java object or xml binding in Java.
 *
 * @author  Javin Paul
 */


public class Item {

	int ItemID;
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
		Photo_Url = new String(photo_url);

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



	public Item(String args[]){

        //Creating booking object for marshaling into XML document
        Booking booking = new Booking();
        booking.setName("Rohit");
        booking.setContact(983672431);
        DateFormat formatter = new SimpleDateFormat("dd/MM/yy");
        Date startDate = null;
        Date endDate = null;
        try {
            startDate = formatter.parse("11/09/2012");
            endDate = formatter.parse("14/09/2012");
        } catch (ParseException ex) {
            Logger.getLogger(Item.class.getName()).log(Level.SEVERE,
                                                                         null, ex);
        }
        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
        booking.setAddress("Mumbai");


        JAXBContext jaxbCtx = null;
        StringWriter xmlWriter = null;
        try {
            //XML Binding code using JAXB

            jaxbCtx = JAXBContext.newInstance(Booking.class);
            xmlWriter = new StringWriter();
            jaxbCtx.createMarshaller().marshal(booking, xmlWriter);
            System.out.println("XML Marshal example in Java");
            System.out.println(xmlWriter);

            Booking b = (Booking) jaxbCtx.createUnmarshaller().unmarshal(
                                               new StringReader(xmlWriter.toString()));
            System.out.println("XML Unmarshal example in JAva");
            System.out.println(b.toString());
        } catch (JAXBException ex) {
            Logger.getLogger(Item.class.getName()).log(Level.SEVERE,
                                                                          null, ex);
        }
    }
}

@XmlRootElement(name="booking")
@XmlAccessorType(XmlAccessType.FIELD)
class Booking{
    @XmlElement(name="name")
    private String name;

    @XmlElement(name="contact")
    private int contact;

    @XmlElement(name="startDate")
    private Date startDate;

    @XmlElement(name="endDate")
    private Date endDate;

    @XmlElement(name="address")
    private String address;

    public Booking(){}

    public Booking(String name, int contact, Date startDate, Date endDate, String address){
        this.name = name;
        this.contact = contact;
        this.startDate = startDate;
        this.endDate = endDate;
        this.address = address;
    }

    public String getAddress() { return address; }
    public void setAddress(String address) {this.address = address; }

    public int getContact() { return contact; }
    public void setContact(int contact) {this.contact = contact;}

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    @Override
    public String toString() {
        return "Booking{" + "name=" + name + ", contact=" + contact + ", startDate=" + startDate + ", endDate=" + endDate + ", address=" + address + '}';

    }

}
