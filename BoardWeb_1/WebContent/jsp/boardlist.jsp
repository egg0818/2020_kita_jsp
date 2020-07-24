<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.koreait.web.BoardVO" %>

<%!
public Connection getCon() throws Exception {
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String username = "hr";
	String password = "koreait2020";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection(url, username, password);
	// static이 붙은 메소드 객체화가 안 돼있음. 스태틱이 안 붙은 멤버필드를 안쓸때 쓰임
	// DriverManager 대문자로 시작 -> 클래스명이다! 대문자로 시작하는거 싹  다!
	// 역할 : DB 연결. Connection객체를 리턴해줌!
	System.out.println("접속 성공");
	return con;
}
%>

<%
List<BoardVO> boardlist = new ArrayList();

Connection con = null; // Connection 객체 : 자바랑 DB 연결담당!
PreparedStatement ps = null; // 커리문 실행 (+커리문 완성)
ResultSet rs = null; // SELECT 때 결과를 담는다!!
//try 와 finally 에서 사용하기위에서 바깥에서 사용한다!!! (스코프 범위 생각)
// scope(스코프): 사용 범위


String sql = " SELECT i_board, title " +
			" FROM t_board "; // board 마지막에 ; 왜안붙임?
							// 붙이면 인덱스 해킹가능해서 애초에 방지!!

try {
	con = getCon();
	ps = con.prepareStatement(sql); // 나머지는 이거씀
	rs = ps.executeQuery(); //★실수주의!! SELECT 때만 씀 -> 리턴타입이 rs 이기 때문에 무조건!!!!
	
	while(rs.next()) {
	// 첫줄을 가르키고, 레코드가 있다면 true를 리턴!
	// 줄이없다 ? false 리턴하고 while문 끝남
	// 한줄만 가져올 땐 if문 쓰기도 함
		int i_board = rs.getInt("i_board");
		String title = rs.getNString("title");
		
		BoardVO vo = new BoardVO();
		vo.setI_board(i_board);
		vo.setTitle(title);
		
		boardlist.add(vo);
	}
	// 파싱작업
	// 서랍에 넣는거다!
} catch(Exception e) {
	e.printStackTrace(); // 에러 알려줌! (보통 db관련)
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
<title>게시판</title>
</head>
<body>
	<div>게시판 리스트</div>
	<table>
	<tr>
		<th>No</th>
		<th>제목</th>		
	</tr>
	<% for(BoardVO vo : boardlist) { %>
	<tr>
		<td><%=vo.getI_board() %></td>
		<td><%=vo.getTitle() %></td>
	</tr>
		<% } // %= : 출력표현식(out.print~~) // 나중에 자바소스랑 뷰단이랑 다르게 함 %>
		

	</table>
</body>
</html>