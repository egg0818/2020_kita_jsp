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
//객체의 주솟값.메소드
String ctnt = request.getParameter("ctnt");
String strI_student = request.getParameter("i_student");

if("".equals(title) || "".equals(ctnt) || "".equals(strI_student)) {
	response.sendRedirect("/jsp/boardWrite.jsp?err=10");
	return;
}

int i_student = Integer.parseInt(strI_student);
// 문자열이 있으면 문자가 하나라도 있으면 에러터짐

Connection con = null; 
PreparedStatement ps = null; 
//resultset 필요없다. resultset은 많은 양(자료)을 가져올 때 주로 씀


String sql = " insert into t_board (i_board, title, ctnt, i_student) "
			+ " SELECT nvl(max(i_board), 0) + 1, ?, ?, ? "
			+ " FROM t_board";

int result = -1;

try {
	con = getCon();
	ps = con.prepareStatement(sql);
	ps.setNString(1, title);
	ps.setNString(2, ctnt);
	ps.setInt(3, i_student);
	result = ps.executeUpdate();
	// 내가 영향을 미친 row(행) 갯수가 나옴
} catch(Exception e) {
	e.printStackTrace();
} finally { 
	if(ps != null) { try{ ps.close(); } catch(Exception e) {} }
	if(con != null) { try{ con.close(); } catch(Exception e) {} }
}

System.out.println("result : " + result);

int err = 0;
switch(result) {
case 1:
	response.sendRedirect("/jsp/boardlist.jsp");
	return;
case 0:
	err = 10;
	break;
case -1:
	err = 20;
	break;
}
response.sendRedirect("/jsp/boardWrite.jsp?err=" + err);
%>
<div>title : <%=title %></div>
<div>ctnt : <%=ctnt %></div>
<div>i_student : <%=i_student %></div>