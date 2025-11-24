<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 작성</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 30px;
        }
    </style>
</head>
<body>
<%@ include file="../fragment/adminheader.jsp" %>

<div class="container admin-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>공지사항 작성</h3>
    </div>
    <hr>
    <form action="${pageContext.request.contextPath}/admin/notice/write" method="post">
        <input type="hidden" name="writer" value="${adminId}">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" id="content" name="content" rows="15" required></textarea>
        </div>
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="is_urgent" name="is_urgent" value="Y">
            <label class="form-check-label" for="is_urgent">긴급 공지로 등록</label>
        </div>
        <div class="text-right">
            <a href="${pageContext.request.contextPath}/admin/notice/list" class="btn btn-secondary">취소</a>
            <button type="submit" class="btn btn-primary ml-2">등록</button>
        </div>
    </form>
</div>
<%@ include file="../fragment/footer.jsp" %>
</body>
</html>