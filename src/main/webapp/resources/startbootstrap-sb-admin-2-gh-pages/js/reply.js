console.log("replyModule");

/* 즉시실행 함수 : 함수를 정의하자마자 바로 호출하는 것을 즉시 실행 함수 외부에서 호출가능 */
var replyService = (function() {
	function add(reply, callback) {
		console.log("reply.......");

		$.ajax({
			type : 'POST',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				error(er);
			}
		});
	}

	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		/* $.getJSON(url,callback) */
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
				if(callback){
					callback(data);
				}
				}).fail(function(xhr, status,err){
					if(error){
						error();
					}
				});
	}
	
	function remove(rno,callback,error){
		$.ajax({
			type : 'delete',
			url : '/replies/'+rno,
			success :  function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
				
			}, error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function update(reply, callback,error){
		console.log("RNO : "+reply.rno);
		
		$.ajax({
			type : 'PUT',
			url : '/replies/'+reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error :  function(xhr,status,err){
				if(error){
					error(err);
				}
			}
		});
		
	}
	
	function get(rno, callback, error){
		$.get("/replies/"+rno+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		})
	}
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get
	};
})();