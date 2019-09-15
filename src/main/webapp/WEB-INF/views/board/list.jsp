<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				DataTables Advanced Tables
				<button id="regBtn" type="button" class="bnt btn-xs pull-right">글등록</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%"
					class="table table-striped table-bordered table-hover"
					id="dataTables">
					<thead>
						<tr>
							<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<c:forEach items="${list}" var="board">
						<tr>
							<td><c:out value="${board.bno}" /></td>
							<td><a class='move' href='<c:out value="${board.bno}"/>'><c:out
										value="${board.title}" /></a></td>
							<td><c:out value="${board.writer}" /></td>
							<td><fmt:fomatDate pattern="yyyy-MM-dd"
									value="${board.regdate }" /></td>
							<td><fmt:formateDate pattern="yyyy-MM-dd"
									value="${board.updateDate}" /></td>
						</tr>
					</c:forEach>
				</table>
				<div class='row'>
					<div class='col-lg-12'>
						<form id='searchForm' action='/board/list' method="get">
							<select name='type'>
								<!--만약 해당 조건으로 검색되었다면 선택된 조건에 selected 속성이 적용이됨   -->
								<option value=""
									<c:out value="${pageMaker.cri.type == null? 'selected':''}"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T' ? 'selected':''}"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'? 'selected':''}"/>>내용</option>
								<option value="W"
									<c:out value="${pageMaker.cri.type eq 'W'? 'selected':''}"/>>작성자</option>
								<option value="TC"
									<c:out value="${pageMaker.cri.type eq 'TC'? 'selected':''}"/>>제목
									or 내용</option>
								<option value="TW"
									<c:out value="${pageMaker.cri.type eq 'TW'? 'selected':''}"/>>제목
									or 작성자</option>
								<option value="TWC"
									<c:out value="${pageMaker.cri.type eq 'TWC'? 'selected':''}"/>>제목
									or 내용 or 작성자</option>
							</select> <input type="text" name="keyword"
								value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
								type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
							<input type="hidden" name="amount"
								value="${pageMaker.cri.amount}">
							<button class="btn btn-default">검색</button>
						</form>
					</div>
				</div>


				<!--페이징 버튼 생성  -->
				<div class='pull-right'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a
								href="${pageMaker.startPage-1}">이전</a></li>
						</c:if>

						<c:forEach var="num" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}">
							<li
								class="paginate_button ${pageMaker.cri.pageNum==num? 'active' : ''}"><a
								href="${num}">${num}</a></li>
						</c:forEach>

						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage+1 }">다음</a></li>
						</c:if>
					</ul>
				</div>
				<!-- 페이지 끝 -->
			</div>
			<!-- /.table-responsive -->
		</div>
		<!-- /.panel-body -->
	</div>
	<!-- /.panel -->
</div>
<!-- /.col-lg-6 -->
<!--페이지 이동시 페이지 번호와 페이지당 보여줄개수 검색어 타입과 검색키워드 모두 전달하여서 
페이지 이동때마다 해당 정보 유지하여 출력할수있게 적용  -->
<form id='actionForm' action="/board/list" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type}'/>"> 
	<input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>">
</form>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">처리가 완료되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary">저장</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script>
	$(document)
			.ready(
					function() {

						var result = '<c:out value="${result}"/>';

						checkModal(result);

						history.replaceState({}, null, null);

						function checkModal(result) {
							if (result === '' || history.state) {
								console.log('history state 출력 : '
										+ history.state);
								console.log(history, history.length,
										history.state);
								console.log('history state 출력 : '
										+ typeof (history.state));
								console.log('history state 출력 : '
										+ JSON.stringify(history.state));
								/* list페이지에서 history를 초기화해줘서 뒤로가기해서 다시 여기로오면 state가 null이여서 
								모달창을 안띄어줌 그러나 글을 등록하면 list페이지 서비스때 checkModal 함수에서 result값이 있어서
								모달창을 실행해줌 그리고 나서는 어쨋듯 history를 초기화 해줌으로써 다음에 뒤로가기해서 브라우저상에서
								만 이동시에는 history.state 가 null로 되서 모달창이 안뜨게 방지함 */
								return;
							}
							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글" + parseInt(result)
												+ "번이 등록되었습니다.");
							}
							$('#myModal').modal("show");
						}
						;
						$('#regBtn').on('click', function() {

							self.location = "/board/register";
						});

						var actionForm = $("#actionForm");
						$('.paginate_button a').on(
								'click',
								function(e) {
									e.preventDefault();

									console.log('click');

									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));

									actionForm.submit();
								});

						$('.move')
								.on(
										'click',
										function(e) {
											e.preventDefault();
											actionForm
													.append("<input type='hidden' name='bno' value='"
															+ $(this).attr(
																	"href")
															+ "'> ");
											actionForm.attr("action",
													"/board/get");
											actionForm.submit();

										});

					});

	var searchForm = $('#searchForm');

	$('#searchForm button').on('click', function(e) {

		if (!searchForm.find("option:selected").val()) {
			alert('검색 종류를 선택하세요');
			return false;
		}

		if (!searchForm.find("input[name='keyword']").val()) {
			alert('키워드를 입력하세요');
			return false;
		}

		/* 검색버튼 클릭시 어디페이지에서 검색을 했던지간에 1페이지로 이동해서 검색결과를 받아보기위해서 이렇게 페이지 번호를 처리함  */
		searchForm.find('input[name="pageNum"]').val("1");
		e.preventDefault();

		searchForm.submit();

	});
</script>

<%@include file="../includes/footer.jsp"%>
