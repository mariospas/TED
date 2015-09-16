<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>General HomePage</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_create_item.css" type="text/css" media="screen" />
        <link href="/TED/appearance/css/lightbox.css" rel="stylesheet" />
        <link href="/TED/appearance/css/acordeon.css" rel='stylesheet' type='text/css' />
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
		int bids = auction.num_of_bids(item_id);

		if(bids == 0)
		{
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
			        	<h2 align="center" style="font-size:24px;">Επεξεργασία Δημοπρασίας!</h2>
			        </div>

			        <div id="main_form">
			        	<form method="post" action="save_auction.jsp" ENCTYPE="multipart/form-data" >
			            	<p><label>Όνομα :</label></p>
			            	<hr>
							<input type="text" id="name" name="name" value="<%out.print(item_set.getString("name"));%>" required/>
			                <br/>
			                <p><label>Κατηγορίες :</label></p>
			                <hr>
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
			                <p><label>Αρχική Προσφορά :</label></p>
			                <hr>
			           		<input type="text" id="first_bid" name="first_bid" value="<%out.print(item_set.getString("first_bid"));%>" required/>
			                <br/>
			                <p><label>*Τιμή Αγοράς :</label></p>
			                <hr>
							<input type="text" id="buy_price" name="buy_price" value="<%out.print(item_set.getString("buy_price"));%>" />
			                <br/>
			                <p><label>Location : (latitude;longtitude e.g 2.458;3.589)</label></p>
			                <hr>
							<input type="text" id="latlong" name="latlong" value="<%out.print(item_set.getString("location"));%>" required/>
			                <br/>
			                <p><label>Χώρα :</label></p>
			                <hr>
							<input type="text" id="country" name="country" value="<%out.print(item_set.getString("country"));%>" required/>
			                <br/>
			                <p><label>Ημερομηνία Έναρξης :</label></p>
			                <hr>
							<input type="date" id="start_date" name="start_date" value="<%out.print(item_set.getString("start_date"));%>" required />
							<br/>
			                <p><label>Ημερομηνία Τερματισμού : </label></p>
			                <hr>
							<input type="date" id="end_date" name="end_date" value="<%out.print(item_set.getString("end_date"));%>" required />
							<br/>
			                <p><label>* Φωτογραφία :</label></p>
			                <hr>
			                <input type="hidden" name="size" value="1048576">
			                <input type="file" name="photo" id="i_file" value="<%out.print(item_set.getString("photo_url"));%>">
			                </br>
			                <p><label>Περιγραφή  :</label></p>
			                <hr>
							<input type="text" id="description" name="description" style="width: 98%; height: 300px;" value="<%out.print(item_set.getString("description"));%>" required />
			                <br/>
			                <br/>
			                <input TYPE="submit" name="sub_button" id="sub_button" title="Add data to the Database" value="Αποθήκευση Επεξεργασίας"/>
			            </form>
						<form method="post" action="edit_auction.jsp">
				            <p align="center"><input type="radio" name="item" value="<%out.print(item_set.getLong("item_id"));%>" id="item">Συμφωνώ να διαγραφή το προϊόν</p>
							<input TYPE="submit" name="sub" id="sub" class="sub_del" value="Διαγραφή"/>
							<br/>
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
		}
		else if(bids > 0)
		{
			Category cat = new Category();
			ResultSet set = cat.get_categories();
			ResultSet item_set = auction.requested_item(item_id);
			ResultSet item_cat = cat.get_item_categories(item_id);
			while (item_set.next())
			{
%>

			    	<div id="form_title">
			        	<h2 align="center" style="font-size:24px;">Επισκόπηση Δημοπρασίας!</h2>
			        </div>

			        <div id="box_item">

			        <section id="image_product">
			        	<img src="<%out.print(item_set.getString("photo_url"));%>" width="300" height="450">

			        </section>

			        <section id="specs">

			        		<p style="font-variant:small-caps; font-family: 'Open Sans', sans-serif;"><label><%out.print(item_set.getString("name"));%>" </label></p>
			                <br/>
			                <p><label>Κατηγορίες :
						        <%
						        while (set.next())
								{
						        	item_cat.beforeFirst();
						        	while (item_cat.next())
									{

						        		if(set.getInt("category_id") == item_cat.getInt("category_id"))
						        		{
						        			out.print(set.getString("value")+", ");
						        		}

									}

						         }
						        %>
						   	</label></p>
							<br/>
			                <p><label>Αρχική Προσφορά : <%out.print(item_set.getString("first_bid"));%></label></p>
			                <br/>
			                <p><label>*Τιμή Αγοράς : <%out.print(item_set.getString("buy_price"));%></label></p>
							<br/>
			                <p><label>Location : <%out.print(item_set.getString("location"));%></label></p>
			                <br/>
			                <p><label>Χώρα : <%out.print(item_set.getString("country"));%></label></p>
			                <br/>
			                <p><label>Ημερομηνία Έναρξης : <%out.print(item_set.getString("start_date"));%></label></p>
							<br/>
			                <p><label>Ημερομηνία Τερματισμού : <%out.print(item_set.getString("end_date"));%></label>
							<br/>

			        </section>

					<div class="container2">
			          <div class="accordion">
			            <dl>
			              <dt>
			                <a href="#accordion1" aria-expanded="false" aria-controls="accordion1" class="accordion-title accordionTitle js-accordionTrigger">Περιγραφή</a>
			              </dt>
			              <dd class="accordion-content accordionItem is-collapsed" id="accordion1" aria-hidden="true">
			                <p><%out.print(item_set.getString("description"));%></p>
			              </dd>
			              <dt>
			                <a href="#accordion2" aria-expanded="false" aria-controls="accordion2" class="accordion-title accordionTitle js-accordionTrigger">
			                  Προσφορές</a>
			              </dt>
			              <dd class="accordion-content accordionItem is-collapsed" id="accordion2" aria-hidden="true">
			                <%
			                ResultSet bid_set = auction.bids(item_id);
			                int z=1;
			                while (bid_set.next())
							{
			                %>
				                <article>
					                <h3>Προσφορα No<%out.print(z); %></h3>
					                  <p>Όνομα Χρήστη : <%out.print(bid_set.getString("username"));%></p>
									  <p>Τιμή Προσφοράς : <%out.print(bid_set.getFloat("price"));%></p>
									  <p>Ημερομηνία Προσφοράς : <%out.print(bid_set.getString("date_time"));%></p>
					            </article>

				            <%
				            z++;
							}
							%>
			              </dd>
			            </dl>
			          </div>
			        </div>


			       </div>

<%
			}
		}

	}
	else
	{
		out.println("<center><h1> Guest Mode Permission Denied</h1></center>");
	}
%>

<jsp:include page="../../jsp_scripts/footer.jsp"/>

<script>

		//uses classList, setAttribute, and querySelectorAll
//if you want this to work in IE8/9 youll need to polyfill these
(function(){
	var d = document,
	accordionToggles = d.querySelectorAll('.js-accordionTrigger'),
	setAria,
	setAccordionAria,
	switchAccordion,
  touchSupported = ('ontouchstart' in window),
  pointerSupported = ('pointerdown' in window);

  skipClickDelay = function(e){
    e.preventDefault();
    e.target.click();
  }

		setAriaAttr = function(el, ariaType, newProperty){
		el.setAttribute(ariaType, newProperty);
	};
	setAccordionAria = function(el1, el2, expanded){
		switch(expanded) {
      case "true":
      	setAriaAttr(el1, 'aria-expanded', 'true');
      	setAriaAttr(el2, 'aria-hidden', 'false');
      	break;
      case "false":
      	setAriaAttr(el1, 'aria-expanded', 'false');
      	setAriaAttr(el2, 'aria-hidden', 'true');
      	break;
      default:
				break;
		}
	};
//function
switchAccordion = function(e) {
	e.preventDefault();
	var thisAnswer = e.target.parentNode.nextElementSibling;
	var thisQuestion = e.target;
	if(thisAnswer.classList.contains('is-collapsed')) {
		setAccordionAria(thisQuestion, thisAnswer, 'true');
	} else {
		setAccordionAria(thisQuestion, thisAnswer, 'false');
	}
  	thisQuestion.classList.toggle('is-collapsed');
  	thisQuestion.classList.toggle('is-expanded');
		thisAnswer.classList.toggle('is-collapsed');
		thisAnswer.classList.toggle('is-expanded');

  	thisAnswer.classList.toggle('animateIn');
	};
	for (var i=0,len=accordionToggles.length; i<len; i++) {
		if(touchSupported) {
      accordionToggles[i].addEventListener('touchstart', skipClickDelay, false);
    }
    if(pointerSupported){
      accordionToggles[i].addEventListener('pointerdown', skipClickDelay, false);
    }
    accordionToggles[i].addEventListener('click', switchAccordion, false);
  }
})();

</script>


</body>
</html>