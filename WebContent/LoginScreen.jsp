<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Login Page</title>
	</head>
	<body>
		<h3>Welcome</h3>
			
		<form action="LoginServlet" method="post">
		User ID: <input type="text" name="userID" />
		<br>Password: <input type="password" name="password" />
		<br><input type="submit" value="Submit" />
		</form>
	</body>
</html>