<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration Form</title>
</head>
<body>
     <div id="all_form">
    	<div id="form_title">
        	Καλώς ήρθατε! Εγγραφείτε εδώ.
        </div>

        <div id="main_form">
        	<form method="post" action="registration_process.jsp">
            	<p><label>Όνομα :</label>
				<input type="text" id="onoma" name="onoma" required/></p>
                <br/>
                <p><label>Επίθετο :</label>
				<input type="text" id="epitheto" name="epitheto" required/></p>
                <br/>
                <p><label>Όνομα Χρήστη :<b>(με λατινικούς χαρακτήρες)</b>:</p></label></p>
           		<input type="text" name="uname"/><span class="status"></span>
                <br/>
                 <p><label>e-mail :</label>
				<input type="text" id="taxudromio" name="taxudromio"  required/></p>
                <br/>
                <p><label>Κωδικός πρόσβασης :</label>
				<input type="password" id="password" name="password" required/></p>
                <br/>
                <p><label>Επιβεβαίωση κωδικού πρόσβασης :</label>
				<input type="password" id="passwordconf" name="passwordconf" oninput="check(this)"  required/></p>
                <br/>
                <p><label>Τηλέφωνο :</label>
				<input type="text" id="thl" name="thl"  /></p>
                <br/>
                <p><label>Διεύθυνση  :</label>
				<input type="text" id="address" name="address"  /></p>
                <br/>
                <p><label>T.K  :</label>
				<input type="text" id="tk" name="tk"  /></p>
                <br/>
                <p><label>Α.Φ.Μ  :</label>
				<input type="text" id="afm" name="afm"  /></p>
                <br/>
                 <input TYPE="submit" name="upload" id="sub_button" title="Add data to the Database" value="Εγγραφή"/>
            </form>
       </div>
    </div>
</body>
</html>
