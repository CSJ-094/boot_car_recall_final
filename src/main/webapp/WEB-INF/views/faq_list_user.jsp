<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

<link rel="stylesheet" href="/css/faq.css" />
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/header.css" />
<link rel="stylesheet" href="/css/footer.css" />

<main class="fq">
  <section class="fq-wrap">
    <header class="fq-head">
      <div class="fq-head-text">
        <h1 class="fq-title">자주 묻는 질문 (FAQ)</h1>
        <p class="fq-desc">자주 받는 질문을 모았습니다. 질문을 클릭하면 답변이 펼쳐집니다.</p>
      </div>
    </header>

    <!-- 아코디언 목록 -->
    <div class="fq-accordion" id="faqList">
      <c:if test="${empty list}">
        <div class="fq-empty">등록된 FAQ가 없습니다.</div>
      </c:if>

      <c:forEach var="item" items="${list}">
        <article class="fq-item" data-id="${item.faq_id}">
          <button type="button" class="fq-q" aria-expanded="false" aria-controls="fq-a-${item.faq_id}">
            <span class="fq-chip">${item.category}</span>
            <span class="fq-q-text">${item.question}</span>
            <span class="fq-arrow" aria-hidden="true">▾</span>
          </button>
          <div id="fq-a-${item.faq_id}" class="fq-a" role="region" aria-hidden="true">
            <div class="fq-a-inner">
              <pre class="fq-a-text"><c:out value="${item.answer}"/></pre>
              <div class="fq-meta"><strong>작성일</strong> <span>${item.created_at}</span></div>
            </div>
          </div>
        </article>
      </c:forEach>
    </div>

    <!-- 하단 영역: 페이지네이션 및 문의하기 버튼 -->
    <div class="fq-footer">
      <!-- 페이지네이션 -->
      <nav class="fq-paging" aria-label="FAQ 페이지 이동">
        <ul>
          <c:if test="${pageMaker.prev}">
            <li><a class="fq-page" href="${ctx}/faq/list?pageNum=${pageMaker.startPage - 1}">이전</a></li>
          </c:if>
          <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li>
              <a class="fq-page ${pageMaker.cri.pageNum == num ? 'is-active' : ''}"
                 href="${ctx}/faq/list?pageNum=${num}">${num}</a>
            </li>
          </c:forEach>
          <c:if test="${pageMaker.next}">
            <li><a class="fq-page" href="${ctx}/faq/list?pageNum=${pageMaker.endPage + 1}">다음</a></li>
          </c:if>
        </ul>
      </nav>
      <!-- 문의하기 버튼 -->
      <div class="fq-footer-action">
        <a href="${ctx}/complain_list" class="fq-btn">문의하기</a>
      </div>
    </div>
  </section>
</main>

<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

<script>
  // 접근성 고려한 순수 JS 아코디언
  document.querySelectorAll('.fq-q').forEach(btn => {
    btn.addEventListener('click', () => {
      const expanded = btn.getAttribute('aria-expanded') === 'true';
      const panel = document.getElementById(btn.getAttribute('aria-controls'));

      // 토글
      btn.setAttribute('aria-expanded', String(!expanded));
      panel.setAttribute('aria-hidden', String(expanded));
      btn.parentElement.classList.toggle('is-open', !expanded);
    });
  });
</script>
