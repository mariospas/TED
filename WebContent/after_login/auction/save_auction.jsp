<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.Object.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Αποθήκευση Δημοπρασίας</title>
</head>
<body>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{

		request.setCharacterEncoding("UTF-8");
		String name = null;
		float first_bid = -1;
		float currently_price = -1;
		float buy_price = -1;
		String latlong = null;
		String country = null;
		java.util.Date date = new SimpleDateFormat("MM-dd-yyyy").parse("2015-01-01");
		//java.sql.Date start_date = new java.sql.Date(date.getTime()) ;
		//java.sql.Date end_date = new java.sql.Date(date.getTime());
		String start_date = null;
		String end_date = null;
		String description = null;
		ArrayList<String> categoriesList = new ArrayList<String>();
		String photo_url = null;
		String sub_button = null;
		String sub_name = request.getParameter("id");

		List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		for (FileItem item : items)
		{
		    if (item.isFormField())
		    {
		        // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
		        String fieldname = item.getFieldName();
		        //String fieldvalue = item.getString("UTF-8");
		        if(fieldname.equals("name")) name = item.getString("UTF-8");
		        else if(fieldname.equals("first_bid"))
	        	{
		        	first_bid = Float.parseFloat(item.getString("UTF-8"));
		        	currently_price = first_bid;
	        	}
		        else if(fieldname.equals("buy_price"))
		        {
		        	if(item.getString("UTF-8") != null)
		        	{
		        		buy_price = Float.parseFloat(item.getString("UTF-8"));
		        	}
		        	else buy_price = -1; //den exei timh agoras
		       	}
		        else if(fieldname.equals("latlong")) latlong = item.getString("UTF-8");
		        else if(fieldname.equals("country")) country = item.getString("UTF-8");
		        else if(fieldname.equals("start_date"))
		        {
		        	//date = new SimpleDateFormat("yyyy-dd-MM").parse(item.getString("UTF-8"));
		        	//start_date = new java.sql.Date(date.getTime());
		        	start_date = item.getString("UTF-8");
		        }
		        else if(fieldname.equals("end_date"))
		        {
		        	//date = new SimpleDateFormat("yyyy-dd-MM").parse(item.getString("UTF-8"));
		        	//end_date = new java.sql.Date(date.getTime());
		        	end_date = item.getString("UTF-8");
		        }
		        else if(fieldname.equals("size")) continue;
		        else if(fieldname.equals("description")) description = item.getString("UTF-8");
		        else if(fieldname.equals("sub_button"))
	        	{
		        	sub_button = item.getString("UTF-8");
		        	sub_name = item.getName();

	        	}
		        else
		        {
		        	categoriesList.add(fieldname);
		        }
		    }
		    else
		    {
		        // Process form file field (input type="file").
		        String fieldname = item.getFieldName();
		        String filename = FilenameUtils.getName(item.getName());
		        if(filename.length()>0)
		        {
			        InputStream filecontent = item.getInputStream();

			        byte[] buffer = new byte[filecontent.available()];
			        filecontent.read(buffer);

			        String current = getServletContext().getRealPath(File.separator);
			        File dir = new File(current+"imagesM");
			        dir.mkdir();
			        dir = new File(current+"imagesM"+File.separator+"users");
			        dir.mkdir();
			        dir = new File(current+"imagesM"+File.separator+"users"+File.separator+log.getName());
			        dir.mkdir();
			        current += "imagesM"+File.separator+"users"+File.separator+log.getName()+File.separator;
			        String url = new String("imagesM"+File.separator+"users"+File.separator+log.getName()+File.separator);
				    File targetFile = new File(current+filename);
				    OutputStream outStream = new FileOutputStream(targetFile);
				    outStream.write(buffer);

				    photo_url = getServletContext().getContextPath()+File.separator+url+filename;
		        }
		    }
		}


		if(sub_button.equals("Αποθήκευση"))
		{
			Item item = new Item(name,categoriesList,currently_price,buy_price,first_bid,latlong,country,
								photo_url,start_date,end_date,log.getName(),description);

			item.importItem();
			item.insertCategories();
			item.importLiveness();

			//out.println("<center><h1>"+sub_name+" </h1></center>");

			String site = new String("live_auctions.jsp");
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", site);
		}
		else if(sub_button.equals("Αποθήκευση Επεξεργασίας"))
		{
			long item_id = (long) session.getAttribute("item");
			Item item = new Item(item_id,name,categoriesList,currently_price,buy_price,first_bid,latlong,country,
					photo_url,start_date,end_date,log.getName(),description);

			item.updateItem();
			item.updateCategories();

			String site = new String("live_auctions.jsp");
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", site);
		}


	}
	else
	{
		out.println("<center><h1> Permission Denied </h1></center>");
	}
%>

</body>
</html>