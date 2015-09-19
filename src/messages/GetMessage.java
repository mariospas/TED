package messages;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import login_logout_process.*;

/**
 * Servlet implementation class GetMessage
 */
@WebServlet("/getmessage")
public class GetMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String recipient, message;
		boolean delivered;



		recipient = request.getParameter("recipient");
		message = request.getParameter("message");
		String username = request.getParameter("username");

		ManageMessage msg = new ManageMessage(recipient, message, username);

		delivered = msg.deliver();
		if (delivered) {
			System.out.println("GetMessage delivered");
		}
		else {
			System.out.println("GetMessage error");
		}

		/*RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/messages/newInbox.jsp?user="+request.getParameter("recipient"));
		dispatcher.forward(request,response);*/

		String site2 = new String("/TED/messages/newInbox.jsp?user="+request.getParameter("recipient"));
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site2);
	}

}
