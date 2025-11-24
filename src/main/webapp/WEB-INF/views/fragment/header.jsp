<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/header.css" />

<header class="site-header">
    <div class="header-inner">
        <a class="brand" href="/">
            <img src="/img/car.png" class="brand-logo" alt="자동차 아이콘">
            <span class="brand-text">자동차 리콜 통합센터</span>
        </a>

        <!-- 모바일 메뉴 토글 -->
        <button class="nav-toggle" aria-controls="global-nav" aria-expanded="false" aria-label="메뉴 열기">
            <span class="bar"></span><span class="bar"></span><span class="bar"></span>
        </button>

        <nav id="global-nav" class="nav" aria-label="주 메뉴">
            <ul class="menu">
                <!-- 결함신고 -->
                <li class="menu-item has-sub">
                    <a href="/report/write" class="menu-link">결함신고</a>
                    <ul class="submenu">
                        <li><a href="/report/write">신고</a></li>
                        <li><a href="/report/history">신고내역</a></li>
                    </ul>
                </li>

                <!-- 리콜정보 -->
                <li class="menu-item has-sub">
                    <a href="/recall-status" class="menu-link">리콜정보</a>
                    <ul class="submenu">
                        <li><a href="/recall-status">리콜현황</a></li>
                        <li><a href="/board/list">리콜 보도자료</a></li>
                    </ul>
                </li>

                <!-- 리콜센터 (공지사항 리스트를 메인으로) -->
                <li class="menu-item has-sub">
                    <a href="/notice/list" class="menu-link">리콜센터</a>
                    <ul class="submenu">
                        <li><a href="/notice/list">공지사항</a></li>
                        <li><a href="/faq/list">FAQ</a></li>
                        <li><a href="/centers/about">리콜센터 소개</a></li>
                    </ul>
                </li>

                <!-- 관리자 로그인페이지 이동 -->
                <li class="menu-item has-sub">
                    <a href="/admin/login" class="menu-link">관리자</a>
                </li>
            </ul>
        </nav>
    </div>
</header>
<script src="/js/header.js"></script>