<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>New Message</title>
	</head>
	<body>
		<h4>New Message</h4>
		<form name="message" action="../getmessage" method="post">
			To <input type="text" name="recipient"><br>
			Subject <input type="text" name="subject"><br><br>
		  Description<br>
		  <input type="text" name="message" style="height:100px;width:300px"><br>
		  <input type="submit" value="Send">
		</form>
	</body>
</html>