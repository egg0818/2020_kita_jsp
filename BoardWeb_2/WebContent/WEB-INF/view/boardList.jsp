<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.board.vo.BoardVO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	@SuppressWarnings("unchecked")
	List<BoardVO> list = (List<BoardVO>)request.getAttribute("data");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
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
	<tr>
		<td><%=vo.getI_board() %></td>
		<td><%=vo.getTitle() %></td>
		<td><%=vo.getI_student() %></td>
	</tr>
		<% } %>
	</table>
</body>
</html>