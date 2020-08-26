package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardCmtDAO;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardCmtVO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;


@WebServlet("/board/cmt")
public class BoardCmtSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//댓글(삭제)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  	String strI_board = request.getParameter("i_board");
    	int i_board = MyUtils.parseStrToInt(strI_board);
    	String strI_cmt = request.getParameter("i_cmt");
    	int i_cmt = MyUtils.parseStrToInt(strI_cmt);
    	String strI_user = request.getParameter("i_user");
    	int i_user = MyUtils.parseStrToInt(strI_user);
    	
    //	System.out.println("i_board :" + i_user);
   
    	BoardCmtVO param = new BoardCmtVO();
    	param.setI_cmt(i_cmt);
    	
    	int result = BoardCmtDAO.delCmt(param);
    	response.sendRedirect("/board/detail?i_board=" + i_board);
		
	}

	// 댓글(등록/수정)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_cmt = request.getParameter("i_cmt");
		int i_cmt = MyUtils.parseStrToInt(strI_cmt);
		String cmt = request.getParameter("cmt");
		String strI_board = request.getParameter("i_board");
		int i_board = MyUtils.parseStrToInt(strI_board);
		String strI_user = request.getParameter("i_user");
		int i_user = MyUtils.parseStrToInt(strI_user);
		
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		BoardCmtVO param = new BoardCmtVO();
		param.setI_board(i_board);
		param.setI_user(loginUser.getI_user());
		param.setCmt(cmt);
		
		switch(strI_cmt) {
		case "0" : //등록
			BoardCmtDAO.insCmt(param);
			break;
		default: //수정
			param.setI_cmt(i_cmt);
			BoardCmtDAO.updCmt(param);
			break;
		}
		
		response.sendRedirect("/board/detail?i_board="+i_board);
	}

}
