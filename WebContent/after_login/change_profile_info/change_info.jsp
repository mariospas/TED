<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Αλλαγή Info</title>
</head>
<body>
	<div id="all_form">
    	<div id="form_title">
        	Αλλαγή Στοιχείων
        </div>

        <div id="main_form">
        	<form method="post" action="change_info_process.jsp">
            	<p><label>Όνομα :</label>
				<input type="text" id="onoma" name="onoma" required/></p>
                <br/>
                <p><label>Επίθετο :</label>
				<input type="text" id="epitheto" name="epitheto" required/></p>
                <br/>
                <p><label>e-mail :</label>
				<input type="email" id="taxudromio" name="taxudromio"  required/></p>
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
                <input TYPE="submit" name="upload" id="sub_button" title="Add data to the Database" value="Αλλαγή Στοιχείων"/>
                <input type="button" onclick="history.go(-1);" value="Άκυρο">
            </form>
       </div>
    </div>




    <script type="text/javascript">

			rescuefieldvalues(['onoma', 'epitheto', 'taxudromio', 'thl', 'country', 'city', 'address', 'tk', 'afm']);

	</script>

</body>
</html>