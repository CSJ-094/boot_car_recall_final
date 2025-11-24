<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객 문의 목록</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 30px;
        }
        .table-hover tbody tr:hover { cursor: pointer; }
    </style>
</head>
<body>
<%@ include file="../fragment/adminheader.jsp" %>
<div class="container admin-container">
    <h2>고객 문의 목록</h2>
    <table class="table table-hover mt-3">
        <thead class="thead-light text-center">
        <tr>
            <th>문의번호</th>
            <th>제목</th>
            <th>신고인</th>
            <th>문의유형</th>
            <th>작성일</th>
            <th style="width: 10%;">답변상태</th>
        </tr>
        </thead>
        <tbody class="text-center">
        <c:forEach var="item" items="${list}">
            <tr onclick="location.href='${pageContext.request.contextPath}/admin/complain/detail?report_id=${item.report_id}'">
                <td><c:out value="${item.report_id}"/></td>
                <td class="text-left"><c:out value="${item.title}"/></td>
                <td><c:out value="${item.reporter_name}"/></td>
                <td><c:out value="${item.complain_type}"/></td>
                <td>
                    <fmt:parseDate value="${item.complainDate}" pattern="yyyy-MM-dd HH:mm" var="parsedDate" type="both"/>
                    <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"/>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty item.answer}">
                            <span class="badge badge-success">답변 완료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-warning">답변 대기</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<%@ include file="../fragment/footer.jsp" %>
</body>
</html>