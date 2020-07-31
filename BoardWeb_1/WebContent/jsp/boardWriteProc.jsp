<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.web.BoardVO" %>
    <%!
	public Connection getCon() throws Exception {
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String username = "hr";
	String password = "koreait2020";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection(url, username, password);
	System.out.println("접속 성공");
	return con;
	}
%>
<%
String title = request.getParameter("title");
String ctnt = request.getParameter("ctnt");
String strI_student = request.getParameter("i_student");

Connection con = null; 
PreparedStatement ps = null; 


String sql = " insert into t_board (i_board, title, ctnt, i_student) "
			+ " SELECT nvl(max(i_board), 0) + 1,?,?,? "
			+ " FROM t_board";

int result = -1;

try {
	con = getCon();
	ps = con.prepareStatement(sql);
	ps.setString(1, title);
	ps.setString(2, ctnt);
	ps.setString(3, strI_student);
	result = ps.executeUpdate();
} catch(Exception e) {
	e.printStackTrace();
} finally { 
	if(ps != null) { try{ ps.close(); } catch(Exception e) {} }
	if(con != null) { try{ con.close(); } catch(Exception e) {} }
}

switch(result) {
case -1:
	response.sendRedirect("/jsp/boardWrite.jsp");
	break;
case 0:
	response.sendRedirect("/jsp/boardWrite.jsp");
	break;
case 1:
	response.sendRedirect("/jsp/boardlist.jsp");
	break;
}
%>

<div>title : <%=title %></div>
<div>ctnt : <%=ctnt %></div>
<div>i_student : <%=strI_student %></div>