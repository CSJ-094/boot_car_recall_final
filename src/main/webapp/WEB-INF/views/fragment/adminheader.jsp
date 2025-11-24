<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/header.css" />

<header class="site-header">
    <div class="header-inner">
        <a class="brand" href="/admin/main" style="text-decoration: none; color: inherit;">
            <img src="/img/car.png" class="brand-logo" alt="자동차 아이콘">
            <span class="brand-text">자동차 리콜 통합센터 <span class="admin-badge">관리자 페이지</span></span>
        </a>

        <!-- 모바일 메뉴 토글 -->
        <button class="nav-toggle" aria-controls="global-nav" aria-expanded="false" aria-label="메뉴 열기">
            <span class="bar"></span><span class="bar"></span><span class="bar"></span>
        </button>

        <nav id="global-nav" class="nav" aria-label="주 메뉴">
            <ul class="menu">
                <!-- 대시보드 -->
                <li class="menu-item">
                    <a href="/admin/main" class="menu-link">대시보드</a>
                </li>

                <!-- 신고 관리 -->
                <li class="menu-item has-sub">
                    <a href="/admin/complain/list" class="menu-link">문의 관리</a>
                    <ul class="submenu">
                        <li><a href="/admin/complain/list">고객 문의</a></li>
                    </ul>
                </li>

                <!-- 컨텐츠 관리 -->
                <li class="menu-item has-sub">
                    <a href="/admin/notice/list" class="menu-link">컨텐츠 관리</a>
                    <ul class="submenu">
                        <li><a href="/admin/notice/list">공지사항</a></li>
                        <li><a href="/admin/faq/list">FAQ</a></li>
                        <li><a href="/admin/press/list">보도자료</a></li>
                    </ul>
                </li>

                <!-- 로그아웃 -->
                <c:if test="${not empty sessionScope.admin}">
                    <li class="menu-item">
                        <a href="/admin/logout" class="menu-link logout-link">로그아웃</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</header>
<script src="/js/header.js"></script>