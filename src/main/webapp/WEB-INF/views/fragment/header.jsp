<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" href="/css/header.css" />
<style>
    .notification-badge {
        background-color: #dc3545;
        color: white;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 0.75rem;
        font-weight: bold;
        vertical-align: top;
        margin-left: 4px;
    }
    .header-search {
        display: flex;
        align-items: center;
        margin-left: auto;
        margin-right: 20px;
    }
    .header-search input {
        border: 1px solid #ccc;
        padding: 8px;
        border-radius: 4px;
        margin-right: 5px;
    }
    .header-search button {
        padding: 8px 12px;
        border: none;
        background-color: #007bff;
        color: white;
        border-radius: 4px;
        cursor: pointer;
    }
</style>

<header class="site-header">
    <div class="header-inner">
        <a class="brand" href="/">
            <img src="/img/car.png" class="brand-logo" alt="자동차 아이콘">
            <span class="brand-text">자동차 리콜 통합센터</span>
        </a>

        <!-- 통합 검색창 -->
        <div class="header-search">
            <form action="/search" method="get">
                <input type="text" name="query" placeholder="통합 검색..." value="${results.query}" />
                <button type="submit">검색</button>
            </form>
        </div>

        <!-- 모바일 메뉴 토글 -->
        <button class="nav-toggle" aria-controls="global-nav" aria-expanded="false" aria-label="메뉴 열기">
            <span class="bar"></span><span class="bar"></span><span class="bar"></span>
        </button>

        <nav id="global-nav" class="nav" aria-label="주 메뉴">
            <ul class="menu">
                <sec:authorize access="hasRole('ADMIN')">
                    <!-- 관리자 메뉴 -->
                    <li class="menu-item has-sub">
                        <a href="/admin/main" class="menu-link">관리자 홈</a>
                        <ul class="submenu">
                            <li><a href="/admin/defect_reports">결함 신고 관리</a></li>
                            <li><a href="/admin/notice/list">공지사항 관리</a></li>
                            <li><a href="/admin/faq/list">FAQ 관리</a></li>
                            <li><a href="/admin/press/list">보도자료 관리</a></li>
                            <li><a href="/admin/complain/list">고객 문의 관리</a></li>
                        </ul>
                    </li>
                </sec:authorize>

                <sec:authorize access="!hasRole('ADMIN')">
                    <!-- 일반 사용자 메뉴 -->
                    <li class="menu-item has-sub">
                        <a href="/report/write" class="menu-link">결함신고</a>
                        <ul class="submenu">
                            <li><a href="/report/write">신고</a></li>
                            <li><a href="/report/history">신고내역</a></li>
                        </ul>
                    </li>
                    <li class="menu-item has-sub">
                        <a href="/recall-status" class="menu-link">리콜정보</a>
                        <ul class="submenu">
                            <li><a href="/recall-status">리콜현황</a></li>
                            <li><a href="/board/list">리콜 보도자료</a></li>
                            <li><a href="/recall/stats">리콜 통계</a></li>
                        </ul>
                    </li>
                    <li class="menu-item has-sub">
                        <a href="/notice/list" class="menu-link">리콜센터</a>
                        <ul class="submenu">
                            <li><a href="/notice/list">공지사항</a></li>
                            <li><a href="/faq/list">FAQ</a></li>
                            <li><a href="/centers/about">리콜센터 소개</a></li>
                            <li><a href="/centers/map">주변 리콜센터 찾기</a></li>
                        </ul>
                    </li>
                    <sec:authorize access="isAuthenticated()">
                        <li class="menu-item">
                            <a href="/my-vehicles" class="menu-link">내 차량 관리</a>
                        </li>
                        <li class="menu-item">
                            <a href="/my-notifications" class="menu-link">
                                내 알림
                                <c:if test="${unreadNotificationCount > 0}">
                                    <span class="notification-badge">${unreadNotificationCount}</span>
                                </c:if>
                            </a>
                        </li>
                    </sec:authorize>
                </sec:authorize>

                <sec:authorize access="isAuthenticated()">
                    <li class="menu-item">
                        <form action="/logout" method="post" style="display: inline;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" class="menu-link" style="background: none; border: none; color: inherit; cursor: pointer; padding: 0;">로그아웃</button>
                        </form>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <li class="menu-item">
                        <a href="/login" class="menu-link">로그인</a>
                    </li>
                </sec:authorize>
            </ul>
        </nav>
    </div>
</header>
<script src="/js/header.js"></script>