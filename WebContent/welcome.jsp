<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Welcome Page</title>
        <link rel="stylesheet" href="/TED/appearance/css/reset.css" type="text/css" media="screen" />
        <link rel="stylesheet" href="/TED/appearance/css/style_welcome.css" type="text/css" media="screen" />
        <link href="/TED/appearance/css/lightbox.css" rel="stylesheet" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans|Baumans' rel='stylesheet' type='text/css'/>
        <script src="/TED/appearance/scripts/modernizr.custom.04512.js"></script>
        <script src="/TED/appearance/scripts/respond.js"></script>

        <!-- include extern jQuery file but fall back to local file if extern one fails to load !-->
        <script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">window.jQuery || document.write('<script type="text\/javascript" src="js\/1.7.2.jquery.min"><\/script>')</script>

        <script async src="/TED/appearance/scripts/lightbox.js"></script>
        <script src="/TED/appearance/scripts/prefixfree.min.js"></script>
        <script src="/TED/appearance/scripts/jquery.slides.min.js"></script>

<title>Καλώς Ήρθατε</title>
</head>
<body>
		<body>
        <section class="container">
            <section class="insidebox">
                <form method="post" action="process.jsp" >
                    <h1 align="center">Welcome Page</h1>
                    <p align="center"><b>Σύνδεση Στην Σελίδα</b><br></p>
                    <table width="400px" align="center">
                        <tr><td><b>Όνομα Χρήστη</b></td> <td><input type="text" name="uname"></td></tr>
                        <tr><td><b>Κωδικός</b></td> <td><INPUT type="password" name="upass"></td></tr>
                        <tr><td><input class="button" type="submit" value="Σύνδεση"></td>
                            <td align="center"><input class="button" type="reset" value="Επαναφορά"></td></tr>
                    </table>
                </form>
            <p align="center"><b><a href="after_login/general_homepage.jsp">Επισκέπτης</a></b></p>
            <p align="center"><b><a href="registration.jsp">Εγγραφή</a></b></p>
            </section>
        </section>


     </body>

</body>
</html>