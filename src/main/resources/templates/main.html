<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>자동차 리콜 통합센터</title>

    <link rel="stylesheet" href="/css/main.css" />
</head>
<body data-contextpath="">

<jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

<div class="hero">
    <h2>내 차량이 리콜 대상인지 확인하세요</h2>
    <div class="search-form">
        <form action="/" method="get">
            <input type="text" name="query" placeholder="차량 모델명 또는 제조사 입력" value="<c:out value="${searchQuery}"/>" />
            <button type="submit">검색</button>
        </form>
    </div>
</div>

<c:if test="${not empty searchResults}">
    <section class="section-search-results">
        <div class="container">
            <h3>'${searchQuery}' 검색 결과</h3>
            <c:choose>
                <c:when test="${not empty searchResults.recallList}">
                    <div class="table-responsive">
                        <table>
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>제조사</th>
                                <th>모델명</th>
                                <th>생산 시작일</th>
                                <th>생산 종료일</th>
                                <th>리콜 날짜</th>
                                <th>리콜 사유</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="recall" items="${searchResults.recallList}">
                                <tr>
                                    <td><c:out value="${recall.id}"/></td>
                                    <td><c:out value="${recall.maker}"/></td>
                                    <td><c:out value="${recall.modelName}"/></td>
                                    <td><c:out value="${recall.makeStart}"/></td>
                                    <td><c:out value="${recall.makeEnd}"/></td>
                                    <td><c:out value="${recall.recallDate}"/></td>
                                    <td><c:out value="${recall.recallReason}"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="no-results">'${searchQuery}'에 대한 검색 결과가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</c:if>

<section class="section-center-hero">
    <div class="hero-carousel" data-autoplay="true" data-interval="3000" aria-roledescription="carousel">
        <div class="hero-track">
            <img src="/img/main1.png" alt="리콜 접수 및 안내 장면">
            <img src="/img/main2.png" alt="전문 정비사가 점검 중인 모습">
            <img src="/img/main3.png" alt="서비스 완료 후 안전 주행">
        </div>

        <button class="hero-nav prev" aria-label="이전 슬라이드">&#10094;</button>
        <button class="hero-nav next" aria-label="다음 슬라이드">&#10095;</button>

        <div class="showcase-panel">
            <div class="panel-top">
                <h3 class="panel-title">자동차 리콜센터</h3>
                <p class="panel-desc">
                    정부와 제조사가 함께 운영하는 공식 리콜 서비스입니다.<br>
                    전국 어디서나 가까운 지정 센터에서 신속하고 투명한 절차로 무료 수리를 제공합니다.
                </p>
            </div>
            <div class="panel-bottom">
                <div class="chips">
                    <span class="chip">#정부인증</span>
                    <span class="chip">#무료수리</span>
                    <span class="chip">#전국센터</span>
                    <span class="chip">#실시간조회</span>
                </div>
                <div class="panel-cta">
                    <a class="btn-ghost" href="/recall-status">리콜현황 보기</a>
                    <a class="btn-solid" href="/report/write">내 차량 신고하기</a>
                </div>
            </div>
        </div>

        <div class="hero-dots" role="tablist" aria-label="슬라이드 선택">
            <button class="dot" aria-label="1번 슬라이드"></button>
            <button class="dot" aria-label="2번 슬라이드"></button>
            <button class="dot" aria-label="3번 슬라이드"></button>
        </div>
    </div>
</section>

<section class="section-steps">
    <div class="container">
        <h3>리콜 절차 및 서비스 안내</h3>
        <p class="sub">조회부터 수리 완료까지, 3단계로 간단하게 이용하세요.</p>

        <div class="steps-timeline" aria-hidden="true">
            <span class="dot active"></span><span class="bar"></span>
            <span class="dot"></span><span class="bar"></span>
            <span class="dot"></span>
        </div>

        <div class="card-grid">
            <article class="card">
                <div class="icon-badge" aria-hidden="true">🔎</div>
                <h4>리콜 조회</h4>
                <p>차량번호/VIN으로 즉시 리콜 여부를 확인하세요.</p>
                <a class="more" href="/recall-status">자세히 보기</a>
            </article>
            <article class="card">
                <div class="icon-badge" aria-hidden="true">📅</div>
                <h4>서비스 예약</h4>
                <p>대상 차량이면 가까운 리콜센터 예약 안내를 드립니다.</p>
                <a class="more" href="/centers/about">예약 절차</a>
            </article>
            <article class="card">
                <div class="icon-badge" aria-hidden="true">🛡️</div>
                <h4>안전 보장</h4>
                <p>정부 인증 시스템을 통해 무료 수리를 제공합니다.</p>
                <a class="more" href="/faq/list">FAQ 보기</a>
            </article>
        </div>
    </div>
</section>


<section class="section-hub">
    <div class="container">
        <nav class="hub-grid" aria-label="주요 서비스 바로가기">
            <a class="hub-card" href="/report/write">
                    <span class="hub-icon" aria-hidden="true">
                        <svg viewBox="0 0 24 24" fill="none"><path d="M9 5h6m-3-3v6M6 9h12v10a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2V9z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>
                    </span>
                <div class="hub-text">
                    <strong>결함신고</strong>
                    <span>비회원 제출, 약 5분</span>
                </div>
            </a>

            <a class="hub-card" href="/report/history">
                    <span class="hub-icon" aria-hidden="true">
                        <svg viewBox="0 0 24 24" fill="none"><path d="M3 7h6l2 2h10v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7z" stroke="currentColor" stroke-width="1.5"/></svg>
                    </span>
                <div class="hub-text">
                    <strong>신고내역</strong>
                    <span>접수/처리 단계 조회</span>
                </div>
            </a>

            <a class="hub-card" href="/recall-status">
                    <span class="hub-icon" aria-hidden="true">
                        <svg viewBox="0 0 24 24" fill="none"><path d="M4 19V5m16 14H4m3-4v4m5-8v8m5-6v6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>
                    </span>
                <div class="hub-text">
                    <strong>리콜현황</strong>
                    <span>제조사/모델/월별 통계</span>
                </div>
            </a>

            <a class="hub-card" href="/notice/list">
                    <span class="hub-icon" aria-hidden="true">
                        <svg viewBox="0 0 24 24" fill="none"><path d="M3 11l14-6v14L3 13v-2zM9 13v5a3 3 0 0 0 3 3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    </span>
                <div class="hub-text">
                    <strong>공지/FAQ</strong>
                    <span>이용 안내/점검 공지</span>
                </div>
            </a>
        </nav>
    </div>
</section>


<section class="section-news">
    <div class="container">
        <div class="news-head">
            <h3>최근 소식</h3>
            <a class="news-more" href="/notice/list">전체 보기</a>
        </div>
        <ul id="newsList" class="news-list" aria-live="polite">
            <c:forEach var="notice" items="${noticeList}" varStatus="status">
                <c:if test="${status.index < 5}">
                    <li class="news-item">
                        <span class="tag notice">공지</span>
                        <a href="/notice/detail?notice_id=${notice.notice_id}">${notice.title}</a>
                        <time datetime="${notice.created_at}">
                            <fmt:parseDate value="${notice.created_at}" pattern="yyyy-MM-dd" var="parsedNoticeDate" type="date"/>
                            <fmt:formatDate value="${parsedNoticeDate}" pattern="yyyy-MM-dd"/>
                        </time>
                    </li>
                </c:if>
            </c:forEach>
            <c:forEach var="press" items="${pressList}" varStatus="status">
                <c:if test="${status.index < 5}">
                    <li class="news-item">
                        <span class="tag press">보도자료</span>
                        <a href="/press/detail?boardNo=${press.boardNo}">${press.boardTitle}</a>
                        <time datetime="${press.boardDate}">
                            <fmt:parseDate value="${press.boardDate}" pattern="yyyy-MM-dd" var="parsedPressDate" type="date"/>
                            <fmt:formatDate value="${parsedPressDate}" pattern="yyyy-MM-dd"/>
                        </time>
                    </li>
                </c:if>
            </c:forEach>
            <c:if test="${empty noticeList and empty pressList}">
                <li class="news-item no-items">
                    최신 소식이 없습니다.
                </li>
            </c:if>
        </ul>
    </div>
</section>

<section class="trust-strip" aria-label="신뢰 및 운영 안내">
    <div class="container strip-grid">
        <div class="strip-item">
            <span class="strip-dot" aria-hidden="true"></span>
            <div>
                <strong>공공 데이터 연계</strong><span>최신 현황 자동 반영</span>
            </div>
        </div>
        <div class="strip-item">
            <span class="strip-dot" aria-hidden="true"></span>
            <div>
                <strong>개인정보 보호</strong><span>암호화 저장·접근 통제</span>
            </div>
        </div>
        <div class="strip-item">
            <span class="strip-dot" aria-hidden="true"></span>
            <div>
                <strong>고객센터</strong><span>평일 09:00–18:00</span>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

<script src="/js/main.js"></script>
</body>
</html>