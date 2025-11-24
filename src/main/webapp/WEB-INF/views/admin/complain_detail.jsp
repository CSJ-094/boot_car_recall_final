<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객 문의 상세</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 30px;
        }
        .detail-item {
            margin-bottom: 1rem;
        }
        .detail-content-box {
            white-space: pre-wrap;
            padding: 15px;
            border-radius: 5px;
            min-height: 150px;
            border: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
<%@ include file="../fragment/adminheader.jsp" %>
<div class="container admin-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>고객 문의 상세 #${complain.report_id}</h3>
        <a href="${pageContext.request.contextPath}/admin/complain/list" class="btn btn-outline-secondary">목록으로</a>
    </div>

    <div class="row detail-item">
        <div class="col-md-2 detail-label">문의유형</div>
        <div class="col-md-10 font-weight-bold"><c:out value="${complain.complain_type}"/></div>
    </div>
    <div class="row detail-item">
        <div class="col-md-2 detail-label">신고인</div>
        <div class="col-md-4 font-weight-bold"><c:out value="${complain.reporter_name}"/></div>
        <div class="col-md-2 detail-label">작성일</div>
        <div class="col-md-4 font-weight-bold">
            <fmt:parseDate value="${complain.complainDate}" pattern="yyyy-MM-dd HH:mm" var="parsedDate" type="both"/>
            <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
    </div>
    <div class="row detail-item">
        <div class="col-md-2 detail-label">제목</div>
        <div class="col-md-10 font-weight-bold"><c:out value="${complain.title}"/></div>
    </div>
    <div class="detail-item">
        <div class="row">
            <div class="col-md-2 detail-label">문의 내용</div>
            <div class="col-md-10 detail-content-box bg-light"><c:out value="${complain.content}"/></div>
        </div>
    </div>

    <hr class="my-4">

    <div class="detail-item">
        <div class="row">
            <div class="col-md-2 detail-label">답변 내용</div>
            <div class="col-md-10 detail-content-box font-weight-bold <c:if test='${empty complain.answer}'>text-muted</c:if>"><c:out value="${not empty complain.answer ? complain.answer : '아직 등록된 답변이 없습니다.'}"/></div>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/admin/complain/answer" method="post" class="mt-4">
        <input type="hidden" name="report_id" value="<c:out value='${complain.report_id}'/>">
        <div class="form-group">
            <label for="answerTextarea">답변 등록 및 수정</label>
            <textarea id="answerTextarea" name="answer" class="form-control" rows="5" placeholder="답변을 입력하세요..."><c:out value="${complain.answer}"/></textarea>
        </div>
        <div class="text-right">
            <button type="submit" class="btn btn-primary">답변 저장</button>
        </div>
    </form>
</div>
<%@ include file="../fragment/footer.jsp" %>
</body>
</html>