<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Registration Page</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/registration.css" type="text/css" media="screen" />
        <link href="/TED/appearance/css/lightbox.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans|Baumans' rel='stylesheet' type='text/css'/>
        <script src="/TED/appearance/scripts/modernizr.custom.04512.js"></script>
        <script src="/TED/appearance/scripts/respond.js"></script>

        <!-- include extern jQuery file but fall back to local file if extern one fails to load !-->
        <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text\/javascript" src="js\/1.7.2.jquery.min"><\/script>')</script>

        <script async src="/TED/appearance/scripts/lightbox.js"></script>
        <script src="/TED/appearance/scripts/prefixfree.min.js"></script>
        <script src="/TED/appearance/scripts/jquery.slides.min.js"></script>
		
		<script src="scripts/checkTwoPass.js"></script>
		<script src="scripts/saveDataAndFill.js"></script>
		
        <script>
			(function ($, window, document, undefined)
			{
				'use strict';
				$(function ()
				{
					$("#mobileMenu").hide();
					$(".toggleMobile").click(function()
					{
						$(this).toggleClass("active");
						$("#mobileMenu").slideToggle(500);
					});
				});
				$(window).on("resize", function()
				{

					if($(this).width() > 700)
					{
						$("#mobileMenu").hide();
						$(".toggleMobile").removeClass("active");
					}

				});
			})(jQuery, window, document);
		</script>
		
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
		<jsp:include page="/jsp_scripts/header_nav.jsp"/>
					
		<section id="boxcontent" >

		<div id="all_form">
			<div id="form_title">
				<hr>
				<b><p>Εγγραφή</p></b>
			</div>
	
			<div id="main_form">
				<form method="post" action="registration_process.jsp" onsubmit="return checkForm(this);">
					<p><label>Όνομα :</label>
					<input type="text" id="onoma" name="onoma" required/></p>
					<br/>
					<p><label>Επίθετο :</label>
					<input type="text" id="epitheto" name="epitheto" required/></p>
					<br/>
					<p><label>Όνομα Χρήστη :</label>
					<input type="text" id="uname" name="uname" required/><span class="status" ></span></p>
					<!-- <div id="hidden1"><b>(με λατινικούς χαρακτήρες)</b></div> -->
					<br/>
					<p><label>e-mail :</label>
					<input type="email" id="taxudromio" name="taxudromio"  required/></p>
					<br/>
					<p><label>Κωδικός πρόσβασης :<!--<b>(από 6-20 χαρακτήρες και να περιέχει αριθμούς, πεζά και κεφαλαία καθώς και ειδικούς χαρακτήρες!)</b>:--></label>
					<input type="password" id="password" name="password" required/></p>
					<br/>
					<p><label>Επιβεβαίωση κωδικού :</label>
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
		
		</section>
	
		<script type="text/javascript">
			rescuefieldvalues(['onoma', 'epitheto', 'uname', 'taxudromio', 'thl', 'country', 'city', 'address', 'tk', 'afm']);
		</script>
		
		<jsp:include page="/jsp_scripts/footer.jsp"/>
	
	</body>
</html>