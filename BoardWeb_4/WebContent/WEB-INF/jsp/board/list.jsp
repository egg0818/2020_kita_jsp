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
	top:3px;
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
.pageNumber {
	position: relative;
	left: 430px;
}
.containerPImg {
	display: inline-block;	
	width: 30px;
	height: 30px;
	   border-radius: 50%;
	   overflow: hidden;
	}
.pImg {
	
		object-fit: cover;
		max-width:100%;
	}
.highlight {
	color: red;
}
</style>
</head>
<body>
	<div class="container">
		<span class="logout"><a href="/logout"><button>로그아웃</button></a></span>
		<span class="welcome"><a href="/profile"><strong>${loginUser.nm}</strong></a>님 환영합니다</span>
		<br>
		<div class="pageNumber">
			<form id="selFrm" action="/board/list" method="get">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="searchText" value="${param.searchText}">
				레코드 수 :
				<select name="record_cnt" onchange="changeRecordCnt()">
					<c:forEach begin="10" end="30" step="10" var="item">
						<c:choose>
							<c:when test="${param.record_cnt == item}">
								<option value="${item}" selected>${item}개</option>
							</c:when>
						<c:otherwise>
							<option value="${item}"> ${item}개</option>
						</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</form>
		</div>
		<span class="button-write">
		<a href="/board/regmod?i_user=${loginUser.i_user}"><button>글쓰기</button></a>
		</span>
		<a href="/board/list"><h1 class="title">게시판</h1></a>
		<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일시</th>
			<th>좋아요</th>
			<td><span class="material-icons">favorite</span></td>
		</tr>
			<c:forEach items="${list}" var="item">
			<tr class="itemRow">
				<td>${item.i_board} </td>
				<td onclick="moveToDetail(${item.i_board}, ${item.i_user})">${item.title}
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
				<td>${item.hits} </td>
				<td>${item.r_dt} </td>
				<td><span onclick="getLikeList(${item.i_board}, ${item.likecnt})">${item.likecnt}</span></td>
				<td>
				 <c:if test="${item.yn_like == 0}">
           	 	<span class="material-icons" onclick="togglelike()">favorite_border</span><span class="likecnt">${data.likecnt}</span>
        		</c:if>
        		<c:if test="${item.yn_like == 1}">
           		 <span class="material-icons" onclick="togglelike()">favorite</span><span class="likecnt">${data.likecnt}</span>
        		</c:if>
        		</td>
			</tr>
			</c:forEach>
		</table>
		<div class="search">
			<form action="/board/list">
				<select name="searchType">
					<option value="a" ${searchType == 'a' ? 'selected' : ''}>제목</option>
					<option value="b" ${searchType == 'b' ? 'selected' : ''}>내용</option>
					<option value="c" ${searchType == 'c' ? 'selected' : ''}>제목+내용</option>
				</select>
				<input type="search" name="searchText" value="${searchText}">
				<input type="hidden" name="record_cnt" value="${param.record_cnt}">
				<input type="submit" value="검색">			
			</form>
		</div>
		<div class="page_div">
			<c:forEach var="item" begin="1" end="${pagingCnt}">
				<c:choose>
					<c:when test="${nowPage == item}">
						<span class="nowpage"><strong>${item}</strong></span>
					</c:when>
					<c:otherwise>
	      				<span><a href="/board/list?page=${item}&record_cnt=${param.record_cnt}&searchText=${param.searchText}&searchType=${searchType}"">${item}</a></span>
	    			</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
	<div id="likeListContainer">
	</div>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script>
	
	function moveToDetail(i_board, i_user) {
		//console.log('moveToDetail - i_board : ' + i_board)
		//location.href = 'detail?i_board=' + i_board + '&i_user=' + i_user + '&searchText=${param.searchText}&searchType=${searchType}';
		location.href = '/board/detail?page=${page}&record_cnt=${param.record_cnt}&searchType=${searchType}&searchText=${searchText}&i_board=' + i_board + '&i_user=' + i_user;
	}
	
	function changeRecordCnt() {
		selFrm.submit();
	}
	
	function getLikeList(i_board, cnt) {
		likeListContainer.innerHTML = ""
		if(cnt == 0) { return }
		
		//get 방식으로 날림
		axios.get('/board/like', {
			params: {
				'i_board':i_board //key랑 value랑 같을때는 이렇게 써야함
			}
		}).then(function(res) {
			if(res.data.length > 0) {
				for(let i=0; i<res.data.length; i++) {
					const result = makeLikeUser(res.data[i])
					console.log(result)
					likeListContainer.innerHTML += result
				}
			}
		})
	}
	
	function makeLikeUser(one){
        const img = one.profile_img == null ? '<img class="pImg" src="/img/default_profile.png">' : 
           `<img class="pImg" src="/img/user/\${one.i_user}/\${one.profile_img}">`
        
        const ele = `<div class="likeListContainer">
           <div class="containerPImg">
                 \${img}
           </div>
           <span>
           		\${one.nm}
           	</span>
        </div>`
        
        return ele
     }
	
	</script>
</body>
</html>