<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="category.*"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Δημιουργία Δημοπρασίας</title>
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
<jsp:include page="../../logout.html"/>
<jsp:include page="../profile_button.html"/>
<body>

<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log != null)
	{
		Category cat = new Category();
		ResultSet set = cat.get_categories();
%>

	<div id="all_form">
    	<div id="form_title">
        	Δημιουργία Δημοπρασίας!
        </div>

        <div id="main_form">
        	<form method="post" action="save_auction.jsp?id=create" ENCTYPE="multipart/form-data" >
            	<p><label>Όνομα :</label>
				<input type="text" id="name" name="name" style="width: 300px;" required/></p>
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
			        while (set.next())
					{
					%>
			            <label for="<%out.print(set.getString("value"));%>"><input type="checkbox" name="<%out.print(set.getString("value"));%>" id="<%out.print(set.getString("value"));%>"/><%out.print(set.getString("value"));%></label>
			       <%}
			        %>
			        </div>
			    </div>
				<br/>
                <p><label>Αρχική Προσφορά :</label>
           		<input type="text" id="first_bid" name="first_bid" required/></p>
                <br/>
                <p><label>*Τιμή Αγοράς :</label>
				<input type="text" id="buy_price" name="buy_price"  /></p>
                <br/>
                <p><label>Location : (latitude;longtitude e.g 2.458;3.589)</label></p>
				<input type="text" id="latlong" name="latlong" required/></p>
                <br/>
                <p><label>Χώρα :</label>
				<input type="text" id="country" name="country" required/></p>
                <br/>
                <p><label>Ημερομηνία Έναρξης :</label>
				<input type="date" id="start_date" name="start_date" required /></p>
				<br/>
                <p><label>Ημερομηνία Τερματισμού :  :</label>
				<input type="date" id="end_date" name="end_date" required /></p>
				<br/>
                <p><label>* Φωτογραφία :</label>
                <input type="hidden" name="size" value="1048576">
                <input type="file" name="photo" id="i_file"> </p>
                </br>
                <p><label>Περιγραφή  :</label>
                </br>
				<input type="text" id="description" name="description" style="width: 300px; height: 300px;" required /></p>
                <br/>
                <input TYPE="submit" name="sub_button" id="sub_button" title="Add data to the Database" value="Αποθήκευση"/>
            </form>
       </div>
    </div>


    <script type="text/javascript">

			rescuefieldvalues(['name', 'currently_price', 'first_bid', 'buy_price', 'latlong', 'country', 'start_date', 'end_date']);

	</script>
<%
	}
	else
	{
		out.println("<center><h1> Permission Denied </h1></center>");
	}
%>

</body>
</html>