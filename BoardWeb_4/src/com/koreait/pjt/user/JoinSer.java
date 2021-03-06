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


@WebServlet("/join")
public class JoinSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//get 방식은 화면 띄울 때
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ViewResolver.foward("user/join", request, response);
		
//		세션테스트
//		HttpSession gg = request.getSession();
//		gg.setAttribute("abc", gg.getAttribute(Const.LOGIN_USER));
		
		
		
	}
	
	//post 방식은 주로 업무처리(upadate, insert 등등)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String encrypt_pw = MyUtils.encrypetString(user_pw);
		String nm = request.getParameter("nm");
		String email = request.getParameter("email");
		
		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw(encrypt_pw);
		param.setNm(nm);
		param.setEmail(email);
		
		int result = UserDAO.insUser(param);
//		System.out.println("result : " + result);
		
		if(result != 1) {
//			System.out.println("에러 발생");
			
			request.setAttribute("msg", "에러가 발생");
			request.setAttribute("data", param);
			doGet(request, response);
			return;
		}
		
		response.sendRedirect("/login");
		
	}

}
