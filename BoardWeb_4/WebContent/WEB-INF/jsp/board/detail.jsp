<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<div><button onclick="doDel(${data.i_board})">삭제</button></div>
	<a href="/boardMod?i_board=${data.i_board}"><button>수정</button></a>
	<div>상세 페이지</div>
	<div>글번호 : ${data.i_board}</div>
	<!--  setattribute 있을때만 쓸수 있음. (내장객체 담긴것만 사용가능)
	       	주석에는 $ 쓰지말기!! -->
	<div>제목 : ${data.title}</div>
	<div>내용: ${data.ctnt}</div>
	<div>작성자 : ${data.nm}</div>
	<div>작성일시 : ${data.r_dt}</div>
	<div>조회수 : ${data.hits}</div>
	<script>	
		function doDel(i_board) {
			if(confirm('삭제 하시겠습니까?')) {
				location.href='/board/del?i_board=' + i_board
			}
		}
	
	</script>
</body>
</html>