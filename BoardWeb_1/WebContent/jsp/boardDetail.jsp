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
	Connection con = null; 
	PreparedStatement ps = null; 
	ResultSet rs = null; 
	BoardVO vo = new BoardVO();
	//try 에 넣으면 안되는 이유 : 만약 에러가 뜨면 null이라도 떠야하는데 객체가 없으면 안된다!
	
	String strI_board = request.getParameter("i_board");
	// request.getParameter : key값을 적어주면 value 값이 넘어옴
	// ? 뒤에 있는 것
	// request는 내장객체
	String nm = "";
	String sql = "SELECT A.title, A.ctnt, A.i_student, B.nm FROM t_board A INNER JOIN t_student B ON A.i_student = B.i_student WHERE i_board = " + strI_board;
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql); 
		rs = ps.executeQuery(); 
		
		if(rs.next()) {
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			nm = rs.getNString("nm");
			
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
	 }
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) { try{ rs.close(); } catch(Exception e) {} }
		if(ps != null) { try{ ps.close(); } catch(Exception e) {} }
		if(con != null) { try{ con.close(); } catch(Exception e) {} }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<style>
</style>
</head>
<body>
 <div class="container">

	<%= vo.getTitle() %>
	<%= vo.getI_student() %>
	<%= vo.getCtnt() %>
	<%= nm%>
</div>
</body>
</html>