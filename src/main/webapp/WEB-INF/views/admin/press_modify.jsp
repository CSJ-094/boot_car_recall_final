<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>리콜 보도자료 수정</title>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
	<script src="${pageContext.request.contextPath}/js/jquery.js"></script>

	<style>
		body {
			font-family: "Noto Sans KR", sans-serif;
			margin: 0;
			background-color: #f8f9fa;
		}

		.container {
			width: 70%;
			margin: 50px auto;
			background: #fff;
			border-radius: 10px;
			box-shadow: 0 2px 8px rgba(0,0,0,0.1);
			padding: 40px 50px;
		}

		h2 {
			text-align: center;
			margin-bottom: 30px;
			font-size: 26px;
		}

		hr {
			border: none;
			border-top: 1px solid #ddd;
			margin: 20px 0;
		}

		.form-group {
			margin-bottom: 20px;
		}

		label {
			display: block;
			font-weight: 600;
			margin-bottom: 8px;
			color: #333;
		}

		input[type="text"],
		textarea {
			width: 100%;
			padding: 10px 12px;
			border: 1px solid #ccc;
			border-radius: 6px;
			font-size: 15px;
			box-sizing: border-box;
		}

		textarea {
			resize: none;
			height: 200px;
			line-height: 1.6;
		}

		.btn-area {
			text-align: center;
			margin-top: 30px;
		}

		.btn-primary {
			background-color: #007bff;
			color: white;
			border: none;
			padding: 10px 20px;
			font-size: 15px;
			border-radius: 6px;
			cursor: pointer;
			transition: background-color 0.2s ease;
		}

		.btn-primary:hover {
			background-color: #0056b3;
		}

		.btn-secondary {
			display: inline-block;
			background-color: #6c757d;
			color: white;
			text-decoration: none;
			padding: 10px 20px;
			font-size: 15px;
			border-radius: 6px;
			margin-left: 10px;
			transition: background-color 0.2s ease;
		}

		.btn-secondary:hover {
			background-color: #565e64;
		}

		.post-info {
			font-size: 14px;
			color: #666;
			margin-bottom: 15px;
		}
	</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/fragment/adminheader.jsp"/>

<div class="container">
	<h2>리콜 보도자료 수정</h2>
	<hr>

	<form method="post" action="/admin/press/modify">
		<input type="hidden" name="boardNo" value="${board.boardNo}">
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">

		<div class="form-group">
			<label>작성자</label>
			<input type="text" name="boardName" value="${board.boardName}" readonly>
		</div>

		<hr>

		<div class="form-group">
			<label>첨부된 파일</label>
			<div class="uploadResult">
				<ul></ul>
			</div>
		</div>

		<div class="form-group">
			<label>새 파일 업로드</label>
			<input type="file" name="uploadFile" id="uploadFile" multiple>
		</div>

		<hr>

		<div class="form-group">
			<label>제목</label>
			<input type="text" name="boardTitle" value="${board.boardTitle}">
		</div>

		<hr>

		<div class="form-group">
			<label>내용</label>
			<textarea name="boardContent">${board.boardContent}</textarea>
		</div>

		<hr>

		<div class="btn-area">
			<input type="submit" value="수정완료" class="btn-primary">
			<a href="/admin/press/detail?boardNo=${board.boardNo}&pageNum=${cri.pageNum}&amount=${cri.amount}" class="btn-secondary">취소</a>
		</div>
	</form>
</div>
</body>
</html>
<script>
	$(document).ready(function() {
		const boardNo = "${board.boardNo}";

		$.getJSON("/getFileList", { boardNo: boardNo }, function(arr) {
			let str = "";
			$(arr).each(function(i, obj) {
				const path = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
				str += "<li data-uuid='" + obj.uuid + "'>";
				str += "<span>" + obj.fileName + "</span>";
				if (obj.image) {
					str += "<img src='/display?fileName=" + path + "' width='60'>";
				} else {
					str += "<img src='${pageContext.request.contextPath}/img/attach.png' width='20'>";
				}
				str += " <button type='button' class='delete-old' data-uuid='" + obj.uuid + "'>삭제</button>";
				str += "</li>";
			});
			$(".uploadResult ul").html(str);
		});

		$(".uploadResult").on("click", ".delete-old", function() {
			const uuid = $(this).data("uuid");
			if (confirm("이 파일을 삭제하시겠습니까?")) {
				$.ajax({
					type: "post",
					url: "/deleteFile",
					data: { uuid: uuid },
					success: function() {
						alert("파일 삭제 완료");
						location.reload();
					},
					error: function() {
						alert("파일 삭제 실패");
					}
				});
			}
		});

		// ✅ 새 파일 업로드 Ajax
		$("input[type='file']").change(function(e) {
			const uploadUL = $(".uploadResult ul");
			const formData = new FormData();
			const files = this.files;
			for (let i = 0; i < files.length; i++) {
				formData.append("uploadFile", files[i]);
			}

			$.ajax({
				type: "post",
				url: "/uploadFolder",
				data: formData,
				processData: false,
				contentType: false,
				success: function() {
					alert("파일 업로드 완료");
					location.reload();
				},
				error: function() {
					alert("업로드 실패");
				}
			});
		});
	});
</script>












