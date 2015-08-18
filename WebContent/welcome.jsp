<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WELCOME</title>
</head>
<body>
		<form method="post" action="process.jsp">
            <center>
                <h1 style="color:blue">Welcome To Demo Web-Page</h1>
                <b style="color:blue">Login Here</b><br>
                <table border="1" width="2" bgcolor="khaki" style="color:red">
                    <tr><td><b>UserName</b></td> <td><input type="text" name="uname"></td></tr>
                    <tr><td><b>Password</b></td> <td><INPUT type="password" name="upass"></td></tr>
                    <tr><td><input type="submit" value="Login"></td>
                        <td><input type="reset" value="Reset"></td>
                </table>
            </center>
        </form>
        <p align="center"><b><a href="after_login/general_homepage.jsp">Επισκέπτης</a></b></p>
        <p align="center"><b><a href="registration.jsp">Εγραφή</a></b></p>

</body>
</html>