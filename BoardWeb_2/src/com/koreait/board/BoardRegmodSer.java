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


@WebServlet("/boardWrite")
public class BoardRegmodSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsp = "/WEB-INF/view/boardRegmod.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String strI_student = request.getParameter("i_student");
		
		BoardVO vo = new BoardVO();
		vo.setTitle(title);
		vo.setCtnt(ctnt);
		vo.setI_student(Utils.parseStrToInt(strI_student, 0));
		
		BoardDAO.wriBoard(vo);
		
		response.sendRedirect("/boardList");
	
	}

}