package com.koreait.pjt.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardCmtDAO;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.db.Const;
import com.koreait.pjt.vo.BoardCmtVO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;


@WebServlet("/board/list")
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		if(hs.getAttribute(Const.LOGIN_USER) == null) {
			response.sendRedirect("/login");
			return;
		}
		
		// 페이징
		BoardVO param = new BoardVO();
		param.setRecord_cnt(Const.RECORD_CNT);
		request.setAttribute("pagingCnt", BoardDAO.selPagingCnt(param));

		int page = MyUtils.getIntParameter(request, "page");
		page = (page == 0) ? 1: page;
		
		request.setAttribute("nowPage", page);
		
		int record_cnt = Const.RECORD_CNT;
		int eIdx = page * record_cnt;
		int sldx = eIdx - record_cnt;
		
		param.seteIdx(eIdx);
		param.setSldx(sldx);
		
		List<BoardVO> list = BoardDAO.selBoardlist(param);
		request.setAttribute("list", list);
		
		
//		LikeList 선언		
//		List<BoardVO> likeList = BoardDAO.selLikecntlist();
//		request.setAttribute("likeList", likeList);
		
//		request.setAttribute("name", hs.getAttribute(Const.LOGIN_USER));
		request.setAttribute("name", "loginUser");
		
		
		ViewResolver.fowardLoginChk("board/list", request, response);
	}

}
