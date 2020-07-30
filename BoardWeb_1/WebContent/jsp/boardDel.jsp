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
	String strI_board = request.getParameter("i_board");
	
	int i_board = Integer.parseInt(strI_board);
	
	Connection con = null; 
	PreparedStatement ps = null; 
	
	String sql = " DELETE FROM t_board WHERE i_board = ? ";
	
	String message ="";
	
	int result = -1; 
	// -1 이 나오면 에러!
	// 0이 나오면 실행했다 하지만 삭제 x
	// 1이 나오면 삭제 o
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board); 
		result = ps.executeUpdate();
		// 데이터를 지우고 나서 삭제한 갯수를 dn에 저장
	} catch(Exception e) {
		e.printStackTrace();
		
	} finally { 
		if(ps != null) { try{ ps.close(); } catch(Exception e) {} }
		if(con != null) { try{ con.close(); } catch(Exception e) {} }
	}
	
	System.out.println("result : " + result);
	
	switch(result) {
	case -1:
		response.sendRedirect("/jsp/boardlist.jsp?err=-1&i_board=" + i_board);
		break;
	case 0:
		response.sendRedirect("/jsp/boardlist.jsp?err=0&i_board=" + i_board);
		break;
	case 1:
		response.sendRedirect("/jsp/boardlist.jsp");
		break;
	}
%>
<!--  위에거 에러 뜨는건 가끔 일어나는 현상 - 버그현상 (이클립스 껐다키면됨)
* 자바에서 DB로 날릴땐 auto commit이 기본임!!
-->

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>페이지 삭제</title>
	</head>
	<body>
	<div>
	<a href="/jsp/boardlist.jsp">리스트로 가기</a>
	</div>
	<div>
		<%= result %>
	</div>
	</body>
</html>