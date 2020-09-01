package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;
import com.sun.deploy.uitoolkit.impl.fx.Utils;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.db.Const;
import com.koreait.pjt.db.JdbcTemplate;
import com.koreait.pjt.db.UserDAO;

@WebServlet("/board/regmod")
public class BoardRegmod extends HttpServlet {
	private static final long serialVersionUID = 1L;
  

	//화면 띄우는 용도 (등록창/수정창)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		
		if(hs.getAttribute(Const.LOGIN_USER) == null) {
			response.sendRedirect("/login");
			return;
		}
		
		String strI_board = request.getParameter("i_board");
		
		if(strI_board != null) {
			int i_board = MyUtils.parseStrToInt(strI_board);
			
			BoardVO param = new BoardVO();
			param.setI_board(i_board);
		
			BoardVO data = BoardDAO.selBoard(param);
			request.setAttribute("data", data);
		}
		
		ViewResolver.fowardLoginChk("board/regmod", request, response);
	
	}

	//처리 용도(db에등록/수정) 실시
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		String i_board = request.getParameter("i_board");
		
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO) hs.getAttribute(Const.LOGIN_USER);
		
//		String i_user = request.getParameter("i_user");
//		int i_user2 = Integer.parseInt(i_user);
		
		String filterCtnt1 = scriptFilter(ctnt);
		String filterCtnt2 = swearWordFilter(filterCtnt1);
		
		BoardVO param = new BoardVO();
		param.setTitle(title);
//		param.setCtnt(ctnt);
		param.setCtnt(filterCtnt2);
		param.setI_user(loginUser.getI_user());
		
//		System.out.println(param.getI_user());
//		System.out.println("title : " + param.getTitle() + "\n" + "ctnt : " + param.getCtnt());
		
		int result = 0;
		
		// 빈칸이면 null이 아니고 빈칸값을 가져온다. null값이 오려면 아예 value가 없어야함
		if(i_board != "") {
			param.setI_board(MyUtils.parseStrToInt(i_board));
			result = BoardDAO.uptBoard(param);
			response.sendRedirect("/board/detail?i_board=" + i_board);
			
		} else {
			result = BoardDAO.insBoard(param);
			response.sendRedirect("/board/list");
		}
	}
		
//		if(result != 1) {
//		System.out.println("에러 발생");
//		doGet(request, response);
//		return;
//	}
	
//		System.out.println("result : " + result);
		

	
		//욕 필터
		private String swearWordFilter(final String ctnt) {
			String[] filters = {"개새끼", "미친년", "ㄱ ㅐ ㅅ ㅐ ㄲ ㅣ"};
			String result = ctnt;
			for(int i=0; i<filters.length; i++) {
				result = result.replace(filters[i], "***");
			}
			return result;
		}

		//스크립트 필터
		private String scriptFilter(final String ctnt) {
			String[] filters = {"<script>", "</script>"};
			String[] filterReplaces = {"&lt;script&gt;", "&lt;/script&gt;"};

			String result = ctnt;
			for(int i=0; i<filters.length; i++) {
				result = result.replace(filters[i], filterReplaces[i]);
			}
			return result;
		}


}
