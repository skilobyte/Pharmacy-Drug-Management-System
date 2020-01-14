<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
int qt=Integer.parseInt(request.getParameter("restock"));
String prod=request.getParameter("pid");
HttpSession httpSession = request.getSession();
String guid=(String)httpSession.getAttribute("currentuser");
ResultSet rs=null;
Connection conn=null;
PreparedStatement ps=null;
String query="update inventory set quantity=quantity+? where sid=? and pid=?";
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","root");
	ps=conn.prepareStatement(query);
	ps.setInt(1,qt);
	ps.setString(2,guid);
	ps.setString(3,prod);
	int i=ps.executeUpdate();
	response.sendRedirect("AddInventory.jsp");
}
catch(Exception e)
{
	out.println(e);
}
finally {
	try { if (rs != null) rs.close(); } catch (Exception e) {};
	try { if (ps != null) ps.close(); } catch (Exception e) {};
	try { if (conn != null) conn.close(); } catch (Exception e) {};
}

%>

</body>
</html>