<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<div>
	<a href="/board/list"> 리스트 </a>
	<!-- loginUser는 세션에 들어가있고, 로그인할때 값을 넣어줌 -->
	<!-- c:if 는 tl문 -->
		<c:if test="${ loginUser.i_user == data.i_user }">
			<div><a href="/board/regmod?i_board=${data.i_board}">수정</a></div>
			<form action="/board/del" method="post" id="delFrm">
				<input type="hidden" name="i_board" value="${data.i_board}">
				<!-- <input type="button" value="삭제"> -->
				<a href="#" onclick="submitDel()">삭제</a>
			</form>
		</c:if>
	</div>
	<div>상세 페이지</div>
	<div>글번호 : ${data.i_board}</div>
	<div>제목 : ${data.title}</div>
	<div>내용: ${data.ctnt}</div>
	<div>작성자 : ${data.nm}</div>
	<div>작성일시 : ${data.r_dt}</div>
	<div>조회수 : ${data.hits}</div>
	<div>좋아요 : ${data.like == 1 ? '❤' : '♡' }</div>
	<script>	
		function submitDel() {
			let cf = confirm('삭제하시겠습니까?');
			if(cf) {
				delFrm.submit();
			}
		}
	</script>
</body>
</html>