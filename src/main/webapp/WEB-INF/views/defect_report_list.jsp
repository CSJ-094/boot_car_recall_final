<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결함 신고 목록</title>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/header.css" />
    <link rel="stylesheet" href="/css/footer.css" />
    <style>
        /* 이 페이지에만 적용될 추가적인 스타일 */
        .container { 
            padding-top: 50px; 
            padding-bottom: 50px; 
        }
        .search-container { 
            padding: 20px; 
            background: #fff; 
            margin-top: 20px; 
            border-radius: 8px; 
            box-shadow: 0 2px 4px rgba(0,0,0,0.1); 
            text-align: center; 
        }
        .search-container form { 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            max-width: 500px; 
            margin: 0 auto; 
        }
        .search-container input[type="text"] { 
            flex-grow: 1; 
            padding: 10px; 
            border: 1px solid #ddd; 
            border-radius: 4px; 
            margin-right: 10px; 
            min-width: 150px; 
        }
        .search-container button { 
            padding: 10px 20px; 
            background: #0d47a1; 
            color: white; 
            border: none; 
            cursor: pointer; 
            border-radius: 4px; 
        }
        table { width: 100%; margin-top: 20px; border-collapse: collapse; background: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.1); table-layout: fixed; }
        th, td { padding: 8px; border-bottom: 1px solid #ddd; text-align: left; vertical-align: middle; word-wrap: break-word; }
        th { background-color: #1e88e5; color: white; }
        tr:hover { background-color: #f1f1f1; }
        .col-small { width: 10%; }
        .col-medium { width: 15%; }
        .col-action { width: 10%; text-align: center; } /* 상세보기 버튼 컬럼 너비 및 정렬 */
        .col-id { text-align: center; } /* 신고번호 컬럼 가운데 정렬 */
        .pagination { text-align: center; margin-top: 20px; }
        .pagination a, .pagination strong { display: inline-block; padding: 5px 10px; margin: 0 2px; border: 1px solid #ddd; background-color: #fff; text-decoration: none; color: #337ab7; }
        .pagination strong { background-color: #337ab7; color: white; border-color: #337ab7; }
        .detail-btn { 
            display: inline-block; 
            padding: 5px 10px; 
            background-color: #0d47a1; 
            color: white; 
            text-decoration: none; 
            border-radius: 4px; 
            font-size: 0.9em;
        }
        .detail-btn:hover { background-color: #1565c0; }
        .csv-download-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 0.95em;
            margin-top: 10px;
            border: none;
            cursor: pointer;
        }
        .csv-download-btn:hover {
            background-color: #218838;
        }
        .button-container {
            text-align: center;
            margin-top: 10px;
        }
        .button-container a + a {
            margin-left: 10px;
        }
        .pdf-download-btn {
            background-color: #ff7043;
        }
        .pdf-download-btn:hover {
            background-color: #f4511e;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <div class="container">
        <div class="search-container">
            <form action="/report/history" method="get">
                <input type="text" id="searchInput" name="keyword" placeholder="신고인, 차량 모델, VIN으로 검색..." value="${pageMaker.cri.keyword}">
                <button type="submit">검색</button>
            </form>
        </div>
        
        <div class="button-container">
            <a href="/report/download/csv" class="csv-download-btn">📥 리콜 신청 내역 CSV 다운로드</a>
            <a href="/report/download/pdf" class="csv-download-btn pdf-download-btn">📄 리콜 신청 내역 PDF 다운로드</a>
        </div>

        <table id="reportTable">
            <thead>
                <tr>
                    <th class="col-small col-id">신고번호</th>
                    <th class="col-small">신고인</th>
                    <th class="col-medium">차량 모델</th>
                    <th class="col-medium">차대번호</th>
                    <th>결함 내용</th>
                    <th class="col-medium">신고일</th>
                    <th class="col-action"></th> <!-- 상세보기 버튼을 위한 컬럼 -->
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${reportList}" var="report">
                    <tr>
                        <td class="col-id">${report.id}</td>
                        <td>${report.reporterName}</td>
                        <td>${report.carModel}</td>
                        <td>${report.vin}</td>
                        <td>${report.defectDetails}</td>
                        <td><fmt:formatDate value="${report.reportDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td class="col-action"><a href="/report/detail?id=${report.id}" class="detail-btn">상세보기</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <c:if test="${pageMaker.prev}">
                <a href="/report/history?pageNum=${pageMaker.startPage - 1}&keyword=${pageMaker.cri.keyword}">&laquo;</a>
            </c:if>

            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
                <c:choose>
                    <c:when test="${pageMaker.cri.pageNum == num}">
                        <strong>${num}</strong>
                    </c:when>
                    <c:otherwise>
                        <a href="/report/history?pageNum=${num}&keyword=${pageMaker.cri.keyword}">${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${pageMaker.next}">
                <a href="/report/history?pageNum=${pageMaker.endPage + 1}&keyword=${pageMaker.cri.keyword}">&raquo;</a>
            </c:if>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
</body>
</html>
