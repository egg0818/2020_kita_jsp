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
    position: relative;
    top: 51px;
	color: red;
	cursor: pointer;
    left : 920px;
}
.likecnt {
    position: relative;
    top: 55px;
    left: 920px;
    font-size: 15px;
    color: red;
}
.container {
    margin: 0px auto;
    width: 1000px;
 }
.content {
    padding : 50px;
    padding-bottom : 300px;
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
    padding-right: 15px;
    padding-bottom : 15px;
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
    left: 400px;
}
.cmt-box {
    width: 700px;
    height: 30px;
}
.board_idx {
	position:relative;
	left: 15px;
	font-size: 10px;
	
}
.cotainer_cmt {
	margin : 0 auto;
	width : 800px;
	text-align : center;
}
.table_cmt th, td {
	width: 700px;
	text-align: center;
	padding: 10px;
}
.cmt-buttons {
	position:relative;
	left: 150px;
}
.containerPImg {
	display: inline-block;	
	width: 30px;
	height: 30px;
	border-radius: 50%;
	overflow: hidden;
	position : relative;
	top : 10px; 
	}
.pImg {
	object-fit: cover;
	max-width:100%;
	}
</style>
</head>
<body>
<div class="container">
        <div>
        	<!-- BoardlistSer에서 가져온 세션 값을 활용 -->
            <a href="/board/list?page=${pageinList}&record_cnt=${recordCnt}&searchText=${searchText}"> 리스트 </a>
            <!-- loginUser는 세션에 들어가있고, 로그인할때 값을 넣어줌 -->
            <!-- c:if 는 tl문 -->
            <c:if test="${ loginUser.i_user == data.i_user }">
                <div>
                    <a href="/board/regmod?i_board=${data.i_board}"><button>수정</button></a>
                </div>
                <form action="/board/del" method="post" id="delFrm">
                    <input type="hidden" name="i_board" value="${data.i_board}">
                    <!-- <input type="button" value="삭제"> -->
                    <a href="#" onclick="submitDel()"><button>삭제</button></a>
                </form>
            </c:if>
        </div>
        <br><br>
        <!-- <span class="board_idx">${data.i_board}</span> -->
         <c:if test="${data.like == 0}">
            <span class="material-icons" onclick="togglelike()">favorite_border</span><span class="likecnt">${data.likecnt}</span>
        </c:if>
        <c:if test="${data.like == 1}">
            <span class="material-icons" onclick="togglelike()">favorite</span><span class="likecnt">${data.likecnt}</span>
        </c:if>
        <div class="subject">
       	 제목 : ${data.title}
        </div>
        <div class="writer">작성자 : ${data.nm}
                <div class="containerPImg">
			<c:choose>
				<c:when test="${uvo.profile_img != null}">
					<img class="pImg" src="/img/user/${uvo.i_user}/${uvo.profile_img}">
				</c:when>
				<c:otherwise>
					<img class="pImg" src="/img/default_profile.png">
				</c:otherwise>
			</c:choose>
		</div>
        <span class="writedate">작성일시 : ${data.r_dt} &nbsp;&nbsp;&nbsp;&nbsp; 조회수 : ${data.hits}</span>
        </div>
        <div class="content">${data.ctnt}</div>
        <!-- <div>좋아요 : ${data.like == 1 ? '❤' : '♡' }</div>  -->
        
        <div>
    		<form id="cmtFrm" action="/board/cmt" method="post">
    			<input type="hidden" name="i_cmt" value="0" class="i_cmtt">
    			<input type="hidden" name="i_board" value="${data.i_board}">
    			<input type="hidden" name="i_user" value="${data.i_user}">
    			<div class="cmt-buttons">
    				<input type="text" name="cmt" placeholder="댓글내용" class="cmt-box" value="">
    				<input type="submit" value="전송" id="cmtSubmit">
    				<input type="submit" value="취소" onclick="clkCmtCancel()">
    			</div>
    		</form>
    	</div>
    	<div class="cotainer_cmt">
    		<h3> 댓글 리스트 </h3>
    		<table class="table_cmt">
    			<tr class="cmtRow">
					<th>번호</th>
					<th>내용</th>
					<th>글쓴이</th>
					<th>등록일</th>
					<th>비고</th>
				</tr>
		    	<c:forEach items="${list}" var="item">
				<tr class="cmtRow">
					<td>${item.i_cmt} </td>
					<td>${item.cmt} </td>
					<td>
						<div class="containerPImg">
							<c:choose>
								<c:when test="${item.profile_img != null}">
									<img class="pImg" src="/img/user/${item.i_user}/${item.profile_img}">
								</c:when>
								<c:otherwise>
									<img class="pImg" src="/img/default_profile.png">
								</c:otherwise>
							</c:choose>
						</div>
						${item.nm}
					</td>
					<td>${item.r_dt}</td>
					<td> 
						<c:if test="${ loginUser.i_user == item.i_user }">
								<button onclick="updateCmt('${item.cmt}', '${item.i_cmt}')">수정</button>
	                    		<button onclick="clkCmtDel(${item.i_cmt})">삭제</button>
	            		</c:if>
					</td>
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
		
		function updateCmt(cmt2, i_cmt2) {
			/*
			let cmt = document.querySelector(".cmt-box");
			cmt.setAttribute("value", cmt2);
			let i_cmt = document.querySelector(".i_cmtt");
			i_cmt.setAttribute("value", i_cmt2);
			*/
			
			cmtFrm.i_cmt.value = i_cmt2;
			cmtFrm.cmt.value = cmt2;
			
			cmtSubmit.value = '수정';
		}
		
		function clkCmtCancel() {
			cmtFrm.i_cmt = 0;
			cmtFrm.cmt.value = '';
			cmtSubmit.value = '전송';
		}
		
		function clkCmtDel(i_cmt) {
			if(confirm('삭제하시겠습니까?')) {
				location.href = '/board/cmt?i_board=${data.i_board}&i_cmt=' + i_cmt;
			}
		}
		
		function togglelike() {
			location.href = '/UserLikeSer?i_board=${data.i_board}&like=${data.like}&i_user=${data.i_user}';
		}
	</script>
</body>
</html>