<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%-- charset을 utf-8로 설정 --%>
<%@ page import="java.sql.*" %><%-- sql 필요한 파일 import --%>

<!DOCTYPE html><%-- html 문서임을 알려줌 --%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><%-- charset을 utf-8로 설정 --%>
	<title>게시글 수정</title><%-- 제목 --%>
	<style><%-- css 속성 설정 --%>
      		.List { border-collapse:collapse; width:400px; }  
	</style>
</head>
<body>
<%
	//JDBC 드라이버 클래스 가져오기
	Class.forName("com.mysql.jdbc.Driver");

	//설정할 변수 정의
	String id = request.getParameter("id"); //id값 파라미터로 가져오기
	String name = null;
    String password = null;
    String title = null;
    String content = null;
    
    //SQL 연결 관련 변수 설정
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	try
	{
		//SQL 연결 관련 변수
		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/testdb?useUnicode=true&characterEncoding=utf8"; //연결 String
        String user = "root"; //ID
		String pw = "1234"; //비밀번호
 		String query = "SELECT * FROM tList WHERE ID = " + id;
 		
 		//SQL 연결 및 쿼리 실행
 		conn = DriverManager.getConnection(jdbcDriver, user, pw);
 		stmt = conn.createStatement();
 		rs = stmt.executeQuery(query);

 		//이름, 비밀번호, 제목, 내용 가져오기
 		if (rs.next())
 		{
 			name = rs.getString("name");
 			password = rs.getString("password");
 			title = rs.getString("title");
 			content = rs.getString("content");
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
%>
	<form method="post" action="modifyQuery.jsp"> <%-- 글 수정 선택시 post 방식으로 modifyQuery.jsp로 넘겨줌 --%>
		<table class='List'>
			<tr>
				<%-- 이름 --%>
				<td width='20%'>이름</td>
				<td width='30%'><input style='width:100%;' type='text' name='name' value='<%=name %>' maxlength='15'></td>
				<%-- 비밀번호 입력 --%>
				<td width='20%'>&nbsp;&nbsp;비밀번호</td>
				<td width='30%'><input style='width:100%;' type='password' name='password' maxlength='15'></td>
			</tr>
			<tr>
				<%-- 제목 --%>
				<td width='20%'>제목</td>
				<td colspan='3'><input style='width:100%;' type='text' name='title' value='<%=title %>'></td>
			</tr>
			<tr>
				<%-- 내용 --%>
				<td colspan='4'>
					<textarea name='content' rows='15' cols='100'><% out.println(content); %></textarea>
				</td>
			</tr>
		</table>
		<input style='width:100%;display:none;' type='text' name='id' value='<%=id %>'><%-- ID(숨기기) --%>
		<input style='width:100%;display:none;' type='text' name='passwordCheck' value='<%=password %>'><%-- 비밀번호 확인(숨기기) --%>
		<input type="submit" value="글 수정">&nbsp; <%-- submit 선택시 해당 내용을 다른 페이지로 넘겨줌 --%>
		<%
			out.println("<input type='button' value='취소' onclick=\"location = 'view.jsp?id=" + id + "'\">"); //취소 시 해당 id에 대한 view.jsp로 넘겨줌.
		%>
	</form>
</body>
</html>