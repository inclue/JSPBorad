<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%-- charset을 utf-8로 설정 --%>
<%@ page import="java.sql.*" %><%-- sql 필요한 파일 import --%>

<!DOCTYPE html><%-- html 문서임을 알려줌 --%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><%-- charset을 utf-8로 설정 --%>
	<title>게시물 보기</title><%-- 제목 --%>
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
	
	//id값 파라미터에서 가져오기
	String id = request.getParameter("id");

	try
	{
		//SQL 연결 관련 변수
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/testdb?useUnicode=true&characterEncoding=utf8"; //연결 String
        String user = "root"; //ID
		String pw = "1234"; //비밀번호
 		String query = "SELECT * FROM tList WHERE ID = " + id;
 		
 		//SQL 연결 관련 변수 선언
 		conn = DriverManager.getConnection(jdbcDriver, user, pw);
 		stmt = conn.createStatement();
 		rs = stmt.executeQuery(query);
 		
 		out.println("<input type='button' value='수정' onclick=\"location = 'modify.jsp?id="+id+"'\">&nbsp;");//수정 클릭시 modify.jsp로 이동
 		out.println("<input type='button' value='삭제' onclick=\"location = 'delete.jsp?id="+id+"'\">&nbsp;");//삭제 클릭시 delete.jsp로 이동
 		out.println("<input type='button' value='메인으로' onclick=\"location = 'index.jsp'\"><p>");//메인 클릭시 index.jsp로 이동
 		
 		out.println("<table class='List'>");//테이블 설정
 		
 		if (rs.next())
 		{
 			out.println("<tr><td style='width:80px;'>제목</td><td>" + rs.getString("Title") + "</td></tr>");//제목
 			out.println("<tr><td style='width:80px;'>작성자</td><td>" + rs.getString("Name") + "</td></tr>");//작성자
 			out.println("<tr><td style='width:80px;'>작성시각</td><td>" + rs.getString("Time").substring(0, 16) + "</td></tr>");//작성시각(분단위 까지)
 			out.println("<tr><td colspan='2'>내용</td></tr>");
 			out.println("<tr><td colspan='2'>" + rs.getString("Content") + "</td></tr>");//내용
 		}
 		out.println("</table>");
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
%>
</body>
</html>