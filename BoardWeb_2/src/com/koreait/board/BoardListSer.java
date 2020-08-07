package com.koreait.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.db.BoardDAO;
import com.koreait.board.db.Dbcon;
import com.koreait.board.vo.BoardVO;

@WebServlet("/boardList")
//주소 맵핑
//모든 서블릿은 이미 객체화 되어있고, java container가 가져온다
//주소를 바꿔줘야함  (맘대로 바꿔줄 수 있음) -> 보안을 위해서


public class BoardListSer extends HttpServlet {
	// HttpServlet를 상속받는다
	// 부모로부터 메모리에 올린다
	private static final long serialVersionUID = 1L;
	// 수정이나 제거 NO. 세션과 관련 된 내용
       
 
    public BoardListSer() {
        super();
    }
    //기본생성자 
    //생정자 특징 : 1.이름이 클래스명과 동일하다. 2.변환타입이 없다
    //super() : 직속 부모에 있는 생성자 호출
    // 자바 최상의 부모 : object <- HttpServlet <- BoardListSer
    // 생성자 호출은 반대
    // 기본 생성자는 클래스를 만들면 자동으로 실행 되는거기 때문에 생략해도 됨!
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
//		String strI_board = request.getParameter("i_board");
//		System.out.println("Servlet i_board : " + strI_board);
		
//		try {
//			Connection con = Dbcon.getCon();
//			PreparedStatement ps = null;
//			ResultSet rs = null;
//			
//			Dbcon.close(con, ps, rs);
//			Dbcon.close(con, ps);
//			// 오버로딩
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
	// throws Exception 했으니 try catch로 감싸줘야함
		
		List<BoardVO> list = BoardDAO.selBoardlist();
		request.setAttribute("data", list);
		// 파라미터는 String형 Object형이다
		// Object는 최상위 객체이기 때문에 -> 부모는 자식을 가르킬수있다.
		// return타입은 object다. (제네릭을 주지 않은 이상)
		
//		BoardDAO 확인용
//		for(BoardVO i : list) {
//			System.out.println(i.getTitle() + i.getI_student());
//		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardList.jsp");
		//WEB-INF 아래에 jsp 파일 놔두면 접근불가하다. 보안이 뛰어나다. 
		rd.forward(request, response);
	}
	// throws ServletException, IOException 안에서 예외처리 하지않고 던진다! (호출한 클래스에게)
	// 요청하면 jsp container가 실행시켜준다!
	// 고객이 나에게 보낸 모든 정보는 request에 담겨있다
	// response 내용이 응답으로 갈거다
	// request dispatcher : 주소값은 안바꾸고 이동시킴. 서블릿과 jsp를 연결시키는 통로가 생기는거임
    // sendRedirect 와 getRequestDispatcher 차이점
    // 1. sendRedirect 기존 데이터를 하나도 사용할 수 없다 / getRequestDispatcher 전송한 데이터를 그대로 유지 
    // 2. sendRedirect는 주솟값이 변하지만  / getRequestDispatcher는 주솟값이 변하지 않음
    // 3. sendRedirect는 무조건 get 방식 / getRequestDispatcher는 get post 둘다 가능

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	// get이나 post 중 쓰는것만 쓰자
	
}

// 자바 내장객체 4개가 제일 중요함 : 1.페이지컨텐션 2.리퀘스트 3.세션 4.어플리케이션
// 값을 넣고 뺄수 있는 것들이라서
// 다들 스코프가 다르니 다 구분된건
// 1,2 : 응답하고 죽음. 3: 브라우저를 완전히 끄는 순간 죽음 4.서버를 켜는순간 생성되고 끄는순간 죽는다
// 1,2,3 : 개인용  / 4: 곻용
// 쿠키 : 정보를 pc에 저장하는것
// 세션 : 정보를 서버에 저장하는것 -> 서버에 부담이되니까 이것도 예전기술 -> 요샌 jwt 씀 (세션, jwt도 쿠키를 쓰긴함)
// 요새 OAUTH 2.0 많이씀