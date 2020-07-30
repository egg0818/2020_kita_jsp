<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.web.BoardVO" %>
<%!
	public Connection getCon() throws Exception {
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String username = "hr";
	String password = "koreait2020";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection(url, username, password);
	System.out.println("접속 성공");
	return con;
	}
%>
<%
	String strI_board = request.getParameter("i_board");
	//strI_board가 null이면 alert가 나오고 잘못된값입니다 뜨게 해봄
	if(strI_board == null) {
%>
<script>
	alert('잘 못 된 접근입니다.');
	location.href = '/jst/boardlist.jsp';
	// http://localhost:8089/jsp/boardDetail.jsp? 일때 이렇게뜸
	// i_board 값이 없을 때 strI_board은 null!
</script>
<%
	return;
	}
	
	// request.getParameter : key값을 적어주면 value 값이 넘어옴
	// key : i_board // value : i_board의 값
	// ? 뒤에 있는 것
	// request는 내장객체
	
	int i_board = Integer.parseInt(strI_board);
	
	BoardVO vo = new BoardVO();

	Connection con = null; 
	PreparedStatement ps = null; 
	ResultSet rs = null; 
	
	//try 에 넣으면 안되는 이유 : 만약 에러가 뜨면 null이라도 떠야하는데 객체가 없으면 안된다!
	
	String sql = " SELECT title, ctnt, i_student FROM t_board WHERE i_board = ? ";
	
	try {
		con = getCon();
		ps = con.prepareStatement(sql);
		ps.setInt(1, i_board);
		// ps.setInt(물음표의 위치(정수), 입력할 값);
		// ps.setString(1, strI_board);
		// 이렇게 쓰면 자동으로 문자열로 넣어줌 ex) '5' // 되긴하지만, 정수 그대로 넣는게 좋다 !!
		// ? 로 하는거 : printf랑 비슷함.
		rs = ps.executeQuery(); 
		
		if(rs.next()) {
		// 굳이 한줄 불러올건데 if 쓸일 있나?? 0줄이면 에러터짐!
		// 근데 while 써도 상관없다! 어차피 가져올 레코드가 없으면 false가 뜨고 실행종료가 되기 때문
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			// 순서대로 가져올 필요는 없다.
			
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
			// 객체에 값주입
	}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(rs != null) { try{ rs.close(); } catch(Exception e) {} }
		if(ps != null) { try{ ps.close(); } catch(Exception e) {} }
		if(con != null) { try{ con.close(); } catch(Exception e) {} }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<style>
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
</style>
</head>
<body>
	 <div class="container">
	 	<div>
	 	<a href="/jsp/boardlist.jsp">리스트로 가기</a>
	 	<a href="#" onclick = "procDel(<%= i_board %>)">삭제</a>
	 	</div>
        <div class="subject"><%= vo.getTitle() %></div>
        <div class="writer"><%=  vo.getI_student() %> </div>
        <div class="content"><%= vo.getCtnt() %></div>
    </div>
    <script>
    	function procDel(i_board) {
    		//alert('i_board : ' + i_board);
    		var result = confirm('삭제 하시겠습니까?');
    		if(result) {
    			location.href = '/jsp/boardDel.jsp?i_board=' + i_board;
    		}
    	}
    </script>
</body>
</html>