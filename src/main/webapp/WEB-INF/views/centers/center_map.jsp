<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

<!-- 카카오 지도 SDK (반드시 kakao 객체 쓰기 전에 로드) -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f08a719a533ce4c77b85bb7a496e7b8&libraries=services"></script>

<!-- 페이지 전용 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/center_map.css" />
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/header.css" />
<link rel="stylesheet" href="/css/footer.css" />

<main class="content-body">
    <section class="content-area">
        <h2>주변 리콜센터 / 정비소 찾기</h2>

        <div class="center-page-wrap">

            <!-- 상단 필터 -->
            <div class="center-filter-row">
                <label>제조사</label>
                <select id="manufacturerSelect">
                    <option value="">전체</option>
                    <c:forEach var="m" items="${manufacturers}">
                        <option value="${m}">${m}</option>
                    </c:forEach>
                </select>

                <label>반경</label>
                <select id="radiusSelect">
                    <option value="3000">3km</option>
                    <option value="5000" selected>5km</option>
                    <option value="10000">10km</option>
                </select>

                <button id="btnMyLocation" class="btn-primary">내 위치 기준 검색</button>
            </div>

            <!-- 하단 지도 + 리스트 -->
            <div class="center-content-row">
                <div class="center-map-area">
                    <div id="map"></div>
                </div>
                <div class="center-list-area" id="centerList">
                    주변 리콜센터를 검색하려면 [내 위치 기준 검색] 버튼을 눌러 주세요.
                </div>
            </div>
        </div>
    </section>
</main>

<!-- 공통 푸터 -->
<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

<!-- 페이지 전용 JS -->
<script src="/js/center_map.js"></script>

