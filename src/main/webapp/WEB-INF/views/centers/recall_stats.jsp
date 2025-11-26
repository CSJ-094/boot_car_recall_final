<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

<!-- 페이지 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/recall_stats.css" />
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/header.css" />
<link rel="stylesheet" href="/css/footer.css" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<main class="recall-stats-page">
    <!-- 필터 영역 -->
    <section class="filter-area">
        <h2 class="page-title">리콜 통계</h2>

        <div class="groupby-tabs">
            <button type="button" class="tab-btn is-active" data-groupby="MANUFACTURER">제조사 기준</button>
            <button type="button" class="tab-btn" data-groupby="MODEL">모델 기준</button>
        </div>

        <div class="filter-grid">
            <div class="filter-item">
                <label>기간</label>
                <div class="filter-inline">
                    <input type="date" id="startDate">
                    <span class="tilde">~</span>
                    <input type="date" id="endDate">
                </div>
            </div>

            <div class="filter-item">
                <label>시간 단위</label>
                <select id="timeUnit">
                    <option value="MONTH">월별</option>
                    <option value="QUARTER">분기별</option>
                    <option value="HALF_YEAR">상·하반기</option>
                </select>
            </div>

            <div class="filter-item">
                <label>제조사</label>
                <input type="text" id="maker" placeholder="제조사명 입력">
            </div>

            <div class="filter-item">
                <label>모델 검색</label>
                <input type="text" id="modelKeyword" placeholder="모델명 일부를 입력하세요">
            </div>
        </div>

        <div class="filter-actions">
            <button type="button" id="btnSearch" class="btn-primary">검색하기</button>
        </div>
    </section>

    <!-- 탭 -->
    <section class="result-tabs">
        <button type="button" class="result-tab is-active" data-tab="table">통계 리스트</button>
        <button type="button" class="result-tab" data-tab="chart">그래프</button>
    </section>

    <!-- 결과 영역 -->
    <section class="result-area">

        <!-- 표 -->
        <div id="tableView" class="result-view is-active">
            <div class="result-summary" id="resultSummary"></div>
			<table class="stats-table">
				<thead>
				  <tr>
				    <th>제조사</th>
				    <th id="thModelName">모델명</th>
				    <th>기간</th>
				    <th>리콜 건수</th>
				  </tr>
				</thead>
				<tbody id="statsTableBody"></tbody>
			</table>
            <div class="table-footer">
                <button type="button" id="btnShowAll" class="btn-outline">전체 목록 보기</button>
            </div>
        </div>

        <!-- 차트 -->
        <div id="chartView" class="result-view">
            <div class="result-summary" id="chartSummary"></div>
            <canvas id="statsChart"></canvas>
        </div>

    </section>
</main>

<!-- 공통 푸터 -->
<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

<!-- 페이지 전용 JS -->
<script src="/js/recall_stats.js"></script>
