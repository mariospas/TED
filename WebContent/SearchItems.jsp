<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Search Items</title>
	</head>
	<body>
		<center><h4>Item Search</h4></center>
		
		<form name="search" action="getsearch" method="get">
			<center>
				<select name="category">
					<option value="0">All</option>
				  <option value="1">Computers</option>
				  <option value="2">House</option>
				  <option value="3">Bikes</option>
				</select>
				<input type="text" name="text">
				<input type="submit" value="Search">
			</center>
		</form>
		
		<center>Choose Category: <br>
		<a href="">Computers</a>
		<a href="">House</a> <br>
		<a href="">Services</a>
		<a href="">Bikes</a></center>
	</body>
</html>