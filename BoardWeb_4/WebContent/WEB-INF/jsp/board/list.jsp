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
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<style>
.container {
	margin: 50px auto;
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
	border-top: 2px solid rgb(190, 190, 190);
	border-bottom: 2px solid rgb(190, 190, 190);
	border-collapse: collapse;
	width: 1000px;
}
table td, th {
	border-top: 2px solid rgb(190, 190, 190);
	border-bottom: 2px solid rgb(190, 190, 190);
	padding: 10px;
}
.title {
	color : rgb(120, 180, 180);
	float : left;
	margin : 30px;
}
.material-icons {
	color: red;
}
.welcome {
	position : relative;
	right : 430px;
}
.button-write {
	position : relative;
	top : 45px;
	left : 380px;
}
.button-write button {
	background-color: rgb(120, 180, 180);
	width: 80px;
	height: 30px;
	color: white;
	border: none;
}
.button-write button:hover {
	cursor: pointer;
}
.logout {
	position : relative;
	right : 200px;
	color: black;
}
.logout button {
	width: 70px;
	height: 25px;
}
.page_div {
	margin : 20px;
}
.page_div a {
	color: black;
	text-decoration: none;
}
.nowpage {
	color: red;
}
</style>
</head>
<body>
	<div class="container">
		<span class=logout><a href="/logout"><button>로그아웃</button></a></span>
		<span class=welcome><strong>${loginUser.nm}</strong>님 환영합니다</span>
		<br>
		<span class="button-write">
		<a href="/board/regmod"><button>글쓰기</button></a>
		</span>
		<h1 class="title">게시판</h1>
		<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일시</th>
			<td><span class="material-icons">favorite</span></td>
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
		<div class="page_div">
			<c:forEach var="item" begin="1" end="${pagingCnt}">
				<c:choose>
					<c:when test="${nowPage == item}">
						<span class="nowpage"><strong>${item}</strong></span>
					</c:when>
					<c:otherwise>
	      				<span><a href="/board/list?page=${item}">${item}</a></span>
	    			</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
	<script>
	function moveToDetail(i_board) {
		//console.log('moveToDetail - i_board : ' + i_board)
		location.href = 'detail?i_board=' + i_board
	}
	</script>
</body>
</html>