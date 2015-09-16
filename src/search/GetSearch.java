package search;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetSearch
 */
@WebServlet("/getsearch")
public class GetSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		int page = 1;
		int category = 0;
		int minPrice = -100;
		int maxPrice = 10000;
        int recordsPerPage = 8;
        String country = "";
        ResultSet result = null;

        if (request.getParameter("country") != null) {
        	country = request.getParameter("country");
        }

        //PROBLEM WITH MIN/MAX PRICE
        if (request.getParameter("min") != null) {
        	minPrice = Integer.parseInt(request.getParameter("min"));
        	System.out.println("INSIDE THE PARAM MIN " +minPrice);
        }

        if (request.getParameter("max") != null) {
        	maxPrice = Integer.parseInt(request.getParameter("max"));
        	System.out.println("INSIDE THE PARAM MIN " +maxPrice);
        }

		if(request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page"));
		//Maybe an if statement
		request.setAttribute("match", 0);

		String search = request.getParameter("text");
		String categ = request.getParameter("category");
		category = Integer.parseInt(categ);
		System.out.println(category);

		System.out.println("OOOOOOOOKKKKKK");

		FindItem items = new FindItem();
		if (category != 0) {
			result = items.LikeItem(search, category, (page-1)*recordsPerPage, recordsPerPage, country, minPrice, maxPrice);
			try {
			  if (!result.isBeforeFirst() ) {
			    System.out.println("Item not found in normal search");
				result = items.matchItem(search, category, (page-1)*recordsPerPage, recordsPerPage);
				request.setAttribute("match", 1);
			  }
			} catch (SQLException e) {
			    e.printStackTrace(); }
		} else {
			result = items.LikeItem(search, (page-1)*recordsPerPage, recordsPerPage, country, minPrice, maxPrice);
			try {
			  if (!result.isBeforeFirst() ) {
			    System.out.println("Item not found in normal search");
				result = items.matchItem(search, (page-1)*recordsPerPage, recordsPerPage);
				request.setAttribute("match", 1);
			  }
			} catch (SQLException e) {
			    e.printStackTrace(); }
		}

		int noOfRecords = items.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

        request.setAttribute("items", result);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("min", minPrice);
        request.setAttribute("max", maxPrice);
        request.setAttribute("country", country);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/search/searchresults.jsp");
		dispatcher.forward(request,response);
	}

}