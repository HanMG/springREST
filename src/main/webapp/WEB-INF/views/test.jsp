<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax Test Page</title>
<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
</head>
<body>
	<h2>Ajax Test Page</h2>
	<div>
		<div>
			REPLYER <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			REPLY TEXT <input type="text" name="replytext" id="newReplyText">
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>
	<ul id="replies">
	</ul>
</body>
<script>
	var bno = 829;
	function getAllList() {
		$.getJSON("/replies/all/" + bno, function(data) {

			console.log(data.length);

			var str = "";

			$(data).each(
					function() {
						str += "<li data-rno='"+this.rno+"' class='replyLi'>"
								+ this.rno + ":" + this.replytext + "</li>";
					});

			$("#replies").html(str);
		});
	}

	$("#replyAddBtn").on("click",function(){
		var replyer = $("#newReplyWriter").val();
		var replytext = $("#newReplyText").val();

		$.ajax({
			type:'post',
			url:'/replies',
			headers:{
				"Content-Type":"application/json",
				"X-HTTP-Method-Override":"POST"
			},
			dataType:'text',
			data:JSON.stringify({
				bno:bno,
				replyer:replyer,
				replytext:replytext
			}),
			success:function(result){
				if(result == 'success'){
					alert("등록 되었습니다.");
					getAllList();
				}
			}
		});
	});
</script>

</html>
