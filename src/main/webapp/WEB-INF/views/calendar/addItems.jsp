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
	<form action="/calendar/addTocart" method="POST" id="formAction">
		<h2>경복궁</h2>
		<input type="hidden" name="contentname" value="경복궁"> <input
			type="hidden" name="content_id" value="112233"> <input
			type="hidden" name="contenttypeid" value="88888">
		<button class="btn btn-danger" id="addTocart">찜하기</button>
	</form>
	<%@ include file="../includes/footer.jsp"%>
</body>
<script>
	$(function() {
		$("#addTocart").on('click', function(e) {
			$('formAction').submit();
		});

		var result = '${result}';
		if(result!==null){
			alert(result +'이미 추가 되었습니다.');
			self.location ="/calendar/showCart";
		}

	});
</script>
</html>