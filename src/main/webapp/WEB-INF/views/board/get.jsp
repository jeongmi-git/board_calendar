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

				<div class="form-group">
					<label>글번호</label><input class="form-control" name="bno"
						value='<c:out value="${board.bno}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>제목</label><input class="form-control" name="title"
						value='<c:out value="${board.title}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>글내용</label>
					<textarea class="form-control" row="3" name="content"
						readonly="readonly"><c:out value="${board.content }" /></textarea>
				</div>
				<div class="form-group">
					<label>작성자</label><input class="form-control" name="writer"
						value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>


				<button data-oper='modify' class="btn btn-default">수정</button>
				<button data-oper='list' class="btn btn-info">리스트보기</button>
				<form id='operForm' action='/board/modify' method="get">
					<input type="hidden" id='bno' name='bno'
						value="<c:out value='${board.bno}'/>" /> <input type="hidden"
						id='pageNum' name='pageNum'
						value="<c:out value='${cri.pageNum}'/>" /> <input type="hidden"
						id='amount' name='amount' value="<c:out value='${cri.amount}'/>" />
					<!--컨트롤러에서 ModelAttribute에서 넘겨준 Criteria 객체사용  -->

					<input type="hidden" name="keyword"
						value="<c:out value='${cri.keyword}'/>"> <input
						type="hidden" name="type" value='${cri.type}'>
					<!-- 조회 페이지에서 검색 처리 하기위해서 검색어랑 타입을 같이 첨부함   -->
				</form>

			</div>
		</div>
	</div>

</div>
<script type="text/javascript"
	src="/resources/startbootstrap-sb-admin-2-gh-pages/js/reply.js"></script>

<script type="text/javascript">
	$(document).ready(function() {

		console.log("==============");
		console.log("JS TEST");

		var bnoValue = '<c:out value ="${board.bno}"/>';

		replyService.add({
			reply : "JS Test",
			replyer : "tester",
			bno : bnoValue
		}, function(result) {
			alert("RESULT : " + result);
		}

		);
		replyService.getList({
			bno : bnoValue,
			page : 1
		}, function(list) {
			for (var i = 0, len = list.length || 0; i < len; i++) {
				console.log(list[i]);
			}
		});

	/* 	replyService.remove(2, function(count) {
			console.log(count);

			if (count == 'success') {
				alert("삭제되었습니다.");
			}
		}, function(err) {
			alert('삭제실패');
		});
		 */
		replyService.update({
			rno : 1,
			bno : bnoValue,
			reply : 'Modified reply..'
		},  function(result){
			alert('수정완료');
		});
		
		replyService.get(10,function(data){
			console.log(data);
		});
		var operation = $('#operForm');
		$('button[data-oper="modify"]').on('click', function(e) {
			operation.attr("action", "/board/modify").submit();

		});

		$("button[data-oper='list']").on('click', function(e) {
			operation.find("#bno").remove();
			operation.attr("action", "/board/list");
			operation.submit();

		});
	});
</script>
<%@ include file="../includes/footer.jsp"%>