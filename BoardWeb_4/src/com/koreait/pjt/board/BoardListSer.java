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
		
		// 페이징 start
		int page = MyUtils.getIntParameter(request, "page");
		page = (page == 0) ? 1: page;
		
		int recordCnt = MyUtils.getIntParameter(request, "record_cnt");
		recordCnt = (recordCnt == 0 ? 10 : recordCnt);
		
		BoardVO param = new BoardVO();
		param.setRecord_cnt(recordCnt);
		int pagingCnt = BoardDAO.selPagingCnt(param);
		request.setAttribute("pagingCnt", pagingCnt);
		request.setAttribute("nowPage", page);
		
		int eIdx = page * recordCnt;
		int sldx = eIdx - recordCnt;
		
		param.seteIdx(eIdx);
		param.setSldx(sldx);
		
		Integer beforeRecordCnt = (Integer)hs.getAttribute("recordCnt");
		
		//이전 레코드수 값이 있고, 이전 레코드수보다 변경한 레코드 수가 더 크다면 마지막 페이지수로 변경
		if(beforeRecordCnt != null && beforeRecordCnt < recordCnt) {  
			page = pagingCnt;
		}
		
		//페이징 end
		
		List<BoardVO> list = BoardDAO.selBoardlist(param);
		request.setAttribute("list", list);
		
		
//		LikeList 선언		
//		List<BoardVO> likeList = BoardDAO.selLikecntlist();
//		request.setAttribute("likeList", likeList);
		
//		request.setAttribute("name", hs.getAttribute(Const.LOGIN_USER));
		request.setAttribute("name", "loginUser");
		
		hs.setAttribute("recordCnt", recordCnt);
		hs.setAttribute("pageinList", page);
		ViewResolver.fowardLoginChk("board/list", request, response);
	}

}
