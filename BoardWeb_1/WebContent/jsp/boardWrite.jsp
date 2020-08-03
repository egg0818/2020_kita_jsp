<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String msg = "";
	String err = request.getParameter("err");
	if(err!=null) {
		switch(err) {
		case "10":
			msg = "등록할 수 없습니다";
			break;
		case "20":
			msg = "DB 에러 발생";
			break;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
	#msg {
	color:red;
	}
</style>
</head>
<body>
	<div id="msg"><%= msg %></div>
	<div>
		<form id="frm" action="/jsp/boardWriteProc.jsp" method="post" onsubmit="return chk()">
		<!-- return false만 유일하게 안날라가게 할수있음 -->
			<div><label>제목: <input type="text" name="title"></label></div>
			<div><label>내용: <textarea name="ctnt"></textarea></label></div>
			<div><label>작성자: <input type="text" name="i_student"></label></div>
			<div><input type="submit" value="글등록"></div>
			<div><input type="reset" value="리셋"></div>
		</form>
	</div>
	<script>
	// 자스를 바디 밑에 적는이유 ?
	// HTML(엘레멘트)를 주로 받아와서 코드를 실행하기 때문
	// style을 위에 다가 적는이유 ? 번쩍임 현상 방지\
	// on~ 시작하는것 : 이벤트 ex)onhover, onclick, onsubmit 등등
		function eleValid(ele, nm) {
			if(ele.value.length == 0) {
				alert(nm + '을(를) 입력해 주세요.')
				ele.focus()
				return true
			}
		}
		function chk() {
//			console.log(`title : \${frm.title.value}`)
//			console.log('title : ' + frm.title.value)
			if(eleValid(frm.title, '제목')) {
				return false
			} else if(eleValid(frm.ctnt, '내용')) {
				return false
			} else if(eleValid(frm.i_student, '작성자')) {
				return false
			} 
			/*
			if(frm.title.value == '') {
				alert('제목을 입력해주세요.')
				frm.title.focus()
				return false
			} else if(frm.ctnt.value.length == 0) {
				alert('내용을 입력해 주세요.')
				frm.ctnt.focus()
				return false
			} else if(frm.i_student.value.length == 0) {
				alert('작성자를 입력해주세요.')
				frm.i_student.focus()
				return false
			}
			*/
		}
	</script>
</body>
</html>