<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<style>
.material-icons {
	color: red;
	cursor: pointer;
    position: relative;
    left : 850px;
    top: 5px;
}
.container {
    margin: 0px auto;
    width: 1000px;
 }
.content {
    padding : 50px;
    font-size: 15px;
}
.writer {
    border-top: 2px solid black;
    background-color:powderblue;
    height: 25px;
            margin-bottom: 20px;
            font-size: 15px;
            text-align: left;
            padding-top: 10px;
            padding-left: 15px;
        }
        .subject {
            font-size: 20px;
            font-weight: bolder;
        }
        .index {
            text-align: right;
            font-size: 15px;
            color:gray;
        }
        .index, .subject, .writer, .content {
            margin: 15px;
        }
        .writedate {
            position: relative;
            left: 500px;
        }
        .likecnt {
        	position: relative;
        	left: 850px;
        	top: 10px;
        	font-size: 15px;
        	color: red;
        }
        .cmt-box {
        	width: 800px;
        }
</style>
</head>
<body>
<div class="container">
        <div>
            <a href="/board/list"> 리스트 </a>
            <!-- loginUser는 세션에 들어가있고, 로그인할때 값을 넣어줌 -->
            <!-- c:if 는 tl문 -->
            <c:if test="${ loginUser.i_user == data.i_user }">
                <div>
                    <a href="/board/regmod?i_board=${data.i_board}">수정</a>
                </div>
                <form action="/board/del" method="post" id="delFrm">
                    <input type="hidden" name="i_board" value="${data.i_board}">
                    <!-- <input type="button" value="삭제"> -->
                    <a href="#" onclick="submitDel()">삭제</a>
                </form>
            </c:if>
        </div>
        <br><br>
        ${data.i_board}
        <div class="subject">
       	 제목 : ${data.title}
        <c:if test="${data.like == 0}">
            <span class="material-icons" onclick="togglelike()">favorite_border</span><span class="likecnt">${data.likecnt}</span>
        </c:if>
        <c:if test="${data.like == 1}">
            <span class="material-icons" onclick="togglelike()">favorite</span><span class="likecnt">${data.likecnt}</span>
        </c:if>
        </div>
        <div class="writer">작성자 : ${data.nm}
            <span class="writedate">작성일시 : ${data.r_dt} &nbsp;&nbsp;&nbsp;&nbsp; 조회수 : ${data.hits}</span>
        </div>
        <div class="content">${data.ctnt}</div>
        <!-- <div>좋아요 : ${data.like == 1 ? '❤' : '♡' }</div>  -->
        
        <div>
    		<form id="cmtFrm" action="/board/cmt" method="post">
    			<input type="hidden" name="i_cmt" value="0">
    			<input type="hidden" name="i_board" value="${data.i_board}">
    			<input type="hidden" name="i_user" value="${data.i_user}">
    			<div>
    				<input type="text" name="cmt" placeholder="댓글내용" class="cmt-box">
    				<input type="submit" value="전송">
    			</div>
    		</form>
    	</div>
    	<div>
    		<h3> 댓글 리스트 </h3>
    		<table>
    			<tr class="cmtRow">
					<th>번호</th>
					<th>내용</th>
					<th>글쓴이</th>
					<th>등록일</th>
				</tr>
		    	<c:forEach items="${list}" var="item">
				<tr class="cmtRow">
					<td>${item.i_cmt} </td>
					<td>${item.cmt} </td>
					<td>${item.nm} </td>
					<td>${item.r_dt} </td>
				</tr>
				</c:forEach>
    		</table>
    	</div>
    </div>
	<script>	
		function submitDel() {
			let cf = confirm('삭제하시겠습니까?');
			if(cf) {
				delFrm.submit();
			}
		}
		
		function togglelike() {
			location.href = '/UserLikeSer?i_board=${data.i_board}&like=${data.like}';
		}
		
	</script>
</body>
</html>