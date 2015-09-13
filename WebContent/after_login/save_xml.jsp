<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login_logout_process.*"%>
<%@ page import="xml_mars_unmars.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.lang.Object.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	LoginSession log = (LoginSession) session.getAttribute("log");
	if(log == null || !(log.getType().equals("admin")) )
	{
		out.println("<center><h1>Permission Denied</h1>");
	}
	else
	{
		request.setCharacterEncoding("UTF-8");
		String xml = null;

		List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		for (FileItem item : items)
		{
		    if (item.isFormField())
		    {
		        // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
		    }
		    else
		    {
		        // Process form file field (input type="file").
		        String fieldname = item.getFieldName();
		        String filename = FilenameUtils.getName(item.getName());
		        if(filename.length()>0)
		        {
			        InputStream filecontent = item.getInputStream();

			        byte[] buffer = new byte[filecontent.available()];
			        filecontent.read(buffer);

			        String current = getServletContext().getRealPath(File.separator);
			        File dir = new File(current+"XML_IMPORT");
			        dir.mkdir();
			        dir = new File(current+"XML_IMPORT"+File.separator+"users");
			        dir.mkdir();
			        dir = new File(current+"XML_IMPORT"+File.separator+"users"+File.separator+log.getName());
			        dir.mkdir();
			        current += "XML_IMPORT"+File.separator+"users"+File.separator+log.getName()+File.separator;
			        String url = new String("XML_IMPORT"+File.separator+"users"+File.separator+log.getName()+File.separator);
				    File targetFile = new File(current+filename);
				    OutputStream outStream = new FileOutputStream(targetFile);
				    outStream.write(buffer);

				    xml = current+filename;

				    Item itemXML = new Item(xml);




				    String site = new String("admin_page.jsp");
					response.setStatus(response.SC_MOVED_TEMPORARILY);
					response.setHeader("Location", site);
		        }
		    }
		}
	}
%>

</body>
</html>