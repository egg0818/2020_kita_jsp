package com.koreait.pjt.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;

@WebServlet("/board/like")
public class BoardLikeSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	//리스트 가져오기
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int i_board = MyUtils.getIntParameter(request, "i_board");
		
		//테스트
		System.out.println("i_board : " + i_board);
		
		List<BoardVO> likeList = BoardDAO.selBoardLikeList(i_board);
		
		Gson gson = new Gson();
		
		String json = gson.toJson(likeList);
		
		//테스트
		System.out.println("json : "+ json);
		
		
		response.setCharacterEncoding("UTF-8");
		// json 형태로 response 한다
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		// {} 안에 " " 붙여줘야함
		out.print(json);
	}

	
	//좋아요 처리
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
