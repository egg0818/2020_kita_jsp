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
#cmtcnt {
	font-size : 12px;
}
</style>
</head>
<body>
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
	<script>
	function moveToDetail(i_board) {
		//console.log('moveToDetail - i_board : ' + i_board)
		location.href = 'detail?i_board=' + i_board
	}
	
	item.cmtcnt
	var dd = document.querySelector("#cmtcnt").value;

	
	</script>
</body>
</html>