package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;


@WebServlet("/board/del")
public class BoardDelSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String stri_board = request.getParameter("i_board");
		int i_board = Integer.parseInt(stri_board);
		// System.out.println("i_board : " + i_board);
		
//		if(i_board == 0) {
//			response.sendRedirect("/errPage?err=2&target=boardList");
//			return;
//		}
		
		BoardVO vo = new BoardVO();
		vo.setI_board(i_board);
		
		int result = BoardDAO.delBoard(vo);
		
		if(result==1) {
			response.sendRedirect("/board/list");
		} 
		
	}

}
