<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>${content_view.boardTitle}</title>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
	<script src="${pageContext.request.contextPath}/js/jquery.js"></script>

	<style>
		body {
			font-family: "Noto Sans KR", sans-serif;
			margin: 0;
			background-color: #f8f9fa;
		}

		.container {
			width: 80%;
			margin: 40px auto;
			background: #fff;
			border-radius: 10px;
			box-shadow: 0 2px 8px rgba(0,0,0,0.1);
			padding: 30px 50px;
		}

		h2 {
			text-align: center;
			margin-bottom: 30px;
			font-size: 26px;
			color: #333;
		}

		hr {
			border: none;
			border-top: 1px solid #ddd;
			margin: 20px 0;
		}

		.info-line {
			display: flex;
			justify-content: space-between;
			color: #666;
			font-size: 15px;
		}

		.uploadResult {
			margin-top: 15px;
		}

		.uploadResult ul {
			list-style: none;
			padding: 0;
		}

		.uploadResult li {
			display: flex;
			align-items: center;
			margin: 8px 0;
			cursor: pointer;
			color: #007bff;
			transition: all 0.2s ease;
		}

		.uploadResult li:hover {
			text-decoration: underline;
		}

		.uploadResult img {
			margin-left: 10px;
			border-radius: 4px;
		}

		.content {
			margin-top: 30px;
			line-height: 1.7;
			color: #333;
			font-size: 16px;
		}

		.bigPicture {
			position: fixed;
			display: none;
			justify-content: center;
			align-items: center;
			top: 0; left: 0; right: 0; bottom: 0;
			background-color: rgba(0,0,0,0.8);
			z-index: 100;
		}

		.bigPic img {
			max-width: 80%;
			max-height: 80%;
			border-radius: 10px;
		}

		.actions {
			display: flex;
			justify-content: center;
			gap: 15px;
			margin-top: 40px;
		}

		.actions a {
			text-decoration: none;
			color: white;
			background-color: #007bff;
			padding: 10px 20px;
			border-radius: 6px;
			transition: background-color 0.2s ease;
		}

		.actions a:hover {
			background-color: #0056b3;
		}
	</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/fragment/adminheader.jsp"/>

<div class="container">
	<h2>${board.boardTitle}</h2>

	<hr>

	<div class="info-line">
		<div><strong>작성자</strong> | ${board.boardName}</div>
		<div><strong>조회수</strong> | ${board.hit}</div>
	</div>

	<hr>

	<div class="info-line">
		<div><strong>작성일</strong> | ${board.boardDate}</div>
	</div>

	<hr>

	<div class="uploadResult">
		<ul></ul>
	</div>

	<div class="bigPicture">
		<div class="bigPic"></div>
	</div>

	<hr>

	<div class="content">
		${board.boardContent}
	</div>


	<div class="actions">
		<a href="/admin/press/list?pageNum=${cri.pageNum}&amount=${cri.amount}">목록으로</a>
		<a href="/admin/press/modify?boardNo=${board.boardNo}&pageNum=${cri.pageNum}&amount=${cri.amount}">수정</a>
		<a href="#" id="deleteBtn">삭제</a>
	</div>

	<%--    BoardController에 report_delete 메소드 호출용--%>
	<form action="/admin/press/delete" method="post" id="deleteForm">
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">
		<input type="hidden" name="boardNo" value="${board.boardNo}">
	</form>
</div>

<script>
	$(document).ready(function() {
		const boardNo = "${board.boardNo}";

		$.getJSON("/getFileList", { boardNo: boardNo }, function(arr) {
			let str = "";
			$(arr).each(function(i, obj) {
				const path = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
				str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
				str += "<span>" + obj.fileName + "</span>";

				if (obj.image) {
					str += "<img src='/display?fileName=" + path + "' width='80'>";
				} else {
					str += "<img src='${pageContext.request.contextPath}/img/attach.png' width='25'>";
				}

				str += "</li>";
			});
			$(".uploadResult ul").html(str);
		});

		$(".uploadResult").on("click", "li", function() {
			const liObj = $(this);
			const path = liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename");
			if (liObj.data("type")) {
				showImage(path);
			} else {
				self.location = "/download?fileName=" + path;
			}
		});

		function showImage(fileCallPath) {
			$(".bigPicture").css("display", "flex").show();
			$(".bigPic").html("<img src='/display?fileName=" + fileCallPath + "'>")
					.animate({width: "100%", height: "100%"}, 400);
		}

		$(".bigPicture").on("click", function() {
			$(".bigPic").animate({width: "0%", height: "0%"}, 400);
			setTimeout(function() { $(".bigPicture").hide(); }, 400);
		});

		$("#deleteBtn").on("click", function(e){
			e.preventDefault();
			if(confirm("삭제하시겠습니까?")){
				$("#deleteForm").submit();
			}
		});
	});
</script>

</body>
</html>