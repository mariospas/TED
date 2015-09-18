<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>General HomePage</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_create_item.css" type="text/css" media="screen" />
        <link href="/TED/appearance/css/lightbox.css" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="../../css/after_login/auction/create_auction.css">
        <link href='http://fonts.googleapis.com/css?family=Open+Sans|Baumans' rel='stylesheet' type='text/css'/>
        <script src="/TED/appearance/scripts/modernizr.custom.04512.js"></script>
        <script src="/TED/appearance/scripts/respond.js"></script>

        <!-- include extern jQuery file but fall back to local file if extern one fails to load !-->
        <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text\/javascript" src="js\/1.7.2.jquery.min"><\/script>')</script>

        <script async src="/TED/appearance/scripts/lightbox.js"></script>
        <script src="/TED/appearance/scripts/prefixfree.min.js"></script>
        <script src="/TED/appearance/scripts/jquery.slides.min.js"></script>
        <script src="../../scripts/checkFileSize.js"></script>
		<script src="../../scripts/saveDataAndFill.js"></script>


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
<jsp:include page="../../jsp_scripts/header_nav.jsp"/>

<div id="all_form">
    	<div id="form_title">
        	 <h2 align="center" style="font-size:24px;">Αλλαγή Κωδικού</h2>
        </div>

        <div id="main_form">
        	<form method="post" action="change_pass_process.jsp" onsubmit="return checkForm(this);">
            	<p style="font-size:20px;"><label>Παλίος Κωδικός πρόσβασης :</label></p>
            	<hr>
				<input type="password" id="passwordold" name="passwordold" required/>
                <br/>
                <br>
                <p style="font-size:20px;"><label>Νέος Κωδικός πρόσβασης :<b>(από 6-20 χαρακτήρες και να περιέχει αριθμούς, πεζά και κεφαλαία καθώς και ειδικούς χαρακτήρες!)</b>:</label></p>
				<hr>
				<input type="password" id="password" name="password" required/>
                <br/>
                <br>
                <p style="font-size:20px;"><label>Επιβεβαίωση κωδικού πρόσβασης :</label></p>
				<hr>
				<input type="password" id="passwordconf" name="passwordconf" oninput="check(this)"  required/>
                <br/>
                <br>
                 <input TYPE="submit" name="upload" id="sub_button" title="Add data to the Database" value="Αλλαγή Κωδικού"/>
                 <input type="button" onclick="history.go(-1);" value="Άκυρο">
            </form>
       </div>
    </div>




    <script type="text/javascript">

			rescuefieldvalues(['onoma', 'epitheto', 'uname', 'taxudromio', 'thl', 'address', 'tk', 'afm']);

	</script>


<jsp:include page="../../jsp_scripts/footer.jsp"/>



</body>
</html>