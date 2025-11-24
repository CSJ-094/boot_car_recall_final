<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FAQ 관리</title>
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>FAQ 관리</h3>
        <a href="${pageContext.request.contextPath}/admin/faq/write" class="btn btn-primary">새 FAQ 작성</a>
    </div>

    <table class="table table-hover text-center">
        <thead class="thead-light">
        <tr>
            <th style="width: 10%;">번호</th>
            <th style="width: 20%;">카테고리</th>
            <th style="width: 55%;">질문</th>
            <th style="width: 15%;">작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${list}">
            <tr onclick="location.href='${pageContext.request.contextPath}/admin/faq/detail?faq_id=${item.faq_id}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}'" style="cursor: pointer;">
                <td>${item.faq_id}</td>
                <td><span class="badge badge-info">${item.category}</span></td>
                <td class="text-left">${item.question}</td>
                <td>
                    <fmt:parseDate value="${item.created_at}" pattern="yyyy-MM-dd" var="parsedDate" type="date"/>
                    <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty list}">
            <tr>
                <td colspan="4">등록된 FAQ가 없습니다.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <!-- Pagination -->
    <nav>
        <ul class="pagination">
            <c:if test="${pageMaker.prev}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/faq/list?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}">이전</a>
                </li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/faq/list?pageNum=${num}&amount=${pageMaker.cri.amount}">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next}">
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/faq/list?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}">다음</a>
                </li>
            </c:if>
        </ul>
    </nav>
    <!-- /Pagination -->
</div>
<%@ include file="../fragment/footer.jsp" %>
</body>
</html>