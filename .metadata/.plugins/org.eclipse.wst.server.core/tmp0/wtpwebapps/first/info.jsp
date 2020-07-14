<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.koreait.first.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String userName = "hr";
	String password = "koreait2020";
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = "SELECT * from countries";
	
	List<CountriesVO> list = new ArrayList<CountriesVO>();
	
	try{
		//DB의 connection을 얻어오는 것
		con = DriverManager.getConnection(url, userName, password);
		//쿼리문을 실행할 수 있는 것
		ps = con.prepareStatement(sql);
		//쿼리문을 실행
		rs = ps.executeQuery();
		//다음줄로 실행
		while(rs.next()){
			//레코드 수 만큼 실행되고, 레코드가 없으면 false
			String country_id = rs.getString("country_id");
			String country_name = rs.getString("country_name");
			int region_id = rs.getInt("region_id");
			
			CountriesVO vo = new CountriesVO();
			vo.setCountry_id(country_id);
			vo.setCountry_name(country_name);
			vo.setRegion_id(region_id);
			
			list.add(vo);
		}
	} catch(Exception e){
		e.printStackTrace();
	}finally{
		try{
		rs.close();
		ps.close();
		con.close();
		}
		catch(Exception e){}
	} 
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
</head>
<body>
	<div>나라 정보</div>
	<div>
		<table>
			<tr>
				<th>Country_id</th>
				<th>나라명</th>
				<th>지역 ID</th>
			</tr>
			<%for(CountriesVO vo : list){ %>
			<tr>
				<td><%=vo.getCountry_id() %></td>
				<td><%=vo.getCountry_name() %></td>
				<td><%=vo.getRegion_id() %></td>
			</tr>
			<%} %>
		</table>
	</div>
</body>
</html>