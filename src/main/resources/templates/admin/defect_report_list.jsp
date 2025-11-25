<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 - 결함 신고 목록</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 30px;
        }
        .table-hover tbody tr:hover { cursor: pointer; }
        .pagination { justify-content: center; }
    </style>
</head>
<body>
<%@ include file="../fragment/adminheader.jsp" %>
<div class="container admin-container">
    <h3>결함 신고 목록</h3>
    <div class="search-container mb-3">
        <form action="${pageContext.request.contextPath}/admin/defect_reports" method="get" class="form-inline justify-content-end">
            <input type="text" class="form-control mr-2" name="keyword" placeholder="신고인, 모델, VIN 검색" value="${pageMaker.cri.keyword}">
            <button type="submit" class="btn btn-primary">검색</button>
        </form>
    </div>
    <table class="table table-hover mt-3">
        <thead class="thead-light text-center">
        <tr>
            <th>ID</th>
            <th>신고인</th>
            <th>차량 모델</th>
            <th>VIN</th>
            <th>신고일</th>
            <th>상태</th>
        </tr>
        </thead>
        <tbody class="text-center">
        <c:forEach var="report" items="${list}">
            <tr onclick="location.href='${pageContext.request.contextPath}/admin/defect_reports/${report.id}'">
                <td><c:out value="${report.id}"/></td>
                <td><c:out value="${report.reporterName}"/></td>
                <td><c:out value="${report.carModel}"/></td>
                <td><c:out value="${report.vin}"/></td>
                <td><fmt:formatDate value="${report.reportDate}" pattern="yyyy-MM-dd"/></td>
                <td>
                    <c:choose>
                        <c:when test="${report.status == '접수'}"><span class="badge badge-info">접수</span></c:when>
                        <c:when test="${report.status == '처리중'}"><span class="badge badge-warning">처리중</span></c:when>
                        <c:when test="${report.status == '완료'}"><span class="badge badge-success">완료</span></c:when>
                        <c:otherwise><span class="badge badge-secondary">${report.status}</span></c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty list}">
            <tr>
                <td colspan="6" class="text-center">등록된 결함 신고가 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <!-- Pagination -->
    <nav>
        <ul class="pagination">
            <c:if test="${pageMaker.prev}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/defect_reports?pageNum=${pageMaker.startPage - 1}&keyword=${pageMaker.cri.keyword}">이전</a>
                </li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/defect_reports?pageNum=${num}&keyword=${pageMaker.cri.keyword}">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/defect_reports?pageNum=${pageMaker.endPage + 1}&keyword=${pageMaker.cri.keyword}">다음</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
<%@ include file="../fragment/footer.jsp" %>
</body>
</html>