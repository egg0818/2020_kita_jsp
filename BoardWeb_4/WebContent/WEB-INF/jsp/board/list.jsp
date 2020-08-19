<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.pjt.vo.BoardVO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
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
	<div>${loginUser.nm}님 환영합니다</div>
	<div>
		<a href="regmod">글쓰기</a>
	</div>
	<h1>리스트</h1>
	<table>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일시</th>
	</tr>
		<c:forEach items="${list}" var="item">
		<tr>
			<td>${item.i_board} </td>
			<td>${item.title} </td>
			<td>${item.i_user} </td>
			<td>${item.hits} </td>
			<td>${item.r_dt} </td>
		</tr>
		</c:forEach>
	</table>
	<script>
	
	</script>
</body>
</html>