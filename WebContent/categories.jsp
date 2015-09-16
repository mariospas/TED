<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="category.*" import="java.sql.ResultSet"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Categories</title>
        <link rel="stylesheet" href="appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="appearance/css/stylecat.css" type="text/css" media="screen" />
        <link href="appearance/css/lightbox.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans|Baumans' rel='stylesheet' type='text/css'/>
        <script src="appearance/scripts/modernizr.custom.04512.js"></script>
        <script src="appearance/scripts/respond.js"></script>

        <!-- include extern jQuery file but fall back to local file if extern one fails to load !-->
        <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text\/javascript" src="js\/1.7.2.jquery.min"><\/script>')</script>

        <script async src="appearance/scripts/lightbox.js"></script>
        <script src="appearance/scripts/prefixfree.min.js"></script>
        <script src="appearance/scripts/jquery.slides.min.js"></script>

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
					if($(this).width() > 500)
					{
						$("#mobileMenu").hide();
						$(".toggleMobile").removeClass("active");
					}
				});
			})(jQuery, window, document);
		</script>
        <script>
            $(function(){

                $(".more").toggle(function(){
                    $(this).attr("src","/TED/img/SeeMore.png").siblings(".complete").show();
                }, function(){
                    $(this).attr("src","/TED/img/SeeMore.png").siblings(".complete").hide();
                });
            });
        </script>

    </head>
    <body>
    <jsp:include page="jsp_scripts/header_nav.jsp"/>

        <%
    		Category categ = new Category();
    		ResultSet categnames = categ.get_categories();
            int i=1;
        %>
        <section id="boxcontent">
            <hr class="upperhr"/>
            <h1 align="center">Categories</h1>
            <hr class="lowerhr"/>
            <section id="categories">
                <span class="teaser">
                    <% for (i=1;i<=3;i++) {
                        categnames.next();
                    %>
                        <article>
                            <h3><a href="javascript:void(0)"><%=categnames.getString("value") %></a></h3>
                        </article>
                    <% } %>
                </span>
                <span class="complete">
                    <% while(categnames.next()) { %>
                        <article>
                            <h3><a href="javascript:void(0)"><%=categnames.getString("value") %></a></h3>
                        </article>
                    <% } %>
                </span>
                <span class="more"><img src="/TED/img/SeeMore.png" width="100" height="100"></span>
            </section>
            <br class="clear"/>
        </section>


        <jsp:include page="jsp_scripts/footer.jsp"/>
     </body>

</html>