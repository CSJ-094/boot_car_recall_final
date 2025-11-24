<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>신고 상세 정보</title>
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
        .defect-detail-box {
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
    <div>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3>신고 상세 정보 #${report.id}</h3>
            <a href="${pageContext.request.contextPath}/admin/main" class="btn btn-outline-secondary">목록으로</a>
        </div>

        <div class="row detail-item">
            <div class="col-md-3 detail-label">신고인</div>
            <div class="col-md-9 font-weight-bold"><c:out value="${report.reporterName}"/></div>
        </div>
        <div class="row detail-item">
            <div class="col-md-3 detail-label">연락처</div>
            <div class="col-md-9 font-weight-bold"><c:out value="${report.contact}"/></div>
        </div>
        <div class="row detail-item">
            <div class="col-md-3 detail-label">차량 모델</div>
            <div class="col-md-9 font-weight-bold"><c:out value="${report.carModel}"/></div>
        </div>
        <div class="row detail-item">
            <div class="col-md-3 detail-label">차대번호(VIN)</div>
            <div class="col-md-9 font-weight-bold"><c:out value="${report.vin}"/></div>
        </div>
        <div class="row detail-item">
            <div class="col-md-3 detail-label">신고 시간</div>
            <div class="col-md-9 font-weight-bold"><fmt:formatDate value="${report.reportDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
        </div>
        <div class="detail-item">
            <div class="detail-label mb-2">상세 결함 내용</div>
            <div class="defect-detail-box"><c:out value="${report.defectDetails}"/></div>
        </div>
    </div>
</div>
<%@ include file="../fragment/footer.jsp" %>
</body>
</html>