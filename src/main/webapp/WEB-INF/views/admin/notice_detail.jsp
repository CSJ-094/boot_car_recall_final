<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 30px;
        }
        .detail-header {
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 1rem;
            margin-bottom: 1.5rem;
        }
        .detail-content {
            min-height: 300px;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
<%@ include file="../fragment/adminheader.jsp" %>
<div class="container admin-container">
    <div class="detail-header">
        <h4>
            <c:if test="${notice.is_urgent == 'Y'}"><span class="badge badge-danger mr-2">긴급</span></c:if>
            <c:out value="${notice.title}"/>
        </h4>
        <div class="d-flex justify-content-between text-muted small mt-2">
            <span>조회수: <c:out value="${notice.views}"/></span>
            <span>작성일:
                <fmt:parseDate value="${notice.created_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
            </span>
        </div>
    </div>
    <div class="detail-content mb-4">
        <c:out value="${notice.content}"/>
    </div>
    <div class="text-right">
        <a href="${pageContext.request.contextPath}/admin/notice/list?pageNum=${cri.pageNum}&amount=${cri.amount}" class="btn btn-secondary">목록</a>
        <a href="${pageContext.request.contextPath}/admin/notice/modify?notice_id=${notice.notice_id}&pageNum=${cri.pageNum}&amount=${cri.amount}" class="btn btn-primary">수정</a>
        <button type="button" class="btn btn-danger" onclick="deleteNotice()">삭제</button>
    </div>
</div>

<form id="deleteForm" action="${pageContext.request.contextPath}/admin/notice/delete" method="post" style="display: none;">
    <input type="hidden" name="notice_id" value="<c:out value='${notice.notice_id}'/>">
    <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
    <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
</form>

<script>
    function deleteNotice() {
        if (confirm("정말로 삭제하시겠습니까?")) {
            document.getElementById('deleteForm').submit();
        }
    }
</script>
<%@ include file="../fragment/footer.jsp" %>
</body>
</html>