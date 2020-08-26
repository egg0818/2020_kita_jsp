package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.db.BoardCmtDAO;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardCmtVO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;


@WebServlet("/board/delcmt")
public class BoardDelCmtSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	String strI_board = request.getParameter("i_board");
    	int i_board = MyUtils.parseStrToInt(strI_board);
    	String strI_cmt = request.getParameter("i_cmt");
    	int i_cmt = MyUtils.parseStrToInt(strI_cmt);
    	String strI_user = request.getParameter("i_user");
    	int i_user = MyUtils.parseStrToInt(strI_user);
    	
    	UserVO loginUser = MyUtils.getLoginUser(request);
    	
    	if(loginUser == null) {
    		response.sendRedirect("/login");
    		return;
    	}
   
    	BoardCmtVO param = new BoardCmtVO();
    	param.setI_board(i_cmt);
    	param.setI_user(i_user);
    	
    	int result = BoardCmtDAO.delCmt(param);
    	response.sendRedirect("/board/detail?i_board=" + i_board);
	}
	
}
