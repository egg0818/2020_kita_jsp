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
	String msg = "";
	String err = request.getParameter("err");
	if(err!=null) {
		switch(err) {
		case "10":
			msg = "등록할 수 없습니다";
			break;
		case "20":
			msg = "DB 에러 발생";
			break;
		}
	}
%>
<%
	String strI_board = request.getParameter("i_board");
	int i_board = Integer.parseInt(strI_board);
	
	BoardVO vo = new BoardVO();

	Connection con = null; 
	PreparedStatement ps = null; 
	ResultSet rs = null; 
	
	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board);
		rs = ps.executeQuery(); 
		
		if(rs.next()) {
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			
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
<title>글수정</title>
<style>
	#msg {
	color:red;
	}
</style>
</head>
<body>
	<div id="msg"><%= msg %></div>
	<div>
		<form id="frm" action="/jsp/boardModProc.jsp?i_board=<%=i_board%>"method="post" onsubmit="return chk()">
		<!-- return false만 유일하게 안날라가게 할수있음 -->
			<div><label>제목: <input type="text" name="title" value="<%=vo.getTitle() %>"></label></div>
			<div><label>내용: <textarea name="ctnt"><%=vo.getCtnt() %> </textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student" value="<%=vo.getI_student() %>"></label></div>
			<div><input type="submit" value="글수정"></div>
			<div><input type="reset" value="리셋"></div>
			<!--   <input type="hidden" name="i_board" value="<%/*i_board*/%>"> -->
		</form>
		<div><a href="/jsp/boardlist.jsp">글목록</a></div>
	</div>
	<script>
	function eleValid(ele, nm) {
		if(ele.value.length == 0) {
			alert(nm + '을(를) 입력해 주세요.')
			ele.focus()
			return true
		}
	}
	function chk() {
		if(eleValid(frm.title, '제목')) {
			return false
		} else if(eleValid(frm.ctnt, '내용')) {
			return false
		} else if(eleValid(frm.i_student, '작성자')) {
			return false
		}
	}
	</script>
</body>
</html>