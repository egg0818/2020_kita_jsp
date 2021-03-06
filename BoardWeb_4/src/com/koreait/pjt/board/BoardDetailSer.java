package com.koreait.pjt.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.db.BoardCmtDAO;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.db.Const;
import com.koreait.pjt.db.UserDAO;
import com.koreait.pjt.vo.BoardCmtVO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;

@WebServlet("/board/detail")
public class BoardDetailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);

		if (loginUser == null) {
			response.sendRedirect("/login");
			return;
		}

//		HttpSession hs = request.getSession();
//		if(hs.getAttribute(Const.LOGIN_USER) == null) {
//			response.sendRedirect("/login");
//			return;
//		}

		String searchType = request.getParameter("searchType");
		searchType = (searchType == null) ? "a" : searchType;

		String strI_board = request.getParameter("i_board");
		int i_board = Integer.parseInt(strI_board);

		String profile_img = request.getParameter("profile_img");

		if (i_board == 0) {
			response.sendRedirect("/board/list");
			return;
		}

		BoardVO param = new BoardVO();
		param.setI_board(i_board);
		param.setI_user(loginUser.getI_user());
		param.setSearchType(searchType);

		// 단독으로 조회수 올리기 방지! -- [start]
		ServletContext application = getServletContext(); // 어플리케이션 내장객체 얻어오기
		Integer readI_user = (Integer) application.getAttribute("read_" + strI_board);
		// I nteger은 int랑 같이 쓰면됨 다만, null이 있음
		if (readI_user == null || readI_user != loginUser.getI_user()) {
			BoardDAO.addHits(param);
			application.setAttribute("read_" + strI_board, loginUser.getI_user());
		}
		// 단독으로 조회수 올리기 방지! -- [end]

		BoardVO data = BoardDAO.selBoard(param);
		request.setAttribute("data", data);

		// 프로필 사진 올리기
		String strI_user = request.getParameter("i_user");
		int i_user = Integer.parseInt(strI_user);
//		System.out.println("i_user : " + i_user);
		UserVO uvo = UserDAO.selUser(i_user);
		uvo.setI_user(i_user);
		request.setAttribute("uvo", uvo);

		// 댓글 리스트
		List<BoardCmtVO> list = BoardCmtDAO.selBoardCmtlist(param);
		request.setAttribute("list", list);
		
		//좋아요 리스트
		List<BoardVO> likeList = BoardDAO.selBoardLikeList(i_board);
		request.setAttribute("likeList", likeList);

		ViewResolver.foward("board/detail", request, response);
	}

}