<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%-- charset을 utf-8로 설정 --%>
<%@ page import="java.sql.*" %><%-- sql 필요한 파일 import --%>

<!DOCTYPE html><%-- html 문서임을 알려줌 --%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><%-- charset을 utf-8로 설정 --%>
	<title>저장 페이지</title><%-- 제목 --%>
</head>
<body>
<%
		//JDBC 드라이버 클래스 가져오기
		Class.forName("com.mysql.jdbc.Driver");		

		//한글 깨짐을 방지하기 위한 인코딩 처리
		request.setCharacterEncoding("utf-8");	

        // getParameter()를 이용해 넘겨진 파라미터 값을 얻어올 수 있다.
        // 파라미터 값을 얻을때 name= 에 지정해둔 값과 동일한 값을 인자로 지정해야 된다.
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        //SQL 연결 관련 변수 선언
        Connection conn = null;
    	PreparedStatement pstmt = null;
        
        try
    	{
        	//SQL 연결 관련 변수
    		String jdbcDriver = "jdbc:mysql://127.0.0.1:3306/testdb?useUnicode=true&characterEncoding=utf8"; //연결 String
            String user = "root"; //ID
    		String pw = "1234"; //비밀번호
     		String query = "INSERT INTO tList(Name, Password, Title, Content) "
     				+ " VALUES(?, ?, ?, ?)";
     		
     		//SQL 연결 및 쿼리 준비
     		conn = DriverManager.getConnection(jdbcDriver, user, pw);
     		pstmt = conn.prepareStatement(query);
     		pstmt.setString(1, name);
     		pstmt.setString(2, password);
     		pstmt.setString(3, title);
     		pstmt.setString(4, content);
     		
     		//쿼리 실행 및 상태 확인
     		int cnt = pstmt.executeUpdate();
     		if(cnt > 0) out.println("글 게시 완료되었습니다.");
     		else out.println("글 게시 실패하였습니다.");
     		
     		//메인으로 가기 버튼
     		out.println("<input type='button' value='메인으로 가기' onclick=\"location = 'index.jsp'\">");
    	}
    	catch (SQLException ex) //SQL 연결 도중 에러 발생 시
    	{
    		out.println("에러 발생 : " + ex.getMessage());
    	}
    	finally //SQL 연결 관련 변수 Close
    	{
    		if(pstmt != null)
    		{
    			try
    			{
    				pstmt.close();
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