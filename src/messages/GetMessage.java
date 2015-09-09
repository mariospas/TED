package messages;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		String recipient, subject, message;
		boolean delivered;
		
		recipient = request.getParameter("recipient");
		subject = request.getParameter("subject");
		message = request.getParameter("message");
		
		ManageMessage msg = new ManageMessage(recipient, subject, message);
		
		delivered = msg.deliver();
		if (delivered) {
			System.out.println("GetMessage delivered");
		}
		else {
			System.out.println("GetMessage error");
		}
	}

}
