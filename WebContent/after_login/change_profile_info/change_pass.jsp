<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Αλλαγή Κωδικού</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
<script src="../../scripts/checkTwoPass.js"></script>
<script src="../../scripts/saveDataAndFill.js"></script>

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
        	 Αλλαγή Κωδικού
        </div>

        <div id="main_form">
        	<form method="post" action="change_pass_process.jsp" onsubmit="return checkForm(this);">
            	<p><label>Παλίος Κωδικός πρόσβασης :</label></p>
				<input type="password" id="passwordold" name="passwordold" required/></p>
                <br/>
                <p><label>Νέος Κωδικός πρόσβασης :<b>(από 6-20 χαρακτήρες και να περιέχει αριθμούς, πεζά και κεφαλαία καθώς και ειδικούς χαρακτήρες!)</b>:</p></label></p>
				<input type="password" id="password" name="password" required/></p>
                <br/>
                <p><label>Επιβεβαίωση κωδικού πρόσβασης :</label>
				<input type="password" id="passwordconf" name="passwordconf" oninput="check(this)"  required/></p>
                <br/>
                 <input TYPE="submit" name="upload" id="sub_button" title="Add data to the Database" value="Αλλαγή Κωδικού"/>
                 <input type="button" onclick="history.go(-1);" value="Άκυρο">
            </form>
       </div>
    </div>




    <script type="text/javascript">

			rescuefieldvalues(['onoma', 'epitheto', 'uname', 'taxudromio', 'thl', 'address', 'tk', 'afm']);

	</script>


</body>
</html>