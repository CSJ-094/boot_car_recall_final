<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>통합 검색 결과 - 자동차 리콜 통합센터</title>
    <link rel="stylesheet" href="/css/main.css" />
    <style>
        .search-results-container { max-width: 900px; margin: 50px auto; padding: 30px; }
        .search-query { font-size: 1.8rem; font-weight: bold; color: #007bff; margin-bottom: 30px; text-align: center; }
        .search-query small { font-size: 1rem; color: #666; font-weight: normal; }
        .results-section { margin-bottom: 40px; }
        .results-section h2 { font-size: 1.5rem; color: #333; border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 20px; }
        .result-list { list-style: none; padding: 0; }
        .result-item { padding: 10px 0; border-bottom: 1px solid #eee; }
        .result-item a { text-decoration: none; color: #333; font-size: 1.1rem; font-weight: 500; }
        .result-item a:hover { color: #0056b3; }
        .result-item .meta { font-size: 0.85rem; color: #888; margin-top: 5px; }
        .no-results { text-align: center; color: #888; padding: 50px; border: 1px dashed #ccc; border-radius: 8px; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

    <main class="container">
        <div class="search-results-container">
            <h1 class="search-query">
                '<c:out value="${results.query}"/>' <small>에 대한 통합 검색 결과입니다.</small>
            </h1>

            <c:if test="${results.isEmpty()}">
                <p class="no-results">모든 카테고리에서 검색 결과가 없습니다.</p>
            </c:if>

            <!-- 리콜 정보 결과 -->
            <c:if test="${not empty results.recalls}">
                <section class="results-section">
                    <h2>리콜 정보 (${results.recalls.size()}건)</h2>
                    <ul class="result-list">
                        <c:forEach var="item" items="${results.recalls}">
                            <li class="result-item">
                                <a href="<c:url value='/recall-status?keyword=${item.modelName}'/>"><c:out value="${item.maker} ${item.modelName}"/></a>
                                <div class="meta">리콜 사유: <c:out value="${item.recallReason}"/> | 리콜 시작일: <c:out value="${item.recallDate}"/></div>
                            </li>
                        </c:forEach>
                    </ul>
                </section>
            </c:if>

            <!-- 공지사항 결과 -->
            <c:if test="${not empty results.notices}">
                <section class="results-section">
                    <h2>공지사항 (${results.notices.size()}건)</h2>
                    <ul class="result-list">
                        <c:forEach var="item" items="${results.notices}">
                            <li class="result-item">
                                <a href="<c:url value='/notice/detail?notice_id=${item.notice_id}'/>"><c:out value="${item.title}"/></a>
                                <div class="meta">작성일: <c:out value="${item.created_at}"/></div>
                            </li>
                        </c:forEach>
                    </ul>
                </section>
            </c:if>

            <!-- 보도자료 결과 -->
            <c:if test="${not empty results.pressReleases}">
                <section class="results-section">
                    <h2>보도자료 (${results.pressReleases.size()}건)</h2>
                    <ul class="result-list">
                        <c:forEach var="item" items="${results.pressReleases}">
                            <li class="result-item">
                                <a href="<c:url value='/board/content_view?boardNo=${item.boardNo}'/>"><c:out value="${item.boardTitle}"/></a>
                                <div class="meta">작성일: <c:out value="${item.boardDate}"/></div>
                            </li>
                        </c:forEach>
                    </ul>
                </section>
            </c:if>

            <!-- FAQ 결과 -->
            <c:if test="${not empty results.faqs}">
                <section class="results-section">
                    <h2>FAQ (${results.faqs.size()}건)</h2>
                    <ul class="result-list">
                        <c:forEach var="item" items="${results.faqs}">
                            <li class="result-item">
                                <a href="<c:url value='/faq/detail?faq_id=${item.faq_id}'/>"><c:out value="${item.question}"/></a>
                            </li>
                        </c:forEach>
                    </ul>
                </section>
            </c:if>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
</body>
</html>
