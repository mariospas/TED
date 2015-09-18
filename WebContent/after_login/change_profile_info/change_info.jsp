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



</head>

<body>
<jsp:include page="../../jsp_scripts/header_nav.jsp"/>
	<div id="all_form">
    	<div id="form_title">
        	<h2 align="center" style="font-size:24px;">Αλλαγή Στοιχείων</h2>
        </div>

        <div id="main_form">
        	<form method="post" action="change_info_process.jsp">
            	<p style="font-size:20px;">Όνομα</p>
            	<hr>
				<input type="text" id="onoma" name="onoma" required/>
                <br>
                <br>
                <p style="font-size:20px;"><label>Επίθετο</label></p>
                <hr>
				<input type="text" id="epitheto" name="epitheto" required/>
                <br/>
                <br>
                <p style="font-size:20px;"><label>e-mail</label></p>
                <hr>
				<input type="email" id="taxudromio" name="taxudromio"  required/>
                <br/>
                <br>
                <p style="font-size:20px;"><label>Τηλέφωνο</label></p>
                <hr>
				<input type="number" id="thl" name="thl" required />
				<br/>
				<br>
                <p style="font-size:20px;"><label>Χώρα</label></p>
                <hr>
				<input type="text" id="country" name="country" required />
				<br/>
				<br>
                <p style="font-size:20px;"><label>Πόλη</label></p>
                <hr>
				<input type="text" id="city" name="city" required />
                <br/>
                <br>
                <p style="font-size:20px;"><label>Διεύθυνση</label></p>
                <hr>
				<input type="text" id="address" name="address" required />
                <br/>
                <br>
                <p style="font-size:20px;"><label>T.K</label></p>
                <hr>
				<input type="number" id="tk" name="tk" required />
                <br/>
                <br>
                <p style="font-size:20px;"><label>Α.Φ.Μ</label></p>
                <hr>
				<input type="number" id="afm" name="afm" required />
                <br/>
                <br>
                <input TYPE="submit" name="upload" id="sub_button" title="Add data to the Database" value="Αλλαγή Στοιχείων"/>
                <input type="button" onclick="history.go(-1);" value="Άκυρο">
            </form>
       </div>
    </div>




    <script type="text/javascript">

			rescuefieldvalues(['onoma', 'epitheto', 'taxudromio', 'thl', 'country', 'city', 'address', 'tk', 'afm']);

	</script>

<jsp:include page="../../jsp_scripts/footer.jsp"/>



</body>
</html>