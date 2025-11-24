<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/fragment/header.jsp"/>

<link rel="stylesheet" href="/css/faq.css" />

<main class="fq">
  <section class="fq-wrap">
    <nav class="fq-breadcrumb" aria-label="경로">
      <a href="${ctx}/" class="fq-crumb">홈</a>
      <span class="fq-crumb-sep">/</span>
      <a href="${ctx}/faq/list" class="fq-crumb">FAQ</a>
    </nav>

    <article class="fq-card">
      <header class="fq-card-head">
        <h1 class="fq-card-title">
          <span class="fq-chip">${faq.category}</span>
          ${faq.question}
        </h1>
        <ul class="fq-meta">
          <li><strong>작성일</strong> <span>${faq.created_at}</span></li>
        </ul>
      </header>

      <div class="fq-content">
        <pre class="fq-a-text"><c:out value="${faq.answer}"/></pre>
      </div>

      <footer class="fq-card-foot">
        <a href="${ctx}/faq/list" class="fq-btn">목록으로</a>
      </footer>
    </article>
  </section>
</main>

<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>
