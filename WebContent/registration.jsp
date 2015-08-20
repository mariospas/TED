<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration Form</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script src="scripts/checkTwoPass.js"></script>
<script src="scripts/saveDataAndFill.js"></script>


<script type="text/javascript">

function checkPassword(str)
{
	var re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$/;
	return re.test(str);
}

function checkForm(form)
{

	if(form.password.value != "" && form.password.value == form.passwordconf.value)
	{
		if(!checkPassword(form.password.value))
		{
			alert("Ο κωδικός που έχει εισαχθεί δεν είναι σωστός!");
			form.password.focus();
			return false;
		}
	}
	return true;
}
</script>

</head>
<body>
     <div id="all_form">
    	<div id="form_title">
        	Καλώς ήρθατε! Εγγραφείτε εδώ.
        </div>

        <div id="main_form">
        	<form method="post" action="registration_process.jsp" onsubmit="return checkForm(this);">
            	<p><label>Όνομα :</label>
				<input type="text" id="onoma" name="onoma" required/></p>
                <br/>
                <p><label>Επίθετο :</label>
				<input type="text" id="epitheto" name="epitheto" required/></p>
                <br/>
                <p><label>Όνομα Χρήστη :<b>(με λατινικούς χαρακτήρες)</b>:</p></label></p>
           		<input type="text" id="uname" name="uname" required/><span class="status" ></span>
                <br/>
                 <p><label>e-mail :</label>
				<input type="email" id="taxudromio" name="taxudromio"  required/></p>
                <br/>
                <p><label>Κωδικός πρόσβασης :<b>(από 6-20 χαρακτήρες και να περιέχει αριθμούς, πεζά και κεφαλαία καθώς και ειδικούς χαρακτήρες!)</b>:</p></label></p>
				<input type="password" id="password" name="password" required/></p>
                <br/>
                <p><label>Επιβεβαίωση κωδικού πρόσβασης :</label>
				<input type="password" id="passwordconf" name="passwordconf" oninput="check(this)"  required/></p>
                <br/>
                <p><label>Τηλέφωνο :</label>
				<input type="number" id="thl" name="thl" required /></p>
				<br/>
                <p><label>Χώρα  :</label>
				<input type="text" id="country" name="country" required /></p>
				<br/>
                <p><label>Πόλη  :</label>
				<input type="text" id="city" name="city" required /></p>
                <br/>
                <p><label>Διεύθυνση  :</label>
				<input type="text" id="address" name="address" required /></p>
                <br/>
                <p><label>T.K  :</label>
				<input type="number" id="tk" name="tk" required /></p>
                <br/>
                <p><label>Α.Φ.Μ  :</label>
				<input type="number" id="afm" name="afm" required /></p>
                <br/>
                 <input TYPE="submit" name="upload" id="sub_button" title="Add data to the Database" value="Εγγραφή"/>
            </form>
       </div>
    </div>




    <script type="text/javascript">

			rescuefieldvalues(['onoma', 'epitheto', 'uname', 'taxudromio', 'thl', 'country', 'city', 'address', 'tk', 'afm']);

	</script>

</body>
</html>