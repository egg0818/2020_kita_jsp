package com.koreait.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.common.Utils;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;


@WebServlet("/boardDetail")
public class BoardDetailSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String strI_board = request.getParameter("i_board");
		//request 는 getParmeter가 있다.(set은없음)
		// setAttribute , getsetAttribute 다있다
		int i_board = Utils.parseStrToInt(strI_board, 0);
		// 문자값을 정수값으로 파싱. 문자열이 섞여있으면 0(디폴트값)을 리턴
		
		if(i_board==0) {
			response.sendRedirect("/boardList");
			return;
		}
		
		BoardVO param = new BoardVO();
		param.setI_board(i_board);
		
		BoardVO data = BoardDAO.selBoard(param);
		request.setAttribute("data", data);
		
//		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardDetail.jsp?i_board=" + strI_board);
//		rd.forward(request, response);
		String jsp = "/WEB-INF/view/boardDetail.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
