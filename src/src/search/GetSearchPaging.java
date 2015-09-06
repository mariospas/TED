package search;

import java.io.IOException;
import java.sql.ResultSet;
//import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetSearch
 */
@WebServlet("/getsearchpaging")
public class GetSearchPaging extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		int page = 1;
        int recordsPerPage = 2;
        
        if(request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page"));
	
		FindItemPaging paging = new FindItemPaging();
		ResultSet item = paging.Items((page-1)*recordsPerPage, recordsPerPage);
		int noOfRecords = paging.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
        request.setAttribute("items", item);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/DisplayItemsPaging.jsp");
		dispatcher.forward(request,response);
	}
}