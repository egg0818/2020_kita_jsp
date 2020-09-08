package com.koreait.matzip.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.matzip.Const;
import com.koreait.matzip.ViewRef;

public class UserController {
	//  /user/login --> user에 있는 login 메소드 실행되게 해줄것이다아아
	public String login(HttpServletRequest request) {
//		request.setAttribute(Const.TEMPLATE, null); // null : template안쓰겠단 뜻
		request.setAttribute(Const.TITLE, "로그인"); //화면띄울때 항상해줌(밑으로 3개)
		request.setAttribute(Const.VIEW, "user/login");
		return ViewRef.TEMP_DEFAULT; // template 안쓴다는 뜻,,,이 몬데 / 어떤 template를 열지
	}
	
	public String join(HttpServletRequest request) {
		request.setAttribute(Const.TITLE, "회원가입");
		request.setAttribute(Const.VIEW, "user/join");
		return ViewRef.TEMP_DEFAULT;
	}
	
	public String joinProc(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String nm = request.getParameter("nm");
		
		return "redirect:/user/login";
	}
}
