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
.container {
	margin: 0 auto;
	width: 1000px;
	text-align: center;
}
.itemRow:hover {
	background-color: rgb(120, 180, 180);
	cursor: pointer;
}
#cmtcnt {
	font-size : 12px;
}
table {
	border: 2px solid black;
	border-collapse: collapse;
	width: 1000px;
}
table td, th {
	border: 2px solid black;
	padding: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<a href="/logout">로그아웃</a><br><br>
		<div>${loginUser.nm}님 환영합니다</div>
		<br>
		<div>
			<a href="/board/regmod">글쓰기</a>
		</div>
		<h1>리스트</h1>
		<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일시</th>
			<th>좋아요</th>
		</tr>
			<c:forEach items="${list}" var="item">
			<tr class="itemRow" onclick="moveToDetail(${item.i_board})">
				<td>${item.i_board} </td>
				<td>${item.title}
				<span id="cmtcnt">
				<c:choose>
					<c:when test="${item.cmtcnt eq 0}">
	  				</c:when>
	  				<c:otherwise>
	      				(${item.cmtcnt})
	    			</c:otherwise>
				</c:choose>
				</span>
				</td>
				<td>${item.nm} </td>
				<td>${item.hits} </td>
				<td>${item.r_dt} </td>
				<td>${item.likecnt} </td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<script>
	function moveToDetail(i_board) {
		//console.log('moveToDetail - i_board : ' + i_board)
		location.href = 'detail?i_board=' + i_board
	}
	</script>
</body>
</html>