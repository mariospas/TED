<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="check_uti.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*" %>
<%@page import="java.sql.ResultSet"%>
<%
	Category cat1 = new Category();
	ResultSet set1 = cat1.get_categories();
%>
	<header>
			<p align="right" style="margin:0 20px 0 0;"><a href="auction/live_auctions.jsp">ΔΙΑΧΕΙΡΙΣΗ ΔΗΜΟΠΡΑΣΙΩΝ</a>
			&nbsp;&nbsp;&nbsp;<a href="/TED/logout_process.jsp">ΑΠΟΣΥΝΔΕΣΗ</a>
            &nbsp;&nbsp;&nbsp;<a href="/TED/after_login/profile_page.jsp">ΠΡΟΦΙΛ</a></p>

            <div class="toggleMobile">
                <span class="menu1"></span>
                <span class="menu2"></span>
                <span class="menu3"></span>
            </div>
            <div id="mobileMenu">
                <ul>
                    <li><a href="javascript:void(0)">Αρχικη Σελιδα</a></li>
                    <li><a href="javascript:void(0)">Κατηγοριες</a></li>
                    <li><a href="javascript:void(0)">Γενικα</a></li>
                    <li><a href="javascript:void(0)">Επικοινωνια</a></li>
               </ul>
            </div>
            <h1>Lingulo HTML5</h1>
            <p>A responsive website tutorial</p>

            <div id="wrapper">
            <nav id="nav">
                <ul id="navigation">
                    <li><a href="javascript:void(0)">ΑΡΧΙΚΗ ΣΕΛΙΔΑ</a></li>
                    <li><a href="#">ΚΑΤΗΓΟΡΙΕΣ</a>
                        <ul>
                        	<table width="500">
                        	<%
	                          int w=0;
	                          while(set1.next())
	                          {
	                        	  if(w==5)
	                        	  {
	                        		  w=0;
	                        		  out.print("</tr>");
	                        	  }
	                        	  if(w==0) out.print("<tr>");
	                          %>
	                            <td><li><a href="#"><%out.print(set1.getString("value"));%></a></li></td>
							  <%
								w++;
								} %>
                            </table>
                        </ul>
                    </li>
                    <li><a href="javascript:void(0)">ΓΕΝΙΚΑ</a></li>
                    <li><a href="javascript:void(0)">ΕΠΙΚΟΙΝΩΝΙΑ</a></li>
                </ul>
            </nav>
            </div>
       </header>