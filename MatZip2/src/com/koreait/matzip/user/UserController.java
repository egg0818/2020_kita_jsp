package com.koreait.matzip.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.matzip.Const;
import com.koreait.matzip.ViewRef;
import com.koreait.matzip.vo.UserVO;

//mapping 담당
public class UserController {
	
	private UserService service;
	
	public UserController() {
		service = new UserService();
	}
	
	
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
		
		UserVO param = new UserVO();
		param.setUser_id(user_id);
		param.setUser_pw(user_pw);
		param.setNm(nm);

		int result = service.join(param);
		
		return "redirect:/user/login";
	}
}
