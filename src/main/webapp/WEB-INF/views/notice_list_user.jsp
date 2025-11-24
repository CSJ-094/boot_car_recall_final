<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<link rel="stylesheet" href="/css/notice_user.css" />
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/header.css" />
<link rel="stylesheet" href="/css/footer.css" />


<jsp:include page="/WEB-INF/views/fragment/header.jsp"/>
<main class="nu">
  <section class="nu-wrap">
    <header class="nu-head">
      <h1 class="nu-title">공지사항</h1>
      <p class="nu-desc">리콜센터의 중요한 안내를 빠르게 확인하세요.</p>
    </header>

    <div class="nu-table-wrap">
      <table class="nu-table">
        <colgroup>
          <col style="width:110px"/>
          <col/>
          <col style="width:160px"/>
          <col style="width:110px"/>
        </colgroup>
        <thead>
          <tr>
            <th scope="col">번호</th>
            <th scope="col">제목</th>
            <th scope="col">작성일</th>
            <th scope="col">조회수</th>
          </tr>
        </thead>
        <tbody>
        <c:if test="${empty list}">
          <tr class="nu-empty">
            <td colspan="4">등록된 공지사항이 없습니다.</td>
          </tr>
        </c:if>

        <c:forEach var="item" items="${list}">
          <tr class="nu-row" data-href="${ctx}/notice/${item.notice_id}">
            <td class="nu-cell--center">${item.notice_id}</td>
            <td class="nu-cell--left">
              <c:if test="${item.is_urgent == 'Y'}">
                <span class="nu-chip nu-chip--danger" aria-label="필독">필독</span>
              </c:if>
              <a href="${ctx}/notice/${item.notice_id}" class="nu-link">
                ${item.title}
              </a>
            </td>
            <td class="nu-cell--center">${item.created_at}</td>
            <td class="nu-cell--center">${item.views}</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>

    <nav class="nu-paging" aria-label="공지 목록 페이지 이동">
      <ul>
        <c:if test="${pageMaker.prev}">
          <li><a class="nu-page" href="${ctx}/notice/list?pageNum=${pageMaker.startPage - 1}">이전</a></li>
        </c:if>

        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
          <li>
            <a class="nu-page ${pageMaker.cri.pageNum == num ? 'is-active' : ''}"
               href="${ctx}/notice/list?pageNum=${num}">${num}</a>
          </li>
        </c:forEach>

        <c:if test="${pageMaker.next}">
          <li><a class="nu-page" href="${ctx}/notice/list?pageNum=${pageMaker.endPage + 1}">다음</a></li>
        </c:if>
      </ul>
    </nav>
  </section>
</main>

<jsp:include page="/WEB-INF/views/fragment/footer.jsp"/>

<script>
  // 행 클릭으로 상세 이동
  document.querySelectorAll('.nu-row').forEach(tr=>{
    tr.addEventListener('click', ()=> {
      const href = tr.getAttribute('data-href');
      if(href){ location.href = href; }
    });
  });
</script>
