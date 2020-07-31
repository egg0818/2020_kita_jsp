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
//BoardVO 객체 주솟값을 저장 할 수 있는 큰 서랍.

Connection con = null; // Connection 객체 : 자바랑 DB 연결담당!
PreparedStatement ps = null; // 커리문 실행 담당 (+문장완성기능)
ResultSet rs = null; // SELECT 일때 결과를 담는다!! 
//try 와 finally 에서 사용하기위에서 바깥에서 사용한다!!! (스코프 생각)
// scope(스코프): 사용 범위


String sql = " SELECT i_board, title " +
			" FROM t_board ORDER BY i_board ASC"; // board 마지막에 ; 왜안붙임?
							// 붙이면 인덱스 해킹가능해서 애초에 방지!!

try {
	con = getCon(); //연결
	ps = con.prepareStatement(sql); // 나머지는 이거씀 // sql 쿼리문을 받음
	// 위에건 스태틱 메소드가 아니다 클래스명.메소드가 아니니까~
	// 파라미터 타입은 String. sql이 String이기 때문에 
	// 리턴타입 : PreparedStatement
	rs = ps.executeQuery(); //★실수주의!! SELECT 때만 씀 -> 리턴타입이 rs 이기 때문에 무조건!!!!
	// 쿼리문을 실행!
	// 리턴타입 : ResultSet
	// 앞에 '=' 붙었으니 줄게있다! 비void형!
	while(rs.next()) {
	// 첫줄을 가르키고, 레코드가 있다면 true를 리턴!
	// 값이없으면 ? false 리턴하고 while문 끝남
	// 한줄만 가져올 땐 if문 쓰기도 함
	// while if 둘다 조건에는 boolean 타입
		int i_board = rs.getInt("i_board");
		String title = rs.getNString("title");
		
		BoardVO vo = new BoardVO();
		//★★★ 중요함!! 이걸 while문 안에서 만들어여함!
		// while문 밖에서 만들면 마지막 주솟값(같은값) 만나온다
		vo.setI_board(i_board);
		vo.setTitle(title);
		
		boardlist.add(vo);
	}
	// 파싱작업
	// 서랍에 넣는거다!
} catch(Exception e) {
	e.printStackTrace(); // 에러 알려줌! (보통 db관련)
	// try catch 에러 잡는거 중요함. 쌤은 못하지만 니들은 잘해라
} finally {
	if(rs != null) { try{ rs.close(); } catch(Exception e) {} }
	if(ps != null) { try{ ps.close(); } catch(Exception e) {} }
	if(con != null) { try{ con.close(); } catch(Exception e) {} }
}	// 열으면 닫아줘야함. 마지막에 오픈한거부터 닫아줌.
	// 각각 try catch 감싸준 이유 ? 같이 감싸주면 rs가 먼저 닫히면  catch로 바로 가버리기때문에
	// ps랑 con은 close가 안된다
	// 안닫아주면 : 메모리 리소스 때문에 멈춰버림
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<div>
		게시판 리스트
		<a href="/jsp/boardWrite.jsp"><button>글쓰기</button></a>
	</div>
	<table>
	<tr>
		<th>No</th>
		<th>제목</th>		
	</tr>
	<% for(BoardVO vo : boardlist) { %>
	<tr>
		<td><%=vo.getI_board() %></td>
		<td>
			<a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board() %>">
			<%=vo.getTitle() %>
			<!--  // ? : 쿼리스트링
			// 통신할때씀 key(i_board), value값(vo.getI_board())
			// &은 연걸자    // get방식 : 속도 , post방식 : 보안 -->
			</a>
		</td>
	</tr>
		<% } // %= : 출력표현식(out.print~~) // 나중에 자바소스랑 뷰단이랑 다르게 함 %>
	</table>
</body>
</html>