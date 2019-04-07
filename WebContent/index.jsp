<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%-- charset을 utf-8로 설정 --%>
<%@ page import="java.sql.*" %><%-- sql 필요한 파일 import --%>

<!DOCTYPE html><%-- html 문서임을 알려줌 --%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><%-- charset을 utf-8로 설정 --%>
	<title>게시판 메인</title><%-- 제목 --%>
	<style><%-- css 속성 설정 --%>
      	.List { border-collapse:collapse; width:100%; }  
		.List th, .List td { border:1px solid black; }
	</style>
</head>
<body>
<%
	//JDBC 드라이버 클래스 가져오기
	Class.forName("com.mysql.jdbc.Driver");

	//SQL 연결 관련 변수 선언
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	//Table 헤더 설정
	out.println("<table class='List'>");
	out.println("<thead>");
	out.println("<tr>");
	out.println("<th style='width:80px;'>글 번호</th>");
	out.println("<th>제목</th>");
	out.println("<th style='width:100px;'>작성자</th>");
	out.println("<th style='width:150px;'>작성시각</th>");
	out.println("</tr>");
	out.println("</thead>");
	out.println("<tbody>");

	try
	{
		//SQL 연결 관련 변수
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/testdb?useUnicode=true&characterEncoding=utf8"; //연결 String
        String user = "root"; //ID
		String pw = "1234"; //비밀번호
 		String query = "SELECT * FROM tList ORDER BY ID DESC";
 		
		//SQL 연결 및 쿼리 실행
 		conn = DriverManager.getConnection(jdbcDriver, user, pw);
 		stmt = conn.createStatement();
 		rs = stmt.executeQuery(query);
 		
 		//데이터 여부 확인하기
 		while (rs.next())
 		{
 			//Table Row 관련 설정
 			out.println("<tr>");
 			out.println("<td>" + rs.getString("ID") + "</td>"); //ID 값
 			out.println("<td><a href=\"view.jsp?id=" + rs.getString("ID") + "\">" + rs.getString("Title") + "</a></td>"); //제목 및 누르면 해당 view.jsp로 가기
 			out.println("<td>" + rs.getString("Name") + "</td>"); //이름
 			out.println("<td>" + rs.getString("Time").substring(0, 16) + "</td>"); //시간(분단위 까지만)
 			out.println("</tr>");
 		}
	}
	catch (SQLException ex) //SQL 연결 도중 에러 발생 시
	{
		out.println("에러 발생 : " + ex.getMessage());
	}
	finally //SQL 연결 관련 변수 Close
	{
		if(rs != null)
		{
			try
			{
				rs.close();
			}
			catch (SQLException ex) {}
		}
		if(stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch (SQLException ex) {}
		}
		if(conn != null)
		{
			try
			{
				conn.close();
			}
			catch (SQLException ex) {}
		}
	}
	
	//테이블 설정 종료
	out.println("</tbody>");
	out.println("<p><input type='button' value='게시글 추가' onclick=\"location = 'insert.jsp'\">");//게시글 추가 버튼
	out.println("</table>");
%>
</body>
</html>