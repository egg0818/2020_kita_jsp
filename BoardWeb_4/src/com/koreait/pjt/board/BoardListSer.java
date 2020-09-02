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
		
		//서치
		String searchText = request.getParameter("searchText");
		searchText = (searchText == null) ? "" : searchText;
		
		//서치타입
		String searchType = request.getParameter("searchType");
		searchType = (searchType == null) ? "a" : searchType;
		
		// 페이징 start
		int page = MyUtils.getIntParameter(request, "page");
		page = (page == 0) ? 1: page;
		
		int recordCnt = MyUtils.getIntParameter(request, "record_cnt");
		recordCnt = (recordCnt == 0 ? 10 : recordCnt);
		
		BoardVO param = new BoardVO();
		param.setRecord_cnt(recordCnt);
		// sql 에러 방지
		param.setSearchText("%" + searchText + "%");
		param.setI_user(MyUtils.getLoginUser(request).getI_user());
		param.setSearchType(searchType);
		
		int pagingCnt = BoardDAO.selPagingCnt(param);
		
		request.setAttribute("pagingCnt", pagingCnt);
		request.setAttribute("nowPage", page);
		
		if(page > pagingCnt) {
			page = pagingCnt;
		}
		
		int eIdx = page * recordCnt;
		int sldx = eIdx - recordCnt;
		
		param.seteIdx(eIdx);
		param.setSldx(sldx);
		//페이징 end
		
		List<BoardVO> list = BoardDAO.selBoardlist(param);
		
		// 제목 하이라이트 처리
		if(!"".equals(searchText) && ("a".equals(searchType) || "c".equals(searchType))) {
			for(BoardVO item : list) {
				String title = item.getTitle();
				title = title.replace(searchText
						, "<span class=\"highlight\">" + searchText +"</span>");
				item.setTitle(title);
			}
		}
		
		request.setAttribute("list", list);
		
		
//		LikeList 선언		
//		List<BoardVO> likeList = BoardDAO.selLikecntlist();
//		request.setAttribute("likeList", likeList);
		
//		request.setAttribute("name", hs.getAttribute(Const.LOGIN_USER));
		request.setAttribute("name", "loginUser");
//		request.setAttribute("searchText", searchText);
		request.setAttribute("searchType", searchType);
		hs.setAttribute("recordCnt", recordCnt);
		hs.setAttribute("pageinList", page);
		hs.setAttribute("searchText", searchText);
		ViewResolver.fowardLoginChk("board/list", request, response);
	}

}
