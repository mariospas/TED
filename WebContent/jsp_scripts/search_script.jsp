<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="category.*"%>

<%
	Category cat = new Category();
	ResultSet set = cat.get_categories();
%>

		<section id="spacer2">
			<div class="search" id="slider_content1">
				<form name="search" action="../getsearch" method="get">
						<select name="category">
							<option value="0">Επέλεξε την κατηγορία σου</option>
						   <%
						   int i=0;
				        while (set.next())
						{
				        	i++;
						%>
				            <option value="<%out.print(i);%>" name="<%out.print(set.getString("value"));%>" id="<%out.print(set.getString("value"));%>"><%out.print(set.getString("value"));%></option>
				       <%}
						   %>
						</select>
						&nbsp;<input type="text" name="text">
						<input type="submit" name="start_search" class="button" value="Search"/>
				</form>
			</div>
        </section>
        <section>

	        <div class="search2" id="search2">
				<form name="search" action="../getsearch" method="get">
						<p align="center"><select name="category">
							<option value="0">Επέλεξε την κατηγορία σου</option>
						   <%
						    i=0;
				        while (set.previous())
						{
				        	i++;
						%>
				            <option value="<%out.print(i);%>" name="<%out.print(set.getString("value"));%>" id="<%out.print(set.getString("value"));%>"><%out.print(set.getString("value"));%></option>
				       <%}
						   %>
						</select>
						<input type="text" name="text"></p>
						<p align="center"><input type="submit" name="start_search" class="button" value="Search"/></p>
				</form>
			</div>

        </section>