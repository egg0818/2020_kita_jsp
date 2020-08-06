<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.board.vo.BoardVO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
// 테스트용 String strI_board = request.getParameter("i_board");
	@SuppressWarnings("unchecked")
	
		List<BoardVO> list = (List<BoardVO>)request.getAttribute("data");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
.itemRow:hover {
	background-color: yellow;
	cursor: pointer;
}
</style>
</head>
<body>
	<div>게시판 리스트</div>
	<div>
		<a href="/boardWrite.jsp"><button>글쓰기</button></a>
	</div>
	<table>
	<tr>
		<th>No</th>
		<th>제목</th>
		<th>작성자</th>	
	</tr>
	<% for(BoardVO vo : list) { %>
	<tr class="itemRow" onclick="moveToDetail(<%=vo.getI_board() %>)">
		<td><%=vo.getI_board() %></td>
		<td><%=vo.getTitle() %></td>
		<td><%=vo.getI_student() %></td>
	</tr>
		<% } %>
	</table>
	<script>
		function moveToDetail(i_board) {
			//console.log('moveToDetail - i_board : ' + i_board)
			location.href = 'boardDetail?i_board=' + i_board
		}
	</script>
</body>
</html>