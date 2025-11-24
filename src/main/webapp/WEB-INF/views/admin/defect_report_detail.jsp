<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 - 결함 신고 상세</title>
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
        .image-gallery {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }
        .image-gallery img {
            max-width: 150px;
            height: auto;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<%@ include file="../fragment/adminheader.jsp" %>
<div class="container admin-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>결함 신고 상세 #${report.id}</h3>
        <a href="${pageContext.request.contextPath}/admin/defect_reports" class="btn btn-outline-secondary">목록으로</a>
    </div>

    <%-- 메시지 표시 부분 제거 --%>

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

    <c:if test="${not empty report.images}">
        <div class="detail-item">
            <div class="detail-label mb-2">첨부 이미지</div>
            <div class="image-gallery">
                <c:forEach items="${report.images}" var="image">
                    <img src="/defect_images/${image.fileName}" alt="결함 이미지">
                </c:forEach>
            </div>
        </div>
    </c:if>

    <hr class="my-4">

    <form action="${pageContext.request.contextPath}/admin/defect_reports/update-status" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="id" value="${report.id}">
        <div class="form-group row">
            <label for="statusSelect" class="col-md-3 col-form-label">처리 상태</label>
            <div class="col-md-6">
                <select class="form-control" id="statusSelect" name="status">
                    <option value="접수" ${report.status == '접수' ? 'selected' : ''}>접수</option>
                    <option value="처리중" ${report.status == '처리중' ? 'selected' : ''}>처리중</option>
                    <option value="완료" ${report.status == '완료' ? 'selected' : ''}>완료</option>
                    <option value="반려" ${report.status == '반려' ? 'selected' : ''}>반려</option>
                </select>
            </div>
            <div class="col-md-3">
                <button type="submit" class="btn btn-primary btn-block">상태 변경</button>
            </div>
        </div>
    </form>
</div>
<%@ include file="../fragment/footer.jsp" %>

<script>
    // 페이지 로드 시 메시지 팝업
    window.onload = function() {
        <c:if test="${not empty message}">
            alert("${message}");
        </c:if>
        <c:if test="${not empty errorMessage}">
            alert("오류: ${errorMessage}");
        </c:if>
    };
</script>
</body>
</html>