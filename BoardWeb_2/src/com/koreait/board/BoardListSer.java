package com.koreait.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/boardList")
//주소 맵핑
//모든 서블릿은 이미 객체화 되어있고, container가 가져온다
//맘대로 바꿔줌 -> 보안을 위해서


public class BoardListSer extends HttpServlet {
	// HttpServlet를 상속받는다
	// 부모부터 메모리에 올린다
	private static final long serialVersionUID = 1L;
       
 
    public BoardListSer() {
        super();
    }
    //기본생성자 
    //생정자 특징 : 1.이름이 클래스명과 동일하다. 2.변환타입이 없다
    //super() : 직속 부모에 있는 생성자 호출
    // 자바 최상의 부모 : object <- HttpServlet <- BoardListSer
    // 생성자 호출은 반대
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		String strI_board = request.getParameter("i_board");
		System.out.println("Servlet i_board : " + strI_board);
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardList.jsp");
		rd.forward(request, response);
	}
	// protected -> 접근제어자고, 범위는 : 패키지 내
	// throws ServletException, IOException 안에서 예외처리 하지않고 던진다! (호출한 클래스에게)
	// 요청하면 jsp container가 실행시켜준다!
	// 고객이 나에게 보낸 모든 정보는 request에 담겨있다
	// response 내용이 응답으로 갈거다
	// request dispatcher : 주소값은 안바꾸고 이동시킴. 서블릿과 jsp를 연결시키는 통로가 생기는거임

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
