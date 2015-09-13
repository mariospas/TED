package xml_mars_unmars;

public class FriendItems {

	long item_id;
	String Name = null;
	float CurrentPrice;
	String PhotoURL = null;

	public FriendItems(long item,String name,float current,String photo)
	{
		item_id = item;
		Name = new String(name);
		CurrentPrice = current;
		if(photo != null) PhotoURL = new String(photo);
	}

	public String getName(){ return Name; }
	public String getPhotoURL() { return PhotoURL;}
	public float getCurrentPrice() { return CurrentPrice; }
	public long getItemID() { return item_id; }

}
