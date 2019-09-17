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
	<h2>내가 추가한 여행지</h2>
	<table>
		<tr>
			<th>${userName}님</th>
		</tr>
		<tr>
			<th>추가한 목록</th>
		</tr>
		<c:forEach var="cartList" items="${cartList }">
			<tr>
				<td>${cartList.contentname}</td>
			</tr>
		</c:forEach>
	</table>


</body>
<%@ include file="../includes/footer.jsp"%>
</html>