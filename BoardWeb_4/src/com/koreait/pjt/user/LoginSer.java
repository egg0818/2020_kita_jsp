package com.koreait.pjt.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.Const;
import com.koreait.pjt.db.UserDAO;
import com.koreait.pjt.vo.UserVO;


@WebServlet("/login")
public class LoginSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession hs = request.getSession();
		
		if (MyUtils.getLoginUser(request) != null) {
			response.sendRedirect("/board/list");
		} else {
			ViewResolver.foward("user/login", request, response);
		}
		
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String encrypt_pw = MyUtils.encrypetString(user_pw);
		
		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw(encrypt_pw);
		

		// param에 id, nm, i_user 값 들어감
		int result = UserDAO.login(param);
		
		// 에러처리
		if(result != 1) {
			
			String msg = null;
		
			if(result == 2) {
				msg = "비밀번호가 틀렸습니다";
			} else if(result == 3) {
				msg = "해당되는 아이디가 없습니다";
			} else {
				msg = "에러가 발생하였습니다";
			}
			request.setAttribute("user_id", user_id);
			request.setAttribute("msg", msg);
			doGet(request, response);
			return;
		}
				
			HttpSession hs = request.getSession();
			hs.setAttribute(Const.LOGIN_USER, param);
			
			//테스트
			System.out.println("로그인 성공");
			
			response.sendRedirect("/board/list");
		
	}

}
