<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
.container {
    width: 500px;
    background-color: cadetblue;
    text-align: center;
    margin : 0 auto;
    padding: 30px;
}
form {
}
form div {
    margin: 20px;
}
h1 {
    color : white;
}

a {
    color : white;
    text-decoration-line: none;
}
.err {
	color : pink;
}
</style>
</head>
<body>
    <div class="container">
        <div class="err">${msg}</div>
        <h1>LOGIN</h1>
        <form action="/login" method="post">
            <div><input type="text" name="user_id" placeholder="아이디" value="${user_id}"></div>
            <div><input type="password" name="user_pw" placeholder="비밀번호"></div>		
            <div><input type="submit" value="로그인"></div>
            <span><a href="/join">회원가입</a></span>		
        </form>
    </div>
</body>
</html>