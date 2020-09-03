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
import com.koreait.pjt.db.UserDAO;
import com.koreait.pjt.vo.UserVO;


@WebServlet("/changePw")
public class ChangePwSer extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		
	ViewResolver.fowardLoginChk("user/changePw", request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String pw = request.getParameter("pw");
		
		String encryptPw = MyUtils.encrypetString(pw);
		
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		switch(type) {
		case "1": // 현재 비밀번호 확인
			
			UserVO param = new UserVO();
			param.setUser_id(loginUser.getUser_id());
			param.setUser_pw(encryptPw);
			
			int result = UserDAO.login(param);
			
			if(result == 1) {
				request.setAttribute("isAuth", true);
			} else {
				request.setAttribute("msg", "비밀번호를 확인해 주세요");
			}

			doGet(request, response);

			break;
			
		case "2" :
			System.out.println("2222222");
			UserVO param2 = new UserVO();
			param2.setUser_pw(encryptPw);
			param2.setI_user(loginUser.getI_user());
			
			int result2 = UserDAO.updUser(param2);
			
			if(result2 == 1) {
				ViewResolver.fowardLoginChk("user/profile", request, response);
			}
		}
		
		
	}

}
