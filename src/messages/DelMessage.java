package messages;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DelMessage
 */
@WebServlet("/delmessage")
public class DelMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int ID, del;
		ID = Integer.parseInt(request.getParameter("ID"));
		del = Integer.parseInt(request.getParameter("del"));
		
		RetrieveMessages delete = new RetrieveMessages();
		
		if (del == 1) {
			delete.delReceived(ID);
		} else {
			delete.delSent(ID);
		}
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/messages/newInbox.jsp?user="+request.getParameter("user"));
		dispatcher.forward(request,response);
	}

}
