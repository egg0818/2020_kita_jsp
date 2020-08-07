<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
	// List<BoardVO> list = request.getAttribute()
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
</head>
<body>
	<div>상세 페이지</div>
	<div>제목 : ${data.i_board}</div>
	<!--  setattribute 있을때만 쓸수 있음. (내장객체 담긴것만 사용가능) -->
	<div>제목 : ${data.title}</div>
	<div>내용: ${data.ctnt}</div>
	<div>작성자 : ${data.i_student}</div>
</body>
</html>