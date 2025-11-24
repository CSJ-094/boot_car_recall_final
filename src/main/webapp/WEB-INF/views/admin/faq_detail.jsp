<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FAQ 상세</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 30px;
        }
        .card-header { background-color: #f1f1f1; }
        .card-body { min-height: 300px; white-space: pre-wrap; }
    </style>
</head>
<body>
<%@ include file="../fragment/adminheader.jsp" %>
<div class="container admin-container">
    <h3>FAQ 상세</h3>
    <hr>
    <div class="card">
        <div class="card-header">
            <h4>
                <span class="badge badge-info mr-2">${faq.category}</span>
                ${faq.question}
            </h4>
        </div>
        <div class="card-body">
            ${faq.answer}
        </div>
        <div class="card-footer text-right">
            <a href="${pageContext.request.contextPath}/admin/faq/list?pageNum=${cri.pageNum}&amount=${cri.amount}" class="btn btn-secondary">목록</a>
            <a href="${pageContext.request.contextPath}/admin/faq/modify?faq_id=${faq.faq_id}&pageNum=${cri.pageNum}&amount=${cri.amount}" class="btn btn-primary">수정</a>
            <button type="button" class="btn btn-danger" onclick="deleteFaq()">삭제</button>
        </div>
    </div>
</div>

<form id="deleteForm" action="${pageContext.request.contextPath}/admin/faq/delete" method="post" style="display: none;">
    <input type="hidden" name="faq_id" value="${faq.faq_id}">
    <input type="hidden" name="pageNum" value="${cri.pageNum}">
    <input type="hidden" name="amount" value="${cri.amount}">
</form>

<script>
    function deleteFaq() {
        if (confirm("정말로 삭제하시겠습니까?")) {
            document.getElementById('deleteForm').submit();
        }
    }
</script>
<%@ include file="../fragment/footer.jsp" %>
</body>
</html>