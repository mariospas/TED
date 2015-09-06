package login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import login.LoginService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userID, password;
		int x;
		
		userID = request.getParameter("userID");
		password = request.getParameter("password");
		
		LoginService loginservice = new LoginService(userID, password);
		
		//if (loginservice.authenticate(password)) {
			x = loginservice.getUser();
			
			if (x == 1) {
				request.getSession().setAttribute("userID", userID);
				response.sendRedirect("success.jsp");
				return;
			} else {
				response.sendRedirect("fail.jsp");
				return;
			}
		//}
		
		// If the connection is fine and the user is found
		// proceed to whatever is needed
		// else ask again
	}

}
