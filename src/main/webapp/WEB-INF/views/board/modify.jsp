<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>

</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Register</div>
			<div class="panel-body">


				<form action="/board/modify" role='form' method="post">
					<input type="hidden" name='pageNum'
						value='<c:out value="${cri.pageNum}"/>'> <input
						type="hidden" name='amount' value='<c:out value="${cri.amount}"/>'>
					<input type="hidden" name='type' value="<c:out value='${cri.amount}'/>">
					<input type="hidden" name='keyword' value="<c:out value='${cri.keyword}'/>">
					<div class="form-group">
						<label>글번호</label><input class="form-control" name="bno"
							value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>제목</label><input class="form-control" name="title"
							value='<c:out value="${board.title}"/>'>
					</div>
					<div class="form-group">
						<label>글내용</label>
						<textarea class="form-control" row="3" name="content"><c:out
								value="${board.content }" /></textarea>
					</div>
					<div class="form-group">
						<label>작성자</label><input class="form-control" name="writer"
							value='<c:out value="${board.writer }"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label>등록일</label> <input class="form-control" name='regdate'
							value='<fmt:formatDate value="${board.regdate }" pattern="yyyy/MM/dd"/>'
							readonly="readonly" />
					</div>

					<div class="form-group">
						<label>수정일</label> <input class="form-control" name='updateDate'
							value='<fmt:formatDate value="${board.updateDate }" pattern="yyyy/MM/dd"/>'
							readonly="readonly" />
					</div>

					<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
					<button type="submit" data-oper='remove' class='btn btn-danger'>지우기</button>
					<button type="submit" data-oper='list' class="btn btn-info">리스트보기</button>
				</form>
			</div>
		</div>
	</div>

</div>

<script>
	$(document).ready(function() {
		var formobj = $("form");

		$('button').on('click', function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");

			console.log(operation);

			if (operation === 'remove') {
				formobj.attr('action', '/board/remove');
			} else if (operation === 'list') {
				formobj.attr("action", "/board/list").attr("method", "get");
				/* 페이지 번호와 amount값을 복사해두고
				form 태그 내부를 비운후 다시 (주목적 :bno값 날리기위해서)
				다시 pageNum amount 를 첨부해서 list요청!*/
				var pageNumTag = $('input[name="pageNum"]').clone();
				var amountTag = $('input[name="amount"]').clone();
				var keywordTag = $('input[name="keyword"]').clone();
				var typeTag = $('input[name="type"]').clone();

			
				
				formobj.empty();
				formobj.append(pageNumTag);
				formobj.append(amountTag);
				formobj.append(keywordTag);
				formobj.append(typeTag);
			}
			formobj.submit();

		});

	});
</script>
<%@ include file="../includes/footer.jsp"%>