<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Επεξεργασία Δημοπρασίας</title>
<link rel="stylesheet" type="text/css" href="../../css/after_login/auction/create_auction.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script src="../../scripts/checkFileSize.js"></script>
<script src="../../scripts/saveDataAndFill.js"></script>
<script>
    var expanded = false;
    function showCheckboxes() {
        var checkboxes = document.getElementById("checkboxes");
        if (!expanded) {
            checkboxes.style.display = "block";
            expanded = true;
        } else {
            checkboxes.style.display = "none";
            expanded = false;
        }
    }
</script>
</head>
<body>
<jsp:include page="../../logout.html"/>
<jsp:include page="../profile_button.html"/>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{

		request.setCharacterEncoding("UTF-8");
		String sub = request.getParameter("sub");
		//out.println("<p><b>"+sub+"</b></p>");

		String item_name = request.getParameter("item");
		//out.println("<p><b>"+item_name+"</b></p>");
		long item_id = Long.parseLong(item_name);
		session.setAttribute("item", item_id);

		Auctions auction = new Auctions(log.getName());

		if(sub.equals("Επεξεργασία"))
		{
			Category cat = new Category();
			ResultSet set = cat.get_categories();
			ResultSet item_set = auction.requested_item(item_id);
			ResultSet item_cat = cat.get_item_categories(item_id);
			while (item_set.next())
			{
%>
				<div id="all_form">
			    	<div id="form_title">
			        	Επεξεργασία Δημοπρασίας!
			        </div>

			        <div id="main_form">
			        	<form method="post" action="save_auction.jsp" ENCTYPE="multipart/form-data" >
			            	<p><label>Όνομα :</label>
							<input type="text" id="name" name="name" style="width: 300px;" value="<%out.print(item_set.getString("name"));%>" required/></p>
			                <br/>
			                <p><label>Κατηγορίες :</label></p>
			                <div class="multiselect">
						        <div class="selectBox" onclick="showCheckboxes()">
						            <select required>
						                <option>Select an option</option>
						            </select>
						            <div class="overSelect"></div>
						        </div>
						        <div id="checkboxes">
						        <%
								boolean flag=false;   //den tairiakse
						        while (set.next())
								{
						        	item_cat.beforeFirst();
						        	while (item_cat.next())
									{
						        		flag=false;
						        		if(set.getInt("category_id") == item_cat.getInt("category_id"))
						        		{
						        			flag = true;
						        			break;
						        		}

									}
						        	if(flag)
						        	{
						   %>
					            		<label for="<%out.print(set.getString("value"));%>"><input type="checkbox" checked="checked" name="<%out.print(set.getString("value"));%>" id="<%out.print(set.getString("value"));%>"/><%out.print(set.getString("value"));%></label>
					       <%
						        	}
						        	else
					        		{
						        		flag = false;
					       %>
					        			<label for="<%out.print(set.getString("value"));%>"><input type="checkbox" name="<%out.print(set.getString("value"));%>" id="<%out.print(set.getString("value"));%>"/><%out.print(set.getString("value"));%></label>
					       <%
					        		}

						         }
						        %>
						        </div>
						    </div>
							<br/>
			                <p><label>Αρχική Προσφορά :</label>
			           		<input type="text" id="first_bid" name="first_bid" value="<%out.print(item_set.getString("first_bid"));%>" required/></p>
			                <br/>
			                <p><label>*Τιμή Αγοράς :</label>
							<input type="text" id="buy_price" name="buy_price" value="<%out.print(item_set.getString("buy_price"));%>" /></p>
			                <br/>
			                <p><label>Location : (latitude;longtitude e.g 2.458;3.589)</label></p>
							<input type="text" id="latlong" name="latlong" value="<%out.print(item_set.getString("location"));%>" required/></p>
			                <br/>
			                <p><label>Χώρα :</label>
							<input type="text" id="country" name="country" value="<%out.print(item_set.getString("country"));%>" required/></p>
			                <br/>
			                <p><label>Ημερομηνία Έναρξης :</label>
							<input type="date" id="start_date" name="start_date" value="<%out.print(item_set.getString("start_date"));%>" required /></p>
							<br/>
			                <p><label>Ημερομηνία Τερματισμού :  :</label>
							<input type="date" id="end_date" name="end_date" value="<%out.print(item_set.getString("end_date"));%>" required /></p>
							<br/>
			                <p><label>* Φωτογραφία :</label>
			                <input type="hidden" name="size" value="1048576">
			                <input type="file" name="photo" id="i_file" value="<%out.print(item_set.getString("photo_url"));%>"> </p>
			                </br>
			                <p><label>Περιγραφή  :</label>
			                </br>
							<input type="text" id="description" name="description" style="width: 300px; height: 300px;" value="<%out.print(item_set.getString("description"));%>" required /></p>
			                <br/>
			                <input TYPE="submit" name="sub_button" id="sub_button" title="Add data to the Database" value="Αποθήκευση Επεξεργασίας"/>
			            </form>
						<form method="post" action="http://localhost:8080/TED/after_login/auction/edit_auction.jsp">
				            <p><input type="radio" name="item" value="<%out.print(item_set.getLong("item_id"));%>" id="item">Συμφωνώ να διαγραφή το προϊόν</p>
							<input align="center" TYPE="submit" name="sub" id="sub" value="Διαγραφή"/>
							 <input type="button" onclick="history.go(-1);" value="Άκυρο">
						</form>
			       </div>
			    </div>
<%
			}
		}
		else if(sub.equals("Διαγραφή"))
		{
			int ret = auction.delete_item(item_id);
			if(ret == 0) out.println("<center><p><b>Permission Denied</b></p></center>");
			else if(ret == 1)
			{
%>
				<center><p><b>Η Διαγραφή ολοκληρώθηκε</b></p></center>
				<p align="center"><b><a href="live_auctions.jsp">Επιστροφή</a></b></p>
<%
			}
		}
		else if(sub.equals("Ενεργοποίηση"))
		{
			auction.onlineLiveness(item_id);
%>
				<center><p><b>Ενεργοποιήθηκε</b></p></center>
				<p align="center"><b><a href="live_auctions.jsp">Επιστροφή</a></b></p>
<%
		}

	}
	else
	{
		out.println("<center><h1> Guest Mode Permission Denied</h1></center>");
	}
%>
</body>
</html>