package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.db.Const;
import com.koreait.pjt.db.JdbcTemplate;
import com.koreait.pjt.db.UserDAO;

@WebServlet("/board/regmod")
public class BoardRegmod extends HttpServlet {
	private static final long serialVersionUID = 1L;
  

	//화면 띄우는 용도 (등록창/수정창)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		
		if(hs.getAttribute(Const.LOGIN_USER) == null) {
			response.sendRedirect("/login");
			return;
		}
		
		ViewResolver.foward("board/regmod", request, response);
		
		
	}

	//처리 용도(db에등록/수정) 실시
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO) hs.getAttribute(Const.LOGIN_USER);
		
//		String i_user = request.getParameter("i_user");
//		int i_user2 = Integer.parseInt(i_user);
		
		BoardVO param = new BoardVO();
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_user(loginUser.getI_user());
		
//		System.out.println(param.getI_user());
//		System.out.println("title : " + param.getTitle() + "\n" + "ctnt : " + param.getCtnt());
		

		
		int result = BoardDAO.insBoard(param);
		
		response.sendRedirect("/board/list");
		
//		if(result != 1) {
//			System.out.println("에러 발생");
//			doGet(request, response);
//			return;
//		}
		
		System.out.println("result : " + result);
		
	}


}
