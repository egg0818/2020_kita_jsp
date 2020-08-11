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

@WebServlet("/boardDel")
public class BoardDelSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String stri_board = request.getParameter("i_board");
		int i_board = Utils.parseStrToInt(stri_board, 0);
		if(i_board == 0) {
			response.sendRedirect("/errPage?err=2&target=boardList");
			return;
		}
		
		BoardVO vo = new BoardVO();
		vo.setI_board(i_board);
		
		int result = BoardDAO.delBoard(vo);
		if(result==1) {
			response.sendRedirect("/boardList");
		} else {
			response.sendRedirect("/errPage?err=1&target=boardList");
		}
		
	}

}
