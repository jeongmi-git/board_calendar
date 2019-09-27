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
	<h1>Upload With Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>

	<button id='uploadBtn'>업로드하기</button>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
		crossorigin="anonymous"></script>

	<script>
		$(document).ready(function() {
			// 파일의 확장자나 크기를 사전에 처리하기
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; //5MB
			function checkExtension(fileName, fileSize) {
				if (fileSize >= maxSize) {
					alert("파일 사이즈 초과 ");
					return false;
				}
				if (regex.test(fileName)) {
					alert("해당 종류 파일은 업로드 할수없습니다.");
					return false;
				}
				return true;
			}

			$("#uploadBtn").on('click', function(e) {
				// Ajax에서는 폼태그 없이 데이터 제출할때 FormData사용함(폼태그를 사용하면 화면전환이 이루어지는데)
				// ajax는 화면전환없이 데이터 전송을 하는것이 때문에 FormData 객체 사용하는것임
				// jquery 는 FormData라는 객체(가상의 form 태그)를 이용해서
				// 필요한 파라메타를 담아서 전송함
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;
				console.log(files);

				for (var i = 0; i < files.length; i++) {
					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}
					formData.append("uploadFile", files[i]);
				}
				// formData 자체를 전송합니다 
				// 그래서 processData 와 contentType은 반드시 false로 지정
				$.ajax({
					url : '/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					success : function(result) {
						alert("Uploaded");
					}
				});

			});

		});
	</script>
</body>


<%@ include file="../includes/footer.jsp"%>
</html>