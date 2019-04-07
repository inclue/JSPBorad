<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%-- charset을 utf-8로 설정 --%>

<!DOCTYPE html><%-- html 문서임을 알려줌 --%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><%-- charset을 utf-8로 설정 --%>
	<title>게시글 추가</title><%-- 제목 --%>
	<style><%-- css 속성 설정 --%>
      		.List { border-collapse:collapse; width:400px; }
	</style>
</head>
<body>
	<form method="post" action="insertQuery.jsp"> <%-- 글 등록 선택시 post 방식으로 insertQuery.jsp로 넘겨줌 --%>
		<table class='List'>
			<tr>
				<%-- 이름 --%>
				<td width='20%'>이름</td>
				<td width='30%'><input style='width:100%;' type='text' name='name' placeholder='이름' maxlength='15'></td>
				<%-- 비밀번호 --%>
				<td width='20%'>&nbsp;&nbsp;비밀번호</td>
				<td width='30%'><input style='width:100%;' type='password' name='password' placeholder='비밀번호' maxlength='15'></td>
			</tr>
			<tr>
				<%-- 제목 --%>
				<td width='20%'>제목</td>
				<td colspan='3'><input style='width:100%;' type='text' name='title' placeholder='제목'></td>
			</tr>
			<tr>
				<%-- 내용 --%>
				<td colspan='4'><textarea name='content' rows='15' cols='100'></textarea></td>
			</tr>
		</table>
		<input type="submit" value="글 등록">&nbsp; <%-- submit 선택시 해당 내용을 다른 페이지로 넘겨줌 --%>
		<input type="button" value="취소" onclick="location = 'index.jsp'"> <%-- 취소시 index.jsp로 넘겨줌 --%>
	</form>
</body>
</html>