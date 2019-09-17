<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="text-align: center;">
		<h1>나의 캘린더</h1>
	</div>
	<h3>${year}년${month}월</h3>
	<table border="1">
		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
		</tr>
		<tr>
			<c:if test="${frist <= 6}">
				<c:forEach begin="0" end="${frist-1}" step="1">
					<th></th>
				</c:forEach>
			</c:if>
			<c:forEach begin="1" end="${frist-1}" step="1" varStatus="status">
				<th>${status.index}</th>
			</c:forEach>
		</tr>



	</table>

</body>
<%@ include file="../includes/footer.jsp"%>
</html>