<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록/수정</title>
<style>
.container {
    margin: 100px auto;
    width: 1000px;
 }
 .title {
 	width: 600px;
 	height: 30px;
 }
 .ctnt {
 	width: 800px;
	height: 400px;
	margin:  20px 0px 20px 0px; 	
 }
 .alert {
 	font-size: 15px;
 	color : red;
 }
</style>
</head>
<body>
<!-- <div>${data == null ? '등록' : '수정'}</div> -->
	<div class="container">
		<form id="frm" action="regmod" method="post">
			<input type="hidden" name="i_board" value="${data.i_board}">
			<input type="hidden" name="i_user" value="${data.i_user}">
			<div> <input type="text" name="title" value="${data.title}" placeholder="제목을 입력해주세요" class="title"></div>
			<div class="alert"> 음란물, 차별, 비하, 혐오 및 초상권, 저작권 침해 게시물은 민, 형사상의 책임을 질 수 있습니다. </div>
			<div> <textarea name="ctnt" class="ctnt">${data.ctnt}</textarea></div>
			<div>
				<input type="submit" value="${data == null ? '글등록' : '글수정' }">
				<a href="/board/list"> <button> 글목록 </button> </a>
			</div>
			<!--<input type="hidden" name="i_user" value="${loginUser.i_user}">
			-->
			
		</form>
	</div>
</body>
</html>