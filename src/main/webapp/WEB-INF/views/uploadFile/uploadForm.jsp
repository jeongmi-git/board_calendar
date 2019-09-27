<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="uploadFormAction" method="post"
		enctype="multipart/form-data">
		<input type="file" name="uploadFile" multiple="multiple">
		<!--multiple boolean의 속성을 가지고 해당속성을 명시하면 true반환
		또한 여러개의 파일을 업로드 할수있음   -->
		<button>저장</button>
	</form>

</body>
</html>