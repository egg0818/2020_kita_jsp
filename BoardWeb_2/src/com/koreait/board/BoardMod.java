package com.koreait.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.common.Utils;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;


@WebServlet("/boardMod")
public class BoardMod extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");
		int i_board = Utils.parseStrToInt(strI_board, 0);
		
		if(i_board==0) {
			response.sendRedirect("/boardList");
			return;
		}
		
		BoardVO param = new BoardVO();
		param.setI_board(i_board);
		
		BoardVO data = BoardDAO.selBoard(param);
		request.setAttribute("data", data);
		
		String jsp = "/WEB-INF/view/boardRegmod.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String strI_student = request.getParameter("i_student");
		int i_student = Utils.parseStrToInt(strI_student, 0);
		String strI_board = request.getParameter("i_board");
		int i_board = Utils.parseStrToInt(strI_board, 0);
		
		BoardVO param = new BoardVO();
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_student(i_student);
		param.setI_board(i_board);
		
		int result = BoardDAO.updateBoard(param);
		
		
		if(result==1) {
			response.sendRedirect("/boardDetail?i_board=" + i_board);
		} else {
			request.setAttribute("msg", "에러가 발생하였습니다");
			doGet(request, response);
		}
	
		
		
	}

}
