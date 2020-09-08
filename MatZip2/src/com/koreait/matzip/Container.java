package com.koreait.matzip;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/")
public class Container extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private HandlerMapper mapper;

	public Container() {
		mapper = new HandlerMapper();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		proc(request, response);
	}
       
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		proc(request, response);
	}
	
	private void proc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String temp = mapper.nav(request);
		
		if(temp.indexOf("/") >= 0 && "redirect:".equals(temp.substring(temp.indexOf("/")))) {	
			response.sendRedirect(temp.substring(temp.indexOf("/")));
			return;
		
		}
		
		switch(temp) {
		case "405":
			temp = "/WEB-INF/view/error.jsp";
			break;
		case "404":
			temp = "/WEB-INF/view/notFound.jsp";
			break;
		}
		
		request.getRequestDispatcher(temp).forward(request, response);
	}

}

//protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//	System.out.println("uri : " + request.getRequestURI());
//	String[] uriArr = request.getRequestURI().split("/"); //split 자르기 , 결과값이 /res/js/test.js
//	
//	for(int i=0; i<uriArr.length; i++) {
//		System.out.println("uriArr[" + i + "] : " + uriArr[i]); // 0-> 빈칸, 1-> res , 2-> js, 3-> test.js
//	}
//	
//	//response.sendRedirect(request.getRequestURI());
//	if(uriArr.length > 1 ) {
//		request.getRequestDispatcher(request.getRequestURI()).forward(request, response);
//	}
//}
