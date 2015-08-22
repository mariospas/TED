<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Δημιουργία Δημοπρασίας</title>
</head>
<body>

	<div id="all_form">
    	<div id="form_title">
        	Δημιουργία Δημοπρασίας!
        </div>

        <div id="main_form">
        	<form method="post" action="registration_process.jsp" onsubmit="return checkForm(this);">
            	<p><label>Όνομα :</label>
				<input type="text" id="onoma" name="onoma" required/></p>
                <br/>
                <p><label>Τωρινή Τιμή :</label>
				<input type="text" id="epitheto" name="epitheto" required/></p>
                <br/>
                <p><label>Αρχική Προσφορά :</label></p>
           		<input type="text" id="uname" name="uname" required/><span class="status" ></span>
                <br/>
                 <p><label>Τιμή Αγοράς :</label>
				<input type="email" id="taxudromio" name="taxudromio"  required/></p>
                <br/>
                <p><label>Location :</label></p>
				<input type="password" id="password" name="password" required/></p>
                <br/>
                <p><label>Χώρα :</label>
				<input type="password" id="passwordconf" name="passwordconf" oninput="check(this)"  required/></p>
                <br/>
                <p><label>Ημερομηνία Έναρξης :</label>
				<input type="number" id="thl" name="thl" required /></p>
				<br/>
                <p><label>Ημερομηνία Τερματισμού :  :</label>
				<input type="text" id="country" name="country" required /></p>
				<br/>
                <p><label>Εικόνα  :</label>
				<input type="text" id="city" name="city" required /></p>
                <br/>
                <p><label>Περιγραφή  :</label>
				<input type="text" id="address" name="address" required /></p>
                <br/>
                <input TYPE="submit" name="upload" id="sub_button" title="Add data to the Database" value="Εγγραφή"/>
            </form>
       </div>
    </div>

</body>
</html>